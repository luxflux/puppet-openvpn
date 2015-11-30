# == Define: openvpn::ca
#
# This define creates the openvpn ca and ssl certificates.
#
# === Parameters
#
# [*country*]
#   String.  Country to be used for the SSL certificate
#
# [*province*]
#   String.  Province to be used for the SSL certificate
#
# [*city*]
#   String.  City to be used for the SSL certificate
#
# [*organization*]
#   String.  Organization to be used for the SSL certificate
#
# [*email*]
#   String.  Email address to be used for the SSL certificate
#
# [*common_name*]
#   String.  Common name to be used for the SSL certificate
#   Default: server
#
# [*group*]
#   String.  User to drop privileges to after startup
#   Default: depends on your $::osfamily
#
# [*ssl_key_size*]
#   String. Length of SSL keys (in bits) generated by this module.
#   Default: 1024
#
# [*key_expire*]
#   String.  The number of days to certify the server certificate for
#   Default: 3650
#
# [*ca_expire*]
#   String.  The number of days to certify the CA certificate for
#   Default: 3650
#
# [*key_name*]
#   String.  Value for name_default variable in openssl.cnf and
#     KEY_NAME in vars
#   Default: None
#
# [*key_ou*]
#   String.  Value for organizationalUnitName_default variable in openssl.cnf
#     and KEY_OU in vars
#   Default: None
#
# [*key_cn*]
#   String.  Value for commonName_default variable in openssl.cnf
#     and KEY_CN in vars
#   Default: None
#
# [*tls_auth*]
#   Boolean. Determins if a tls key is generated
#   Default: False
#
# [*only_dh*]
#   Boolean. If true, only build the diffie helman file, not the whole CA stuff.
#   Should be set to true if you use a custom ca.
#   Default: false
#
# === Examples
#
#   openvpn::ca {
#     'my_user':
#       server      => 'contractors',
#       remote_host => 'vpn.mycompany.com'
#    }
#
# === Authors
#
# * Raffael Schmid <mailto:raffael@yux.ch>
# * John Kinsella <mailto:jlkinsel@gmail.com>
# * Justin Lambert <mailto:jlambert@letsevenup.com>
# * Marius Rieder <mailto:marius.rieder@nine.ch>
#
# === License
#
# Copyright 2013 Raffael Schmid, <raffael@yux.ch>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
define openvpn::ca(
  $country      = undef,
  $province     = undef,
  $city         = undef,
  $organization = undef,
  $email        = undef,
  $common_name  = 'server',
  $group        = false,
  $ssl_key_size = 1024,
  $ca_expire    = 3650,
  $key_expire   = 3650,
  $key_cn       = '',
  $key_name     = '',
  $key_ou       = '',
  $tls_auth     = false,
  $only_dh      = false
) {

  include openvpn

  if (!$only_dh) {
    validate_string($country)
    validate_string($province)
    validate_string($city)
    validate_string($organization)
    validate_string($email)
  }

  $group_to_set = $group ? {
    false   => $openvpn::params::group,
    default => $group
  }

  File {
    group => $group_to_set,
  }

  $etc_directory = $::openvpn::params::etc_directory

  exec { "copy easy-rsa to openvpn config folder ${name}":
    command => "/bin/cp -r ${openvpn::params::easyrsa_source} ${etc_directory}/openvpn/${name}/easy-rsa",
    creates => "${etc_directory}/openvpn/${name}/easy-rsa",
    require => File["${etc_directory}/openvpn/${name}"],
  }

  file { [
    "${etc_directory}/openvpn/${name}/easy-rsa/clean-all",
    "${etc_directory}/openvpn/${name}/easy-rsa/build-dh",
    "${etc_directory}/openvpn/${name}/easy-rsa/pkitool",
  ]:
    ensure  => file,
    mode    => '0550',
    require => Exec["copy easy-rsa to openvpn config folder ${name}"],
  }

  file { "${etc_directory}/openvpn/${name}/easy-rsa/revoked":
    ensure  => directory,
    mode    => '0750',
    recurse => true,
    require => Exec["copy easy-rsa to openvpn config folder ${name}"],
  }

  file { "${etc_directory}/openvpn/${name}/easy-rsa/vars":
    ensure  => file,
    mode    => '0550',
    content => template('openvpn/vars.erb'),
    require => Exec["copy easy-rsa to openvpn config folder ${name}"],
  }

  exec { "generate dh param ${name}":
    command  => '. ./vars && ./clean-all && ./build-dh',
    cwd      => "${etc_directory}/openvpn/${name}/easy-rsa",
    creates  => "${etc_directory}/openvpn/${name}/easy-rsa/keys/dh${ssl_key_size}.pem",
    provider => 'shell',
    require  => File["${etc_directory}/openvpn/${name}/easy-rsa/vars"],
  }

  if (!$only_dh) {

    file { "${etc_directory}/openvpn/${name}/easy-rsa/openssl.cnf":
      require => Exec["copy easy-rsa to openvpn config folder ${name}"],
    }

    if $openvpn::params::link_openssl_cnf == true {
      File["${etc_directory}/openvpn/${name}/easy-rsa/openssl.cnf"] {
        ensure => link,
        target => "${etc_directory}/openvpn/${name}/easy-rsa/openssl-1.0.0.cnf",
        before => Exec["initca ${name}"],
      }
    }

    exec { "initca ${name}":
      command  => '. ./vars && ./pkitool --initca',
      cwd      => "${etc_directory}/openvpn/${name}/easy-rsa",
      creates  => "${etc_directory}/openvpn/${name}/easy-rsa/keys/ca.key",
      provider => 'shell',
      require  => Exec["generate dh param ${name}"],
    }

    exec { "generate server cert ${name}":
      command  => ". ./vars && ./pkitool --server ${common_name}",
      cwd      => "${etc_directory}/openvpn/${name}/easy-rsa",
      creates  => "${etc_directory}/openvpn/${name}/easy-rsa/keys/${common_name}.key",
      provider => 'shell',
      require  => Exec["initca ${name}"],
    }

    file { "${etc_directory}/openvpn/${name}/keys":
      ensure  => link,
      target  => "${etc_directory}/openvpn/${name}/easy-rsa/keys",
      require => Exec["copy easy-rsa to openvpn config folder ${name}"],
    }

    exec { "create crl.pem on ${name}":
      command  => ". ./vars && KEY_CN='' KEY_OU='' KEY_NAME='' KEY_ALTNAMES='' openssl ca -gencrl -out ${etc_directory}/openvpn/${name}/crl.pem -config ${etc_directory}/openvpn/${name}/easy-rsa/openssl.cnf",
      cwd      => "${etc_directory}/openvpn/${name}/easy-rsa",
      creates  => "${etc_directory}/openvpn/${name}/crl.pem",
      provider => 'shell',
      require  => Exec["generate server cert ${name}"],
    }

    file { "${etc_directory}/openvpn/${name}/crl.pem":
      mode    => '0640',
      group   =>  $group_to_set,
      require => Exec["create crl.pem on ${name}"],
    }

    if $tls_auth {
      exec { "generate tls key for ${name}":
        command  => 'openvpn --genkey --secret keys/ta.key',
        cwd      => "${etc_directory}/openvpn/${name}/easy-rsa",
        creates  => "${etc_directory}/openvpn/${name}/easy-rsa/keys/ta.key",
        provider => 'shell',
        require  => Exec["generate server cert ${name}"],
      }
    }

    file { "${etc_directory}/openvpn/${name}/easy-rsa/keys/crl.pem":
      ensure  => link,
      target  => "${etc_directory}/openvpn/${name}/crl.pem",
      require => Exec["create crl.pem on ${name}"],
    }
  }
}
