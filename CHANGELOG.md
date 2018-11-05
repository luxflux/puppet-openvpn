# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v7.4.0](https://github.com/voxpupuli/puppet-openvpn/tree/v7.4.0) (2018-10-16)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v7.3.0...v7.4.0)

**Implemented enhancements:**

- update supported OSes in params.pp [\#296](https://github.com/voxpupuli/puppet-openvpn/pull/296) ([Dan33l](https://github.com/Dan33l))
- use new fact easyrsa to configure easyrsa 2 or 3 [\#292](https://github.com/voxpupuli/puppet-openvpn/pull/292) ([Dan33l](https://github.com/Dan33l))

**Fixed bugs:**

- Support for easy-rsa version 3 [\#216](https://github.com/voxpupuli/puppet-openvpn/issues/216)

**Closed issues:**

- debian 7 support broken [\#291](https://github.com/voxpupuli/puppet-openvpn/issues/291)
- Epel has upgraded `easy-rsa` to version 3.x and removed 2.x, breaking the module [\#269](https://github.com/voxpupuli/puppet-openvpn/issues/269)

**Merged pull requests:**

- FreeBSD: change additional\_packages to easy-rsa2 [\#301](https://github.com/voxpupuli/puppet-openvpn/pull/301) ([olevole](https://github.com/olevole))
- Update puppetlabs-stdlib dependency version in README [\#298](https://github.com/voxpupuli/puppet-openvpn/pull/298) ([simonrondelez](https://github.com/simonrondelez))
- move concat version\_requirement to \>= 3.0.0 \< 6.0.0 [\#294](https://github.com/voxpupuli/puppet-openvpn/pull/294) ([Dan33l](https://github.com/Dan33l))
- allow puppetlabs/stdlib 5.x [\#290](https://github.com/voxpupuli/puppet-openvpn/pull/290) ([bastelfreak](https://github.com/bastelfreak))
- Remove deprecated hiera\_hash [\#289](https://github.com/voxpupuli/puppet-openvpn/pull/289) ([Dan33l](https://github.com/Dan33l))
- Remove deprecated hiera\_hash [\#276](https://github.com/voxpupuli/puppet-openvpn/pull/276) ([jkroepke](https://github.com/jkroepke))

## [v7.3.0](https://github.com/voxpupuli/puppet-openvpn/tree/v7.3.0) (2018-08-18)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v7.2.0...v7.3.0)

**Implemented enhancements:**

- Allow management\_port to be a string; require stdlib \>= 4.25.0 [\#275](https://github.com/voxpupuli/puppet-openvpn/pull/275) ([marieof9](https://github.com/marieof9))

**Fixed bugs:**

- Configuring management unix socket is no longer possible [\#274](https://github.com/voxpupuli/puppet-openvpn/issues/274)
- openvpn::server, documentation doesn't match the code for parameter 'port' [\#272](https://github.com/voxpupuli/puppet-openvpn/issues/272)

**Merged pull requests:**

- Remove docker nodesets [\#282](https://github.com/voxpupuli/puppet-openvpn/pull/282) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL OSs; fix puppet version range [\#280](https://github.com/voxpupuli/puppet-openvpn/pull/280) ([bastelfreak](https://github.com/bastelfreak))
- Changed type for port in class documentation [\#273](https://github.com/voxpupuli/puppet-openvpn/pull/273) ([clxnetom](https://github.com/clxnetom))

## [v7.2.0](https://github.com/voxpupuli/puppet-openvpn/tree/v7.2.0) (2018-03-17)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v7.1.0...v7.2.0)

**Implemented enhancements:**

- Allow to define remote-cert-tls [\#266](https://github.com/voxpupuli/puppet-openvpn/pull/266) ([jkroepke](https://github.com/jkroepke))

**Fixed bugs:**

- Bug Fix: Ensure cipher and tls\_cipher can be disabled entirely [\#270](https://github.com/voxpupuli/puppet-openvpn/pull/270) ([jcarr-sailthru](https://github.com/jcarr-sailthru))

**Closed issues:**

- Looking for Maintainers [\#228](https://github.com/voxpupuli/puppet-openvpn/issues/228)

## [v7.1.0](https://github.com/voxpupuli/puppet-openvpn/tree/v7.1.0) (2018-01-11)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v7.0.0...v7.1.0)

**Implemented enhancements:**

- add openvpn::deploy::\(export/client\) [\#261](https://github.com/voxpupuli/puppet-openvpn/pull/261) ([to-kn](https://github.com/to-kn))

**Closed issues:**

- Elegant solution for renewing CRL [\#236](https://github.com/voxpupuli/puppet-openvpn/issues/236)

## [v7.0.0](https://github.com/voxpupuli/puppet-openvpn/tree/v7.0.0) (2018-01-06)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v6.0.0...v7.0.0)

**Breaking changes:**

- add datatypes to all params [\#259](https://github.com/voxpupuli/puppet-openvpn/pull/259) ([to-kn](https://github.com/to-kn))

**Implemented enhancements:**

- Add crl renewal [\#256](https://github.com/voxpupuli/puppet-openvpn/pull/256) ([to-kn](https://github.com/to-kn))

## [v6.0.0](https://github.com/voxpupuli/puppet-openvpn/tree/v6.0.0) (2017-11-21)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v5.0.0...v6.0.0)

**Breaking changes:**

- Turned up options for encryption [\#223](https://github.com/voxpupuli/puppet-openvpn/pull/223) ([mcrmonkey](https://github.com/mcrmonkey))

**Fixed bugs:**

- Doesn't work properly with "remote" in openvpn::server [\#252](https://github.com/voxpupuli/puppet-openvpn/issues/252)
- Correct 252 [\#253](https://github.com/voxpupuli/puppet-openvpn/pull/253) ([cjeanneret](https://github.com/cjeanneret))

**Merged pull requests:**

- replace validate\_\* with datatypes in init.pp [\#251](https://github.com/voxpupuli/puppet-openvpn/pull/251) ([bastelfreak](https://github.com/bastelfreak))

## [v5.0.0](https://github.com/voxpupuli/puppet-openvpn/tree/v5.0.0) (2017-11-13)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v4.1.1...v5.0.0)

**Breaking changes:**

- Breaking: Update puppet, stdlib, and concat requirements in prep for release [\#242](https://github.com/voxpupuli/puppet-openvpn/pull/242) ([wyardley](https://github.com/wyardley))

**Implemented enhancements:**

- Upped version requirement of concat and added Debian 9 \(stretch\) [\#243](https://github.com/voxpupuli/puppet-openvpn/pull/243) ([hp197](https://github.com/hp197))

## [v4.1.1](https://github.com/voxpupuli/puppet-openvpn/tree/v4.1.1) (2017-10-07)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/v4.1.0...v4.1.1)

## [v4.1.0](https://github.com/voxpupuli/puppet-openvpn/tree/v4.1.0) (2017-10-06)

[Full Changelog](https://github.com/voxpupuli/puppet-openvpn/compare/4.0.1...v4.1.0)

**Closed issues:**

- Install openvpn & certs also on client nodes [\#231](https://github.com/voxpupuli/puppet-openvpn/issues/231)
- Download config has incorrect protocol [\#219](https://github.com/voxpupuli/puppet-openvpn/issues/219)
- Error while evaluating a Function Call, cannot currently create client configs when corresponding openvpn::server is extca\_enabled [\#199](https://github.com/voxpupuli/puppet-openvpn/issues/199)

**Merged pull requests:**

- Fix auth tls ovpn profile and ldap auth file perms [\#220](https://github.com/voxpupuli/puppet-openvpn/pull/220) ([szponek](https://github.com/szponek))
- Correct path of openvpn-auth-pam.so on modern Debian distros. [\#217](https://github.com/voxpupuli/puppet-openvpn/pull/217) ([oc243](https://github.com/oc243))
- Add rhel6 support for ldap auth plugin [\#215](https://github.com/voxpupuli/puppet-openvpn/pull/215) ([miguelwhite](https://github.com/miguelwhite))
- fix broken namespecific rclink [\#209](https://github.com/voxpupuli/puppet-openvpn/pull/209) ([alxwr](https://github.com/alxwr))

## 4.0.1 (2016-09-25)

* Fix namespecific_rclink variable warning for non BSD systems ([#214](https://github.com/luxflux/puppet-openvpn/pull/214))

## 4.0.0

* Workaround for [MODULES-2874](https://tickets.puppetlabs.com/browse/MODULES-2874) ([#201](https://github.com/luxflux/puppet-openvpn/pull/201))
* Fix for [external CA handling with exported resources](https://github.com/luxflux/puppet-openvpn/pull/200) ([#201](https://github.com/luxflux/puppet-openvpn/pull/201))
* Drop Support for Puppet 3.x ([#212](https://github.com/luxflux/puppet-openvpn/pull/212))

## 3.1.0

* Support for FreeBSD ([#180](https://github.com/luxflux/puppet-openvpn/pull/180))
* Support for port-share ([#182](https://github.com/luxflux/puppet-openvpn/issues/182)/[#185](https://github.com/luxflux/puppet-openvpn/pull/185))
* Support for pre-shared keys ([#186](https://github.com/luxflux/puppet-openvpn/pull/186))
* Support LDAP anonymous binds ([#189](https://github.com/luxflux/puppet-openvpn/pull/189))
* Fix `.ovpn` files generation ([#190](https://github.com/luxflux/puppet-openvpn/pull/190))
* Support for external CAs ([#192](https://github.com/luxflux/puppet-openvpn/pull/192))
* Small Typo fix ([#192](https://github.com/luxflux/puppet-openvpn/pull/193))
* Fix support for Amazon Linux ([#194](https://github.com/luxflux/puppet-openvpn/pull/194))
* Client `pull` option ([#195](https://github.com/luxflux/puppet-openvpn/pull/195))
* Allow `remote_host` to be an array of servers ([#195](https://github.com/luxflux/puppet-openvpn/pull/195))
* More robust Shared CA handling ([#191](https://github.com/luxflux/puppet-openvpn/pull/191), [#196](https://github.com/luxflux/puppet-openvpn/pull/196))

## 3.0.0

* Support for Ubuntu 15.04 ([#168](https://github.com/luxflux/puppet-openvpn/pull/168))
* Support for specifying TLS-Cipher ([#169](https://github.com/luxflux/puppet-openvpn/pull/169))
* Support for specifying custom certificate expiry ([#169](https://github.com/luxflux/puppet-openvpn/pull/169))
* Support for README in download configs ([#169](https://github.com/luxflux/puppet-openvpn/pull/169))
* Support for Tunnelblick configurations ([#169](https://github.com/luxflux/puppet-openvpn/pull/169))
* Fix certificate revocation in Ubuntu Precise ([#169](https://github.com/luxflux/puppet-openvpn/pull/169))
* Use concat for ovpn generation ([#176](https://github.com/luxflux/puppet-openvpn/pull/176))

## 2.9.0

This will be the last version of version 2.x with new features.

* Support to send ipv6 routes ([#153](https://github.com/luxflux/puppet-openvpn/pull/153), [#154](https://github.com/luxflux/puppet-openvpn/pull/154))
* Support for `nobind` param for server in client mode ([#156](https://github.com/luxflux/puppet-openvpn/pull/156))
* Fixing autostart_all behaviour ([#163](https://github.com/luxflux/puppet-openvpn/pull/163))
* Add systemd support for Debian >= 8.0 ([#161](https://github.com/luxflux/puppet-openvpn/pull/161))
* Support for Archlinux ([#162](https://github.com/luxflux/puppet-openvpn/pull/162))
* Support to enable/disable service management([#158](https://github.com/luxflux/puppet-openvpn/pull/158))
* Fix installation for older Redhat based systems ([#165](https://github.com/luxflux/puppet-openvpn/pull/165))
* Add ability to specify custom options for clients ([#167](https://github.com/luxflux/puppet-openvpn/pull/167))

## 2.8.0

* Support for systems without `lsb-release` package ([#134](https://github.com/luxflux/puppet-openvpn/pull/134))
* Support for Amazon EC2 OS ([#134](https://github.com/luxflux/puppet-openvpn/pull/134))
* Move default log path for status log to `/var/log/openvpn` ([#139](https://github.com/luxflux/puppet-openvpn/pull/139))
* Support for `format` parameter ([#138](https://github.com/luxflux/puppet-openvpn/pull/138))
* Ability to configure autostart management on debian ([#144](https://github.com/luxflux/puppet-openvpn/pull/144))
* Fix ordering in `/etc/default/openvpn` with puppet future parser ([#142](https://github.com/luxflux/puppet-openvpn/issues/142)
* Support for TLS auth when server acts as client ([#147](https://github.com/luxflux/puppet-openvpn/pull/147))
* Support for customer server options ([#147](https://github.com/luxflux/puppet-openvpn/pull/147))
* Allow disabling `ns-cert-type server` for server-clients ([#147](https://github.com/luxflux/puppet-openvpn/pull/147))
* Fix pam plugin path on RedHat/CentOS ([#148](https://github.com/luxflux/puppet-openvpn/pull/148))

## 2.7.1

* Fix server in client mode ([#137](https://github.com/luxflux/puppet-openvpn/pull/137))

## 2.7.0

* Support for removing a client specific conf file ([#115](https://github.com/luxflux/puppet-openvpn/pull/115))
* Support for `rcvbuf` and `sndbuf` ([#116](https://github.com/luxflux/puppet-openvpn/pull/116))
* Fix RedHat and CentOS package selection ([#97](https://github.com/luxflux/puppet-openvpn/pull/97))
* Support for TLS and x509-name verification ([#118](https://github.com/luxflux/puppet-openvpn/pull/118))
* Fix unset client cipher producing invalid configs ([#129](https://github.com/luxflux/puppet-openvpn/pull/129))
* Support to share a CA between multiple server instances ([#112](https://github.com/luxflux/puppet-openvpn/pull/112))
* Support for systemd ([#127](https://github.com/luxflux/puppet-openvpn/pull/127))

## 2.6.0

* Support for setting `up` and/or `down` scripts for clients  ([#89](https://github.com/luxflux/puppet-openvpn/pull/89))
* Fixing the permissions of the created directories and files ([#90](https://github.com/luxflux/puppet-openvpn/pull/90), [#92](https://github.com/luxflux/puppet-openvpn/pull/92), [#94](https://github.com/luxflux/puppet-openvpn/pull/94), [#102](https://github.com/luxflux/puppet-openvpn/pull/102))
* Refactor templates to use instance variables instead of `scope.lookupvar` ([#100](https://github.com/luxflux/puppet-openvpn/pull/100))
* Add client mode server ([#100](https://github.com/luxflux/puppet-openvpn/pull/100))
* Move CA management into its own defined type ([#100](https://github.com/luxflux/puppet-openvpn/pull/100))
* Fix LDAP-Support on Debian Wheezy ([#103](https://github.com/luxflux/puppet-openvpn/pull/103))
* Support for status-version ([#108](https://github.com/luxflux/puppet-openvpn/pull/108))
* Change layout of downloadable client config to prevent overriding other client configurations when extracting the tarball ([#104](https://github.com/luxflux/puppet-openvpn/pull/104))
* Add `ns-cert-type server` for server-clients ([#109](https://github.com/luxflux/puppet-openvpn/pull/109))

## 2.5.0

* Do not include deprecated `concat::setup` anymore ([#71](https://github.com/luxflux/puppet-openvpn/pull/71))
* Only warn about pam deprecation if it's used ([#72](https://github.com/luxflux/puppet-openvpn/pull/72))
* Ability to specify a `down` script ([#75](https://github.com/luxflux/puppet-openvpn/pull/75))
* Support for `client-cert-not-required` in server config ([#76](https://github.com/luxflux/puppet-openvpn/pull/76))
* Support for `auth-retry` in client config ([#76](https://github.com/luxflux/puppet-openvpn/pull/76))
* Support for `setenv` in client config ([#79](https://github.com/luxflux/puppet-openvpn/pull/79))
* Support for `setenv_safe` in client config ([#79](https://github.com/luxflux/puppet-openvpn/pull/79))
* Support for `cipher` in client config ([#80](https://github.com/luxflux/puppet-openvpn/pull/80))
* Support for `push route` in client specific config ([#80](https://github.com/luxflux/puppet-openvpn/pull/80))

## 2.4.0

### Bugfixes
* Fix Ubuntu Trusty support ([#64](https://github.com/luxflux/puppet-openvpn/pull/64))

### New Features
* Basic support to hand out IPv6 addresses ([#66](https://github.com/luxflux/puppet-openvpn/pull/66))
* Ability to specify the common name of a server ([#65](https://github.com/luxflux/puppet-openvpn/pull/65))
* Options for KEY_EXPIRE, CA_EXPIRE, KEY_NAME, KEY_OU, KEY_CN easy-rsa vars. ([#58](https://github.com/luxflux/puppet-openvpn/pull/58), [#70](https://github.com/luxflux/puppet-openvpn/pull/70))
* Options for cipher, verb, persist-key, persist-tun server directives. ([#58](https://github.com/luxflux/puppet-openvpn/pull/58), [#70](https://github.com/luxflux/puppet-openvpn/pull/70))


## Before

* A lot of stuff I don't know anymore :disappointed:


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
