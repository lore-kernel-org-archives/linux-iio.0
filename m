Return-Path: <SRS0=tr1Y=YS=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Wolfram Sang <wsa@the-dreams.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 00/12] mux controller abstraction and iio/i2c muxes
Date: Wed,  4 Jan 2017 13:16:15 +0100
Message-Id: <1483532187-28494-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi!

v6 -> v7 changes
- move from drivers/misc/mux-* to drivers/mux/
  [I will remove Cc:s to Arnd and Greg for v8, when/if that happens]
- add managed versions of mux_chip_alloc and mux_chip_register
- use the above in mux-gpio.c and mux-adg792a.c
- also use them to support a simplified binding of a gpio mux for the common
  case where there is a single consumer (and no specific idle requirements)
- new binding for describing idle behaviour of mux-adg792a
- add bindings for the gpo-pins on the mux-adg792g
- use device_property_read_u32 instead of of_property_read_u32 in mux-gpio.c
- rename iio mux compatible to io-channel-mux (was iio-mux)
- remove linuxism in the bindings (it was mentioning a function name)
- add missing quote in the example in the io-channel-mux binding
- factor out preparatory cleanup of devres docs to its own patch
- add blank line in mux_chip_free
- use SIMPLE_{PARENT,MUX}_LOCKED instead of magic numbers {0,1} in
  i2c-mux-simple.c
- add some acks and a reviewed-by from Jonathan

v5 -> v6 changes
- fix stupidity in mux_chip_priv, mux_gpio_remove and adg792a_remove.
- change the devicetree bindings for the iio-mux to use a list of strings
  (channels property) instead of a list children.

v4 -> v5 changes
- remove support for fancier dt layouts and go back to the phandle
  approach from v2 and before, killing the horrible non-working
  refcounting crap from v4 and avoiding a bunch of life-time issues
  in v3.
- introduce the concept of a mux-chip, that can hold one or more
  mux-controllers (inspired by the pwm subsystem).
- add dt #mux-control-cells property needed to get to the desired
  mux controller if a mux chip provides more than one.
- take away the option to build the mux-core as a module.
- if the mux controller has an idle state, make sure the mux controller
  is set up in the idle state initially (when it should be idle).
- do not use a variable length array on the stack in mux_gpio_set to
  temporarily store the gpio state, preallocate space instead.
- fix resource leak on one failure path in mux_gpio_probe.
- driver for Analog Devices ADG792A/G, literally the first mux chip
  I found on the Internet with an i2c interface (that was not a
  dedicated i2c multiplexer like PCA9547) which I used to verify
  that the abstractions in the mux core are up to the task. Untested,
  just proof of concept that at least looks pretty and compiles...
- various touch-ups.

v3 -> v4 changes
- rebased onto next-20161122 (depends on recent _available iio changes).
- added support for having the mux-controller in a child node of a
  mux-consumer if it is a sole consumer, to hopefully even further satisfy
  the complaint from Rob (and later Lars-Peter) about dt complexity.
- the above came at the cost of some rather horrible refcounting code,
  please review and suggest how it should be done...
- changed to register a device class instead of a bus.
- pass in the parent device into mux_control_alloc and require less
  work from mux-control drivers.
- changed device names from mux:control%d to mux%d
- move kernel-doc from mux-core.c to mux.h (and add some bits).
- give the gpio driver a chance to update all mux pins at once.
- factor out iio ext_info lookup into new helper function. /Lars-Peter
- use an unsigned type for the iio ext_info count. /Lars-Peter
- unified "brag strings" in the file headers.

v2 -> v3 changes
- have the mux-controller in the parent node of any mux-controller consumer,
  to hopefully satisfy complaint from Rob about dt complexity.
- improve commit message of the mux subsystem commit, making it more
  general, as requested by Jonathan.
- remove priv member from struct mux_control and calculate it on the
  fly. /Jonathan
- make the function comments in mux-core.c kernel doc. /Jonathan
- add devm_mux_control_* to Documentation/driver.model/devres.txt. /Jonathan
- add common dt bindings for mux-controllers, refer to them from the
  mux-gpio bindings. /Rob
- clarify how the gpio pins map to the mux state. /Rob
- separate CONFIG_ variables for the mux core and the mux gpio driver.
- improve Kconfig help texts.
- make CONFIG_MUX_GPIO depend on CONFIG_GPIOLIB.
- keep track of the number of mux states in the mux core.
- since the iio channel number is used as mux state, it was possible
  to drop the state member from the mux_child struct.
- cleanup dt bindings for i2c-mux-simple, it had some of copy-paste
  problems from ots origin (i2c-mux-gpio).
- select the mux control subsystem in config for the i2c-mux-simple driver.
- add entries to MAINTAINERS and my sign-off, I'm now satisfied and know
  nothing in this to be ashamed of.

