# Changelog

This project does NOT follow semantic versioning. The version increases as
follows:

1. Major version updates are breaking updates to the build infrastructure.
   These should be very rare.
2. Minor version updates are made for every major Buildroot release. This
   may also include Erlang/OTP and Linux kernel updates. These are made four
   times a year shortly after the Buildroot releases.
3. Patch version updates are made for Buildroot minor releases, Erlang/OTP
   releases, and Linux kernel updates. They're also made to fix bugs and add
   features to the build infrastructure.

## v1.29.2

This is a security/bug fix update.

* Updated dependencies
  * [nerves_system_br v1.29.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.29.3)
  * [Buildroot 2024.08.3](https://lore.kernel.org/buildroot/874j3e17ek.fsf@dell.be.48ers.dk/T/)
  * [Erlang/OTP 27.2](https://erlang.org/download/OTP-27.2.README)
  * [fwup v1.12.0](https://github.com/fwup-home/fwup/releases/tag/v1.12.0)

## v1.29.1

This is a bug fix update.

* Changes
  * Fix missing SSL/TLS support

## v1.29.0

This is a major Erlang and Buildroot update.

Please see the [nerves_system_br v1.29.0 release notes](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.29.0)
for upgrade instructions if you've forked this system.

* Updated dependencies
  * [nerves_system_br v1.29.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.29.1)
  * [Buildroot 2024.08.2](https://lore.kernel.org/buildroot/871pzex7gn.fsf@dell.be.48ers.dk/T/)
  * Linux 6.6.51 (Raspberry Pi stable_20241008 release)

## v1.28.2

Support Nerves Web Kiosk with Wayland and Cog components.

## v1.28.1

This is a security/bug fix update.

* Changes
  * Create overlays for USB host and gadget mode support  

* Updated dependencies
  * [nerves_system_br v1.28.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.28.3)
  * [Buildroot 2024.05.2](https://lore.kernel.org/buildroot/87zfpfh147.fsf@dell.be.48ers.dk/T/)
  * [Erlang/OTP 27.0.1](https://erlang.org/download/OTP-27.0.1.README)

## v1.28.0

First Version of Spotify:tm: Car Thing support initially based on v1.28.0 on [nerves_system_rpi0_2](https://github.com/fhunleth/nerves_system_rpi0_2).

Please see the [nerves_system_br v1.28.0 release notes](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.28.0)
for upgrade instructions if you've forked this system.

* Versions
  * [Elixir 1.17](https://elixir-lang.org/docs.html) 
  * [Linux 6.6](https://github.com/alexcaoys/linux-superbird-6.6.y)
  * [nerves_system_br v1.28.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.28.1)
  * [Buildroot 2024.05](https://lore.kernel.org/buildroot/87bk46tjk2.fsf@dell.be.48ers.dk/T/)
  * [Erlang/OTP 27.0](https://erlang.org/download/OTP-27.0.README)

