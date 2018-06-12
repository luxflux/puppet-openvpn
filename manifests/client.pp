# == Define: openvpn::client
#
# This define creates the client certs for a specified openvpn server as well
# as creating a tarball that can be directly imported into openvpn clients
#
#
# === Parameters
#
# [*server*]
#   String.  Name of the corresponding openvpn endpoint
#   Required
#
# [*compression*]
#   String.  Which compression algorithim to use
#   Default: comp-lzo
#   Options: comp-lzo or '' (disable compression)
#
# [*dev*]
#   String.  Device method
#   Default: tun
#   Options: tun (routed connections), tap (bridged connections)
#
# [*mute*]
#   Integer.  Set log mute level
#   Default: 20
#
# [*mute_replay_warnings*]
#   Boolean.  Silence duplicate packet warnings (common on wireless networks)
#   Default: true
#
# [*nobind*]
#   Boolean.  Whether or not to bind to a specific port number
#   Default: true
#
# [*persist_key*]
#   Boolean.  Try to retain access to resources that may be unavailable
#     because of privilege downgrades
#   Default: true
#
# [*persist_tun*]
#   Boolean.  Try to retain access to resources that may be unavailable
#     because of privilege downgrades
#   Default: true
#
# [*port*]
#   Integer.  The port the openvpn server service is running on
#   Default: 1194
#
# [*proto*]
#   String.  What IP protocol is being used.
#   Default: tcp
#   Options: tcp or udp
#
# [*remote_host*]
#   String/Array.  The IP or hostname of the openvpn server service.
#   Default: FQDN
#
# [*cipher*]
#   String,  Cipher to use for packet encryption
#   Default: AES-256-CBC
#
# [*tls_cipher*]
#   String, TLS Ciphers to use
#   Default: TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256:TLS-DHE-RSA-WITH-AES-128-CBC-SHA256
#
# [*resolv_retry*]
#   Integer/String. How many seconds should the openvpn client try to resolve
#     the server's hostname
#   Default: infinite
#   Options: Integer or infinite
#
# [*auth_retry*]
#   String. Controls how OpenVPN responds to username/password verification
#     errors such as the client-side response to an AUTH_FAILED message from
#     the server or verification failure of the private key password.
#   Default: none
#   Options: 'none' or 'nointeract' or 'interact'
#
# [*verb*]
#   Integer.  Level of logging verbosity
#   Default: 3
#
# [*pam*]
#   DEPRECATED: Boolean, Enable/Disable.
#
# [*authuserpass*]
#   Boolean. Set if username and password required
#   Default: false
#
# [*tls_auth*]
#   Boolean. Activates tls-auth to Add an additional layer of HMAC
#     authentication on top of the TLS control channel to protect
#     against DoS attacks. This has to be set to the same value as on the
#     Server
#   Default: false
#
# [*x509_name*]
#   Common name of openvpn server to make an x509-name verification
#   Default: undef
#
# [*setenv*]
#   Hash. Set a custom environmental variable name=value to pass to script.
#   Default: {}
#
# [*setenv_safe*]
#   Hash. Set a custom environmental variable OPENVPN_name=value to pass to
#     script. This directive is designed to be pushed by the server to clients,
#     and the prepending of "OPENVPN_" to the environmental variable is a
#     safety precaution to prevent a LD_PRELOAD style attack from a malicious
#     or compromised server.
#   Default: {}
#
# [*up*]
#   String,  Script which we want to run when openvpn client is connecting
#
# [*down*]
#   String,  Script which we want to run when openvpn client is disconneting
#
# [*sndbuf*]
#   Integer, Set the TCP/UDP socket send buffer size.
#   Default: undef
#
# [*rcvbuf*]
#   Integer, Set the TCP/UDP socket receive buffer size.
#   Default: undef
#
# [*shared_ca*]
#   String,  The name of an openssl::ca resource to use.
#   Default: undef
#
# [*custom_options*]
#   Hash of additional options that you want to append to the configuration file.
#
# [*expire*]
#   Integer. Set a custom expiry time to pass to script. Value is the number of
#   days the certificate is valid for.
#   Default: undef
#
# [*readme*]
#   String. Text to place in a README file which is included in download-configs
#   archive.
#   Default: undef
#
# [*pull*]
#   Boolean. Allow server to push options like dns or routes
#   Default: false
#
# [*server_extca_enabled*]
#   Boolean. Turn this on if you are using an external CA solution, like FreeIPA.
#            Use this in Combination with exported_ressourced, since they don't have Access to the Serverconfig
#   Default: false
#
# [*ns_cert_type*]
#   Boolean. Enable or disable use of ns-cert-type.
#   Deprecated in OpenVPN 2.4 and replaced with remote-cert-tls
#   Default: true
#
# [*remote_cert_tls*]
#   Boolean. Enable or disable use of remote-cert-tls
#   used with client configuration
#   Default: false
# === Examples
#
#   openvpn::client {
#     'my_user':
#       server      => 'contractors',
#       remote_host => 'vpn.mycompany.com'
#    }
#
# * Removal:
#     Manual process right now, todo for the future
#
#
# === Authors
#
# * Raffael Schmid <mailto:raffael@yux.ch>
# * John Kinsella <mailto:jlkinsel@gmail.com>
# * Justin Lambert <mailto:jlambert@letsevenup.com>
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
define openvpn::client (
  String $server,
  String $compression                         = 'comp-lzo',
  String $dev                                 = 'tun',
  Integer $mute                               = 20,
  Boolean $mute_replay_warnings               = true,
  Boolean $nobind                             = true,
  Boolean $persist_key                        = true,
  Boolean $persist_tun                        = true,
  String $port                                = '1194',
  String $proto                               = 'tcp',
  Variant[String, Array[String]] $remote_host = $::fqdn,
  String $resolv_retry                        = 'infinite',
  String $auth_retry                          = 'none',
  String $verb                                = '3',
  Boolean $pam                                = false,
  String $cipher                              = 'AES-256-CBC',
  String $tls_cipher                          = 'TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256:TLS-DHE-RSA-WITH-AES-128-CBC-SHA256',
  Boolean $authuserpass                       = false,
  Hash $setenv                                = {},
  Hash $setenv_safe                           = {},
  String $up                                  = '',
  String $down                                = '',
  Boolean $tls_auth                           = false,
  Optional[String] $x509_name                 = undef,
  Optional[Integer] $sndbuf                   = undef,
  Optional[Integer] $rcvbuf                   = undef,
  Optional[String] $shared_ca                 = undef,
  Optional[String] $mail_address              = undef,
  Optional[String] $mail_from 	              = undef,
  Hash $custom_options                        = {},
  Optional[Integer] $expire                   = undef,
  Optional[String] $readme                    = undef,
  Boolean $pull                               = false,
  Boolean $server_extca_enabled               = false,
  Boolean $ns_cert_type                       = true,
  Boolean $remote_cert_tls                    = false,
) {

  if $pam {
    warning('Using $pam is deprecated. Use $authuserpass instead!')
  }

  Openvpn::Server[$server]
  -> Openvpn::Client[$name]

  $extca_enabled = pick(getparam(Openvpn::Server[$server], 'extca_enabled'), $server_extca_enabled)
  if $extca_enabled { fail('cannot currently create client configs when corresponding openvpn::server is extca_enabled') }

  $ca_name = pick($shared_ca, $server)
  Openvpn::Ca[$ca_name]
  -> Openvpn::Client[$name]

  $etc_directory = $::openvpn::params::etc_directory

  if $expire {
    if is_integer($expire) {
      $env_expire = "KEY_EXPIRE=${expire}"
    } else {
      warning("Custom expiry time ignored: only integer is accepted but ${expire} is given.")
    }
  } else {
    $env_expire = ''
  }

  exec { "generate certificate for ${name} in context of ${ca_name}":
    command  => ". ./vars && ${env_expire} ./pkitool ${name}",
    cwd      => "${etc_directory}/openvpn/${ca_name}/easy-rsa",
    creates  => "${etc_directory}/openvpn/${ca_name}/easy-rsa/keys/${name}.crt",
    provider => 'shell';
  }

  file { [ "${etc_directory}/openvpn/${server}/download-configs/${name}",
    "${etc_directory}/openvpn/${server}/download-configs/${name}/keys",
    "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}" ]:
    ensure => directory,
  }

  file { "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.crt":
    ensure  => link,
    target  => "${etc_directory}/openvpn/${ca_name}/easy-rsa/keys/${name}.crt",
    require => Exec["generate certificate for ${name} in context of ${ca_name}"],
  }

  file { "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.key":
    ensure  => link,
    target  => "${etc_directory}/openvpn/${ca_name}/easy-rsa/keys/${name}.key",
    require => Exec["generate certificate for ${name} in context of ${ca_name}"],
  }

  file { "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/ca.crt":
    ensure  => link,
    target  => "${etc_directory}/openvpn/${ca_name}/easy-rsa/keys/ca.crt",
    require => Exec["generate certificate for ${name} in context of ${ca_name}"],
  }

  if $tls_auth {
    file { "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/ta.key":
      ensure  => link,
      target  => "${etc_directory}/openvpn/${server}/easy-rsa/keys/ta.key",
      require => Exec["generate certificate for ${name} in context of ${server}"],
      before  => [
        Exec["tar the thing ${server} with ${name}"],
        Concat["${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn"],
      ],
      notify  => Exec["tar the thing ${server} with ${name}"],
    }
  }

  if $readme {
    file { "${etc_directory}/openvpn/${server}/download-configs/${name}/README":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0444',
      content => $readme,
      notify  => Exec["tar the thing ${server} with ${name}"];
    }
  }
  
  exec { "mail ${name} to ${mail_address}":
      cwd         => "${etc_directory}/openvpn/${server}/download-configs/",
      command     => "/opt/scripts/send_mail.py -s ${mail_from} -r  ${mail_address} -f ${name}.ovpn",
      refreshonly => true,
      require     => [
        File["${etc_directory}/openvpn/${server}/download-configs/${name}/${name}.conf"],
        File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/ca.crt"],
        File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.key"],
        File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.crt"],
        Concat["${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn"],
      ],
  }

  file {
    "${etc_directory}/openvpn/${server}/download-configs/${name}.tblk":
      ensure => directory;

    "${etc_directory}/openvpn/${server}/download-configs/${name}.tblk/${name}.ovpn":
      ensure  => link,
      target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
      require => [
        Concat["${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn"],
        File["${etc_directory}/openvpn/${server}/download-configs/${name}.tblk"],
      ],
      before  => Exec["tar the thing ${server} with ${name}"];
  }

  file { "${etc_directory}/openvpn/${server}/download-configs/${name}/${name}.conf":
    owner   => root,
    group   => $::openvpn::params::root_group,
    mode    => '0444',
    content => template('openvpn/client.erb', 'openvpn/client_external_auth.erb'),
  }

  exec { "tar the thing ${server} with ${name}":
    cwd         => "${etc_directory}/openvpn/${server}/download-configs/",
    command     => "/bin/rm ${name}.tar.gz; tar --exclude=\\*.conf.d -chzvf ${name}.tar.gz ${name} ${name}.tblk",
    refreshonly => true,
    require     => [
      File["${etc_directory}/openvpn/${server}/download-configs/${name}/${name}.conf"],
      File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/ca.crt"],
      File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.key"],
      File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.crt"],
      Concat["${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn"],
      File["${etc_directory}/openvpn/${server}/download-configs/${name}.tblk"],
      File["${etc_directory}/openvpn/${server}/download-configs/${name}.tblk/${name}.ovpn"],
    ],
    notify  => Exec["mail ${name} to ${mail_address}"];
  }

  concat { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn":
    mode    => '0400',
    notify  => Exec["tar the thing ${server} with ${name}"],
    require => [
      File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/ca.crt"],
      File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.key"],
      File["${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.crt"],
    ],
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/client_config":
    target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    content => template('openvpn/client.erb'),
    order   => '01',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/ca_open_tag":
    target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    content => "# Authentication \n<ca>\n",
    order   => '02',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/ca":
    target => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    source => "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/ca.crt",
    order  => '03',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/ca_close_tag":
    target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    content => "</ca>\n",
    order   => '04',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/key_open_tag":
    target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    content => "<key>\n",
    order   => '05',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/key":
    target => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    source => "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.key",
    order  => '06',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/key_close_tag":
    target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    content => "</key>\n",
    order   => '07',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/cert_open_tag":
    target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    content => "<cert>\n",
    order   => '08',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/cert":
    target => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    source => "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/${name}.crt",
    order  => '09',
  }

  concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/cert_close_tag":
    target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
    content => "</cert>\n",
    order   => '10',
  }

  if $tls_auth {
    concat::fragment { "/etc/openvpn/${server}/download-configs/${name}.ovpn/tls_auth_open_tag":
      target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
      content => "<tls-auth>\n",
      order   => '11',
    }

    concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/tls_auth":
      target => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
      source => "${etc_directory}/openvpn/${server}/download-configs/${name}/keys/${name}/ta.key",
      order  => '12',
    }

    concat::fragment { "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn/tls_auth_close_tag":
      target  => "${etc_directory}/openvpn/${server}/download-configs/${name}.ovpn",
      content => "</tls-auth>\nkey-direction 1\n",
      order   => '13',
    }
  }
}