v1 -> v2 changes
- fixup export of mux_control_put reported by kbuild
- drop devicetree iio-ext-info property as noted by Lars-Peter,
  and replace the functionality by exposing all ext_info
  attributes of the parent channel for each of the muxed
  channels. A cache on top of that and each muxed channel
  gets its own view of the ext_info of the parent channel.
- implement idle-state for muxes
- clear out the cache on failure in order to force a mux
  update on the following use
- cleanup the probe of i2c-mux-simple driver
- fix a bug in the i2c-mux-simple driver, where failure in
  the selection of the mux caused a deadlock when the mux
  was later unconditionally deselected.

I have a piece of hardware that is using the same 3 GPIO pins
to control four 8-way muxes. Three of them control ADC lines
to an ADS1015 chip with an iio driver, and the last one
controls the SDA line of an i2c bus. We have some deployed
code to handle this, but you do not want to see it or ever
hear about it. I'm not sure why I even mention it. Anyway,
the situation has nagged me to no end for quite some time.

So, after first getting more intimate with the i2c muxing code
and later discovering the drivers/iio/inkern.c file and
writing a couple of drivers making use of it, I came up with
what I think is an acceptable solution; add a generic mux
controller driver (and subsystem) that is shared between all
instances, and combine that with an iio mux driver and a new
generic i2c mux driver. The new i2c mux I called "simple"
since it is only hooking the i2c muxing and the new mux
controller (much like the alsa simple card driver does for ASoC).

One thing that I would like to do, but don't see a solution
for, is to move the mux control code that is present in
various drivers in drivers/i2c/muxes to this new minimalistic
muxing subsystem, thus converting all present i2c muxes (but
perhaps not gates and arbitrators) to be i2c-mux-simple muxes.

I'm using an rwsem to lock a mux, but that isn't really a
perfect fit. Is there a better locking primitive that I don't
know about that fits better? I had a mutex at one point, but
that didn't allow any concurrent accesses at all. At least
the rwsem allows concurrent access as long as all users
agree on the mux state, but I suspect that the rwsem will
degrade to the mutex situation pretty quickly if there is
any contention.

Also, the "mux" name feels a bit ambitious, there are many muxes
in the world, and this tiny bit of code is probably not good
enough to be a nice fit for all...

Cheers,
peda

Peter Rosin (12):
  devres: trivial whitespace fix
  dt-bindings: document devicetree bindings for mux-controllers and
    mux-gpio
  mux: minimal mux subsystem and gpio-based mux controller
  dt-bindings: simplified bindings for single-user gpio mux
  mux: support simplified bindings for single-user gpio mux
  iio: inkern: api for manipulating ext_info of iio channels
  dt-bindings: iio: iio-mux: document iio-mux bindings
  iio: multiplexer: new iio category and iio-mux driver
  dt-bindings: i2c: i2c-mux-simple: document i2c-mux-simple bindings
  i2c: i2c-mux-simple: new driver
  dt-bindings: mux-adg792a: document devicetree bindings for ADG792A/G
    mux
  mux: adg792a: add mux controller driver for ADG792A/G

 .../devicetree/bindings/i2c/i2c-mux-simple.txt     |  81 ++++
 .../bindings/iio/multiplexer/io-channel-mux.txt    |  39 ++
 .../devicetree/bindings/mux/mux-adg792a.txt        |  79 ++++
 .../devicetree/bindings/mux/mux-controller.txt     | 153 +++++++
 Documentation/devicetree/bindings/mux/mux-gpio.txt |  68 +++
 Documentation/driver-model/devres.txt              |  10 +-
 MAINTAINERS                                        |  14 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/i2c/muxes/Kconfig                          |  13 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-simple.c                 | 182 ++++++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/inkern.c                               |  60 +++
 drivers/iio/multiplexer/Kconfig                    |  18 +
 drivers/iio/multiplexer/Makefile                   |   6 +
 drivers/iio/multiplexer/iio-mux.c                  | 456 ++++++++++++++++++++
 drivers/mux/Kconfig                                |  45 ++
 drivers/mux/Makefile                               |   7 +
 drivers/mux/mux-adg792a.c                          | 169 ++++++++
 drivers/mux/mux-core.c                             | 475 +++++++++++++++++++++
 drivers/mux/mux-gpio.c                             |  70 +++
 include/linux/iio/consumer.h                       |  37 ++
 include/linux/mux.h                                | 251 +++++++++++
 25 files changed, 2238 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mux-adg792a.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mux-gpio.txt
 create mode 100644 drivers/i2c/muxes/i2c-mux-simple.c
 create mode 100644 drivers/iio/multiplexer/Kconfig
 create mode 100644 drivers/iio/multiplexer/Makefile
 create mode 100644 drivers/iio/multiplexer/iio-mux.c
 create mode 100644 drivers/mux/Kconfig
 create mode 100644 drivers/mux/Makefile
 create mode 100644 drivers/mux/mux-adg792a.c
 create mode 100644 drivers/mux/mux-core.c
 create mode 100644 drivers/mux/mux-gpio.c
 create mode 100644 include/linux/mux.h

-- 
2.1.4
