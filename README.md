# Spotify:tm: Car Thing

![CI Status](https://github.com/ericr3r/nerves_system_superbird/actions/workflows/main.yml/badge.svg)

This is the base Nerves System configuration for the Spotify:tm: Car Thing.

Networking is only done through [Gadget Mode](http://www.linux-usb.org/gadget/).

## Intial bootsrapping

The initial steps to get a nerves release onto the Spotify:tm: Car Things are complicated.
Please refer to the [bootstrap instructions](https://github.com/ericr3r/notes-superbird/bootsrapping.md)
in the [ericr3r/notes-superbird](https://github.com/ericr3r/notes-superbird) repository.

## Using

Add `superbird` to `@all_targets` and
```
{:nerves_system_superbird, git: "git@github.com:ericr3r/nerves_system_superbird.git", 
runtime: false, tag: ..., targets: :superbird}
```
to `deps` in `mix.exs`.
 

The most common way of using this Nerves System is create a project with `mix
nerves.new` and to export `MIX_TARGET=superbird`. See the [Getting started
guide](https://hexdocs.pm/nerves/getting-started.html#creating-a-new-nerves-app)
for more information.

If you need custom modifications to this system for your device, clone this
repository and update as described in [Making custom
systems](https://hexdocs.pm/nerves/customizing-systems.html).

## USB OTG support

One of the goals of this system is to make it possible to do most development
via one USB cable. That cable, when plugged into the USB OTG port, powers the
Spotify:tm: Car Thing and provides local networking. Via the network connection, one
can access an IEx prompt via ssh, transfer files via sftp, run firmware updates,
use Erlang distribution and anything else that works over IP.

When you connect the USB OTG port to your laptop, it should "just" work if
you're using OSX or Linux. If you're on Windows and want to access networking
natively (not through a Linux VM), you will need to install
[`linux.inf`](https://elixir.bootlin.com/linux/v4.19.102/source/Documentation/usb/linux.inf).
This file is unsigned and will fail to install unless you disable signed driver
enforcement. The basic idea is to go to settings, go to the advanced boot
settings and navigate the menus to boot with it off. There are examples on the
web.

## Provisioning devices

This system supports storing provisioning information in a small key-value store
outside of any filesystem. Provisioning is an optional step and reasonable
defaults are provided if this is missing.

Provisioning information can be queried using the Nerves.Runtime KV store's
[`Nerves.Runtime.KV.get/1`](https://hexdocs.pm/nerves_runtime/Nerves.Runtime.KV.html#get/1)
function.

Keys used by this system are:

Key                    | Example Value     | Description
:--------------------- | :---------------- | :----------
`nerves_serial_number` | `"12345678"`      | By default, this string is used to create unique hostnames and Erlang node names. If unset, it defaults to `0000` since boardid is not working yet.

The normal procedure would be to set these keys once in manufacturing or before
deployment and then leave them alone.

For example, to provision a serial number on a running device, run the following
and reboot:

```elixir
iex> cmd("fw_setenv nerves_serial_number 12345678")
```

This system supports setting the serial number offline. To do this, set the
`NERVES_SERIAL_NUMBER` environment variable when burning the firmware. If you're
programming MicroSD cards using `fwup`, the commandline is:

```sh
sudo NERVES_SERIAL_NUMBER=12345678 fwup path_to_firmware.fw
```

Serial numbers are stored on the MicroSD card so if the MicroSD card is
replaced, the serial number will need to be reprogrammed. The numbers are stored
in a U-boot environment block. This is a special region that is separate from
the application partition so reformatting the application partition will not
lose the serial number or any other data stored in this block.

Additional key value pairs can be provisioned by overriding the default
provisioning.conf file location by setting the environment variable
`NERVES_PROVISIONING=/path/to/provisioning.conf`. The default provisioning.conf
will set the `nerves_serial_number`, if you override the location to this file,
you will be responsible for setting this yourself.

