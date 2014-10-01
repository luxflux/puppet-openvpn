require 'spec_helper'

describe 'openvpn::server', :type => :define do

  let(:title) { 'test_server' }

  let(:facts) { {
    :ipaddress_eth0 => '1.2.3.4',
    :network_eth0   => '1.2.3.0',
    :netmask_eth0   => '255.255.255.0',
    :concat_basedir => '/var/lib/puppet/concat',
    :osfamily       => 'Debian',
    :lsbdistid      => 'Ubuntu',
    :lsbdistrelease => '12.04',
  } }

  context "creating a server with the minimum parameters" do
    let(:params) { {
      'country'       => 'CO',
      'province'      => 'ST',
      'city'          => 'Some City',
      'organization'  => 'example.org',
      'email'         => 'testemail@example.org'
    } }

    # Files associated with a server config
    it { should contain_file('/etc/openvpn/test_server').
         with(:ensure =>'directory', :mode =>'0750', :recurse =>true, :group =>'nogroup') }
    it { should contain_file('/etc/openvpn/test_server/client-configs').
         with(:ensure =>'directory', :mode =>'0750', :recurse =>true, :group =>'nogroup') }
    it { should contain_file('/etc/openvpn/test_server/download-configs').
         with(:ensure =>'directory', :mode =>'0750', :recurse =>true, :group =>'nogroup') }
    it { should contain_file('/etc/openvpn/test_server/auth').
         with(:ensure =>'directory', :mode =>'0750', :recurse =>true, :group =>'nogroup') }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/revoked').
         with(:ensure =>'directory', :mode =>'0750', :recurse =>true, :group =>'nogroup') }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars')}
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/openssl.cnf').
         with(:recurse =>nil, :group =>'nogroup') }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/keys/crl.pem').
         with(:ensure =>'link', :target =>'/etc/openvpn/test_server/crl.pem') }
    it { should contain_file('/etc/openvpn/test_server/keys').
         with(:ensure =>'link', :target =>'/etc/openvpn/test_server/easy-rsa/keys') }

    # Execs to working with certificates
    it { should contain_exec('copy easy-rsa to openvpn config folder test_server').with(
      'command' => '/bin/cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0 /etc/openvpn/test_server/easy-rsa'
    )}
    it { should contain_exec('generate dh param test_server').with_creates('/etc/openvpn/test_server/easy-rsa/keys/dh1024.pem') }
    it { should contain_exec('initca test_server') }
    it { should contain_exec('generate server cert test_server') }
    it { should contain_exec('create crl.pem on test_server') }

    # VPN server config file itself
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^mode\s+server$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^client\-config\-dir\s+\/etc\/openvpn\/test_server\/client\-configs$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^ca\s+\/etc\/openvpn\/test_server\/keys\/ca.crt$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^cert\s+\/etc\/openvpn\/test_server\/keys\/server.crt$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^key\s+\/etc\/openvpn\/test_server\/keys\/server.key$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^dh\s+\/etc\/openvpn\/test_server\/keys\/dh1024.pem$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^proto\s+tcp-server$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^tls-server$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^port\s+1194$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^comp-lzo$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^group\s+nogroup$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^user\s+nobody$/) }
    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(/^log\-append\s+test_server\/openvpn\.log$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^status\s+\/var\/log\/openvpn\/test_server-status\.log$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^dev\s+tun0$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^local\s+1\.2\.3\.4$/) }
    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(/^ifconfig-pool-persist/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^crl-verify\s+\/etc\/openvpn\/test_server\/crl.pem$/) }

    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(/verb/) }
    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(/cipher/) }
    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(/persist-key/) }
    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(/persist-tun/) }
    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(%r{^duplicate-cn$}) }

    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/^export CA_EXPIRE=3650$/) }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/^export KEY_EXPIRE=3650$/) }
    it { should_not contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/KEY_CN/) }
    it { should_not contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/KEY_NAME/) }
    it { should_not contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/KEY_OU/) }
  end

  context "creating a server setting all parameters" do
    let(:params) { {
      'country'         => 'CO',
      'province'        => 'ST',
      'city'            => 'Some City',
      'organization'    => 'example.org',
      'email'           => 'testemail@example.org',
      'compression'     => 'fake_compression',
      'port'            => '123',
      'proto'           => 'udp',
      'group'           => 'someone',
      'user'            => 'someone',
      'logfile'         => '/var/log/openvpn/test_server.log',
      'status_log'      => 'test_server_status.log',
      'dev'             => 'tun1',
      'up'              => '/tmp/up',
      'down'            => '/tmp/down',
      'local'           => '2.3.4.5',
      'ipp'             => true,
      'server'          => '2.3.4.0 255.255.0.0',
      'server_ipv6'	=> 'fe80:1337:1337:1337::/64',
      'push'            => [ 'dhcp-option DNS 172.31.0.30', 'route 172.31.0.0 255.255.0.0' ],
      'route'           => [ '192.168.30.0 255.255.255.0', '192.168.35.0 255.255.0.0' ],
      'keepalive'       => '10 120',
      'topology'        => 'subnet',
      'ssl_key_size'    => 2048,
      'management'      => true,
      'management_ip'   => '1.3.3.7',
      'management_port' => 1337,
      'common_name'     => 'mylittlepony',
      'ca_expire'       => 365,
      'key_expire'      => 365,
      'key_cn'          => 'yolo',
      'key_name'        => 'burp',
      'key_ou'          => 'NSA',
      'verb'            => 'mute',
      'cipher'          => 'DES-CBC',
      'persist_key'     => true,
      'persist_tun'     => true,
      'duplicate_cn'    => true,
    } }

    let(:facts) { {
      :ipaddress_eth0 => '1.2.3.4',
      :network_eth0   => '1.2.3.0',
      :netmask_eth0   => '255.255.255.0',
      :concat_basedir => '/var/lib/puppet/concat',
      :osfamily       => 'Debian',
      :lsbdistid      => 'Ubuntu',
      :lsbdistrelease => '12.04',
    } }

    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^mode\s+server$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^client-config-dir\s+/etc/openvpn/test_server/client-configs$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^ca\s+/etc/openvpn/test_server/keys/ca.crt$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^cert\s+/etc/openvpn/test_server/keys/mylittlepony.crt$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^key\s+/etc/openvpn/test_server/keys/mylittlepony.key$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^dh\s+/etc/openvpn/test_server/keys/dh2048.pem$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^proto\s+udp$/) }
    it { should_not contain_file('/etc/openvpn/test_server.conf').with_content(/^proto\s+tls-server$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^port\s+123$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^fake_compression$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^group\s+someone$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^user\s+someone$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^log\-append\s+/var/log/openvpn/test_server\.log$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^status\s+\/var\/log\/openvpn\/test_server_status\.log$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^dev\s+tun1$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^local\s+2\.3\.4\.5$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^server\s+2\.3\.4\.0\s+255\.255\.0\.0$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^server-ipv6\s+fe80\:1337\:1337\:1337\:\:\/64$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^push\s+"dhcp-option\s+DNS\s+172\.31\.0\.30"$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^push\s+"route\s+172\.31\.0\.0\s+255\.255\.0\.0"$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^route\s+192.168.30.0\s+255.255.255.0$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^route\s+192.168.35.0\s+255.255.0.0$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^keepalive\s+10\s+120$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^topology\s+subnet$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^management\s+1.3.3.7 1337$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^verb mute$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^cipher DES-CBC$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^persist-key$/) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^persist-tun$/) }

    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^up "/tmp/up"$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^down "/tmp/down"$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^script-security 2$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^duplicate-cn$}) }


    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/^export CA_EXPIRE=365$/) }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/^export KEY_EXPIRE=365$/) }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/^export KEY_CN="yolo"$/) }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/^export KEY_NAME="burp"$/) }
    it { should contain_file('/etc/openvpn/test_server/easy-rsa/vars').with_content(/^export KEY_OU="NSA"$/) }

    it { should contain_exec('generate dh param test_server').with_creates('/etc/openvpn/test_server/easy-rsa/keys/dh2048.pem') }
  end

  context "when RedHat based machine" do
    let(:params) { {
      'country'       => 'CO',
      'province'      => 'ST',
      'city'          => 'Some City',
      'organization'  => 'example.org',
      'email'         => 'testemail@example.org'
    } }

    let(:facts) { { :osfamily => 'RedHat',
                    :concat_basedir => '/var/lib/puppet/concat',
                    :operatingsystemmajrelease => 6,
                    :operatingsystemrelease => '6.4' } }

    context "until version 6.0" do
      before do
        facts[:operatingsystemmajrelease] = 5
        facts[:operatingsystemrelease] = '5.1'
      end
      it { should contain_exec('copy easy-rsa to openvpn config folder test_server').with(
        'command' => '/bin/cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0 /etc/openvpn/test_server/easy-rsa'
      )}
    end

    context "from 6.0 to 6.4" do
      before do
        facts[:operatingsystemmajrelease] = 6
        facts[:operatingsystemrelease] = '6.3'
      end
      it { should contain_exec('copy easy-rsa to openvpn config folder test_server').with(
        'command' => '/bin/cp -r /usr/share/openvpn/easy-rsa/2.0 /etc/openvpn/test_server/easy-rsa'
      )}
    end

    it { should contain_package('easy-rsa').with('ensure' => 'present') }
    it { should contain_exec('copy easy-rsa to openvpn config folder test_server').with(
      'command' => '/bin/cp -r /usr/share/easy-rsa/2.0 /etc/openvpn/test_server/easy-rsa'
    )}

    it { should contain_file('/etc/openvpn/test_server/easy-rsa/openssl.cnf').with(
      'ensure'  => 'link',
      'target'  => '/etc/openvpn/test_server/easy-rsa/openssl-1.0.0.cnf',
      'recurse' => nil,
      'group'   => 'nobody'
    )}

    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^group\s+nobody$/) }

    it { should contain_file('/etc/openvpn/test_server/crl.pem').with(
      'mode'    => '0640',
      'group'   => 'nobody'
    )}

  end

  context "when Debian based machine" do
    let(:params) { {
      'country'       => 'CO',
      'province'      => 'ST',
      'city'          => 'Some City',
      'organization'  => 'example.org',
      'email'         => 'testemail@example.org'
    } }

    let(:facts) { { :osfamily => 'Debian', :lsbdistid => 'Debian', :concat_basedir => '/var/lib/puppet/concat' } }

    shared_examples_for 'a newer version than wheezy' do
      it { should contain_package('easy-rsa').with('ensure' => 'present') }
      it { should contain_exec('copy easy-rsa to openvpn config folder test_server').with(
        'command' => '/bin/cp -r /usr/share/easy-rsa/ /etc/openvpn/test_server/easy-rsa'
      )}
    end
    context "when jessie/sid" do
      before do
        facts[:lsbdistid] = 'Debian'
        facts[:lsbdistrelease] = '8.0.1'
      end
      it_behaves_like 'a newer version than wheezy'
    end

    context 'when ubuntu 13.10' do
      before do
        facts[:lsbdistid] = 'Ubuntu'
        facts[:lsbdistrelease] = '13.10'
      end
      it_behaves_like 'a newer version than wheezy'
    end

    context 'when ubuntu 14.04' do
      before do
        facts[:lsbdistid] = 'Ubuntu'
        facts[:lsbdistrelease] = '14.04'
      end
      it_behaves_like 'a newer version than wheezy'
    end


    it { should contain_file('/etc/openvpn/test_server/easy-rsa/openssl.cnf').with(
      'ensure'  => 'link',
      'target'  => '/etc/openvpn/test_server/easy-rsa/openssl-1.0.0.cnf',
      'recurse' => nil,
      'group'   => 'nogroup'
    )}

    it { should contain_exec('copy easy-rsa to openvpn config folder test_server').with(
      'command' => '/bin/cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0 /etc/openvpn/test_server/easy-rsa'
    )}

    # Configure to start vpn session
    it { should contain_concat__fragment('openvpn.default.autostart.test_server').with(
      'content' => "AUTOSTART=\"$AUTOSTART test_server\"\n",
      'target'  => '/etc/default/openvpn'
    )}

    it { should contain_file('/etc/openvpn/test_server.conf').with_content(/^group\s+nogroup$/) }

    it { should contain_file('/etc/openvpn/test_server/crl.pem').with(
      'mode'    => '0640',
      'group'   => 'nogroup'
    )}

  end

  context 'ldap' do
    before do
      facts[:osfamily] = 'Debian'
      facts[:lsbdistid] = 'Debian'
      facts[:lsbdistrelease] = '8.0.0'
    end
    let(:params) { {
      'country'       => 'CO',
      'province'      => 'ST',
      'city'          => 'Some City',
      'organization'  => 'example.org',
      'email'         => 'testemail@example.org',

      'username_as_common_name' => true,
      'client_cert_not_required' => true,

      'ldap_enabled'   => true,
      'ldap_server'    => 'ldaps://ldap.example.org:636',
      'ldap_binddn'    => 'dn=root,dc=example,dc=org',
      'ldap_bindpass'  => 'secret password',
      'ldap_u_basedn'  => 'ou=people,dc=example,dc=org',
      'ldap_u_filter'  => 'call me user filter',
      'ldap_g_basedn'  => 'ou=groups,dc=example,dc=org',
      'ldap_gmember'   => true,
      'ldap_g_filter'  => 'call me group filter',
      'ldap_memberatr' => 'iCanTyping',

      'ldap_tls_enable'           => true,
      'ldap_tls_ca_cert_file'     => '/somewhere/ca.crt',
      'ldap_tls_ca_cert_dir'      => '/etc/ssl/certs',
      'ldap_tls_client_cert_file' => '/somewhere/client.crt',
      'ldap_tls_client_key_file'  => '/somewhere/client.key',
    } }

    it { should contain_package('openvpn-auth-ldap').with('ensure' => 'present') }

    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+URL ldaps://ldap\.example\.org:636$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+BindDN dn=root,dc=example,dc=org$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+Password secret password$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+BaseDN ou=people,dc=example,dc=org$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+SearchFilter "call me user filter"$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+RequireGroup true$}) }

    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+BaseDN ou=groups,dc=example,dc=org$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+SearchFilter "call me group filter"$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+MemberAttribute iCanTyping$}) }

    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+TLSEnable yes$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+TLSCACertFile /somewhere/ca.crt$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+TLSCACertDir /etc/ssl/certs$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+TLSCertFile /somewhere/client.crt$}) }
    it { should contain_file('/etc/openvpn/test_server/auth/ldap.conf').with_content(%r{^\s+TLSKeyFile /somewhere/client.key$}) }

    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^plugin /usr/lib/openvpn/openvpn-auth-ldap.so "/etc/openvpn/test_server/auth/ldap.conf"$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^username-as-common-name$}) }
    it { should contain_file('/etc/openvpn/test_server.conf').with_content(%r{^client-cert-not-required$}) }

  end

end
