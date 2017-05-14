Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:56456 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759611AbdENT5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 15:57:50 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Subject: [PATCH v15 00/13] mux controller abstraction and iio/i2c muxes
Date: Sun, 14 May 2017 21:51:03 +0200
Message-Id: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Hi Greg,

Philipp found problems in v14 with using a mutex for locking that was
the outcome of the review for v13, so I'm now using a semaphore instead
of the rwsem that was in v13. That at least got rid of the scary call
to downgrade_write. However, I'm still unsure about what you actually
meant with your comment about lack of sparse markings [1]. I did add
__must_check to the funcs that selects the mux, but I've got this
feeling that this is not what you meant?

Anyway, I have acted on all your comments from the v13 review, at
least I think I did. So, please apply.

[1] https://lkml.org/lkml/2017/4/21/794


v14 -> v15 changes
- Rebased onto v4.12-rc1
- Add the mmio-mux driver from Philipp Zabel to the end of the series.
- Using a mutex to lock the mux state did not work out for Philipp Zabel
  and his video-mux, which is locking the mux over long periods of time.
  So, switch to a semaphore (where different tasks can call down/up).
- Remove unused devm_mux_chip_free, devm_mux_chip_unregister and
  devm_mux_control_put. Those are currently unused and can be added when
  someone needs them.
- Add more words in the kernel-doc comments for mux_control_select,
  mux_control_try_select and mux_control_deselect on the calling rules.
- Add "|| COMPILE_TEST" to the Kconfig depends for all new drivers.

[older changes follow below]


This adds a new mux controller subsystem with an interface for accessing
mux controllers, along with three drivers providing the interface (gpio,
mmio and adg792) and two consumers (iio and i2c). This is done in a way
that several consumers can independently access the same mux controller
if one controller controls several multiplexers, thus allowing sharing.
But sharing is by no means required, of course. It is perfectly fine to
have a single consumer of a dedicated mux controller controlling only
one mux for said consumer.

The prediction is that the typical use case will be for gpio-based muxing
(which is also what drove the development), where the below schematics
show the flexibility with one gpio-based mux controller being shared by
the iio-mux and i2c-mux-gpmux drivers.

    .----.
    |GPO0|----------.
    |GPO1|--------. |
    |    |        | |
    |    |     .-------.
    |    |     |dg4052a|
    |    |     |       |
    |ADC0|-----|X    X0|---- signal X0
    |    |     |     X1|---- signal X1
    |    |     |     X2|---- signal X2
    |    |     |     X3|---- signal X3
    |    |     |       |
    |SDA0|-----|Y    Y0|---- i2c segment Y0
    |SCL0|--.  |     Y1|---- i2c segment Y1
    '----'  |  |     Y2|---- i2c segment Y2
            |  |     Y3|---- i2c segment Y3
            |  '-------'
            |                0 1 2 3   (feed SCL0 to each of
            |                | | | |    the 4 muxed segments)
            '----------------+-+-+-'

GPO0 and GPO1 may also be fed to further parallel muxers, which is perhaps
desired in a real application to minimize digital noise from the I2C Y
channel leaking into the analog X channel. I.e. it might be a good idea
to separate the analog and digital signals...

And the below hypothetical schematics indicate something similar but using
the I2C-based adg792a multiplexer instead.

    .----.
    |SDA0|----------.
    |SCL0|--------. |
    |    |        | |
    |    |     .-------.
    |    |     |adg792a|
    |    |     |       |
    |ADC0|-----|D1  S1A|---- signal S1A
    |    |     |    S1B|---- signal S1B
    |    |     |    S1C|---- signal S1C
    |    |     |    S1D|---- signal S1D
    |    |     |       |
    |SDA1|---+-|D2  S2A|---- i2c segment S2A
    |SCL1|-. | |    S2B|---- i2c segment S2B
    '----' | | |    S2C|---- i2c segment S2C
           | | |    S2D|---- i2c segment S2D
           | | |       |
           | '-|D3  S3A|---- i2c segment S3A
           |   |    S3B|---- i2c segment S3B
           |   |    S3C|---- i2c segment S3C
           |   |    S3D|---- i2c segment S3D
           |   '-------'
           |                 A B C D   A B C D  (feed SCL1 to each of
           |                 | | | |   | | | |   the 8 muxed segments)
           '-----------------+-+-+-+---+-+-+-'


Background:

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
general purpose i2c mux driver that is only hooking the i2c
muxing and the new mux controller.

One thing that I would like to do, but don't see a solution
for, is to move the mux control code that is present in
various drivers in drivers/i2c/muxes to this new minimalistic
muxing subsystem, thus converting all present i2c muxes (but
perhaps not gates and arbitrators).

I'm using an ordinary semaphore to lock the mux, but that isn't
really a perfect fit since multiple consumers of the same mux
controller need not lock each other out when they want the same
mux state. I had a rwsem for a long while, but that degenerated
into the above semaphore case when there was contention.
Originally I had a mutex (before v1) and that was even back for
a brief time (in v14), but a mutex is not a good fit for some
consumers needing to lock the mux for a long time.

Also, the "mux" name feels a bit ambitious, there are many muxes
in the world, and this tiny bit of code is probably not good
enough to be a nice fit for all...


Older changes:

v13 -> v14 changes:  https://lkml.org/lkml/2017/4/24/153
- Go back to a mutex instead of a rwsem to protect the mux state. [Greg K-H]
- Add __must_check to the mux_control_select function. [Greg, was this what
  you meant with "sparse markings"? I assume not, but I don't know...]
- Don't return hint on mux state changes when calling mux_control_select. [Greg]
- Add mux_control_try_select function. [Philipp Zabel]
- Split the mux.h #include into mux/driver.h and mux/consumer.h [Philipp]
- Add mux_control_states function to be able to completely hide struct
  mux_control details from mux consumers.
- Include the constants from the DT bindings include, instead of
  redefining them. [Greg]
- Make mux_chip_alloc (and devm_mux_chip_alloc) return ERR_PTR instead
  of NULL on error. [Greg]
- Document why mux_chip_alloc and mux_chip_register are split up, and
  what is supposed to happen between the two calls, [Greg] and...
- ...specifically mention that mux drivers should never clobber
  cached_state [Philipp].
- Support module unloading of the core (and initialize mux_ida on init). [Greg]
- Do not mention link order when commenting on why there is a subsys_initcall
  instead of an ordinare module_init in the mux-core. [Greg]
- Use __func__ instead of spelling out the function name. [Greg]
- Drop cargo cult usage of WARN_ON. [Greg]
- Drop unused forward declaration of struct platform_device.
- Move kernel doc from the function declarations to the definitions. [Greg]
- Use unsigned values for the state in the consumer interface. [Philipp]
- WARN if consumers request an invalid state. [Philipp]
- Split out mux-gpio from the core patch (03/10 -> 03/11 and 04/11). [Greg]
- Drop OF Kconfig dep from mux-gpio. [Greg]
- Fail the adg792a probe if the I2C adapter does not support
  I2C_FUNC_SMBUS_BYTE_DATA.
- For clarity, handle the adg792a active low reset bit in a helper function.
- Make use of the preexisting mux variable in the adg792a driver instead of
  chasing the same pointers a second time.
- Use device_property_read_* instead of of_property_read_* in adg792a.
- Added a "thank you" section to the patch adding the mux core (patch 03/11).

v12 -> v13 changes:  https://lkml.org/lkml/2017/4/13/493
- Philipp Zabel noticed a bad compatible string in the gpio muxer.
  I amended patch 3/10 with his patch.
- Fixed reversed sense of the reset bit in the adg792 muxer (patch 10/10).

v11 -> v12 changes:  https://lkml.org/lkml/2017/3/27/464
- patches 11 and 12 folded into patches 6 and 3 respectively.

v10 -> v11 changes:  https://lkml.org/lkml/2017/3/27/336
- added a fixes-tag and an ack from Jonathan on patch 11
- added a new patch (12) with a fix for messed up error path reported
  by Paul Gortmaker.
- fixed some editorial nitpicks in the documentation comments in patch 3.

v9 -> v10 changes:  https://lkml.org/lkml/2017/3/10/411
- rebased onto v4.11-rc1
- added reviewed-by tags from Rob on patches 7 and 9
- added a new patch (11) with a fix for an unsigned compare with less than
  zero detected by CoverityScan and reported by Colin Ian King
- allowed the mux core to be built as a module, after discussion with Paul
  Gortmaker
- added explicit includes of linux/export.h and linux/init.h from the mux
  core, also noted by Paul
- fixed trivial whitespace issue in drivers/mux/Makefile
- added trailing '>' after my mail address in MODULE_AUTHOR, which was missing
  in all new modules in drivers/mux

v8 -> v9 changes:  https://lkml.org/lkml/2017/2/8/394
- dropped the suffix from the compatible string of the i2c-mux-simple
  binding (was ,mux-locked or ,parent-locked) and add an optional
  mux-locked property instead to change the desired locking behavior
  from the default parent-locked
- add description of the difference between mux-locked and parent-locked
- renamed i2c-mux-simple to i2c-mux (bindings for this general purpose
  i2c mux are in i2c-mux-gpmux.txt since i2c-mux.txt is already occupied
  by the common i2c-mux bindings)
- changed compatible from mux-gpio to gpio-mux
- changed bindings for idle-state back to a single array, but add defines
  for as-is and hi-Z thus avoiding magic numbers
- make use of the above defines in the code as well
- make idle-state a common mux property described in mux-controller.txt
  instead of repeating the info in individual mux controller bindings
- drop the adi,parallel property from the adg792 bindings and piggy-back
  on the #mux-control-cells property
- refrain from using the compatible string as node name
- dropped the simplified bindings for single-user gpio mux
- added acks on patches 2/10 and 5/10 from Rob

v7 -> v8 changes:  https://lkml.org/lkml/2017/1/18/745
- cleanup the implementation of the simplified gpio bindings, but still...
- ...reorder patches so that they appear last in the series (patches 11
  and 12 were patches 4 and 5 in v7) since Jonathan convinced me that
  they were perhaps not such a good idea after all. But I still wanted
  to show the last version I had and I'm still a bit undecided...
- added some words to the remaining otherwise empty commit messages
- added various acks/reviews from Jonathan and Wolfram.
- move mux last in drivers/Kconfig and drivers/Makefile
- bump copyright years
- centralize error reporting of common operatinons to the mux core
- add WARN_ON for faulty usage of mux_chip_register
- simplify code for other WARN_ON call sites

v6 -> v7 changes:  https://lkml.org/lkml/2017/1/4/315
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

v5 -> v6 changes:  https://lkml.org/lkml/2016/11/30/466
- fix stupidity in mux_chip_priv, mux_gpio_remove and adg792a_remove.
- change the devicetree bindings for the iio-mux to use a list of strings
  (channels property) instead of a list children.

v4 -> v5 changes:  https://lkml.org/lkml/2016/11/29/224
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

v3 -> v4 changes:  https://lkml.org/lkml/2016/11/24/664
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

v2 -> v3 changes:  https://lkml.org/lkml/2016/11/21/332
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

v1 -> v2 changes:  https://lkml.org/lkml/2016/11/17/918
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

v1:  https://lkml.org/lkml/2016/11/16/812

Cheers,
peda

Peter Rosin (11):
  devres: trivial whitespace fix
  dt-bindings: document devicetree bindings for mux-controllers and
    gpio-mux
  mux: minimal mux subsystem
  mux: gpio: add mux controller driver for gpio based multiplexers
  iio: inkern: api for manipulating ext_info of iio channels
  dt-bindings: iio: io-channel-mux: document io-channel-mux bindings
  iio: multiplexer: new iio category and iio-mux driver
  dt-bindings: i2c: i2c-mux: document general purpose i2c-mux bindings
  i2c: i2c-mux-gpmux: new driver
  dt-bindings: mux-adg792a: document devicetree bindings for ADG792A/G
    mux
  mux: adg792a: add mux controller driver for ADG792A/G

Philipp Zabel (2):
  dt-bindings: add mmio-based syscon mux controller DT bindings
  mux: mmio-based syscon mux controller

 Documentation/ABI/testing/sysfs-class-mux          |  16 +
 .../devicetree/bindings/i2c/i2c-mux-gpmux.txt      |  99 ++++
 .../bindings/iio/multiplexer/io-channel-mux.txt    |  39 ++
 .../devicetree/bindings/mux/adi,adg792a.txt        |  75 +++
 Documentation/devicetree/bindings/mux/gpio-mux.txt |  69 +++
 Documentation/devicetree/bindings/mux/mmio-mux.txt |  60 +++
 .../devicetree/bindings/mux/mux-controller.txt     | 157 ++++++
 Documentation/driver-model/devres.txt              |   7 +-
 MAINTAINERS                                        |  16 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/i2c/muxes/Kconfig                          |  13 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-gpmux.c                  | 173 +++++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/inkern.c                               |  60 +++
 drivers/iio/multiplexer/Kconfig                    |  18 +
 drivers/iio/multiplexer/Makefile                   |   6 +
 drivers/iio/multiplexer/iio-mux.c                  | 459 +++++++++++++++++
 drivers/mux/Kconfig                                |  59 +++
 drivers/mux/Makefile                               |   8 +
 drivers/mux/mux-adg792a.c                          | 157 ++++++
 drivers/mux/mux-core.c                             | 547 +++++++++++++++++++++
 drivers/mux/mux-gpio.c                             | 114 +++++
 drivers/mux/mux-mmio.c                             | 141 ++++++
 include/dt-bindings/mux/mux.h                      |  16 +
 include/linux/iio/consumer.h                       |  37 ++
 include/linux/mux/consumer.h                       |  32 ++
 include/linux/mux/driver.h                         | 108 ++++
 30 files changed, 2491 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-mux
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/adi,adg792a.txt
 create mode 100644 Documentation/devicetree/bindings/mux/gpio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mmio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/mux-controller.txt
 create mode 100644 drivers/i2c/muxes/i2c-mux-gpmux.c
 create mode 100644 drivers/iio/multiplexer/Kconfig
 create mode 100644 drivers/iio/multiplexer/Makefile
 create mode 100644 drivers/iio/multiplexer/iio-mux.c
 create mode 100644 drivers/mux/Kconfig
 create mode 100644 drivers/mux/Makefile
 create mode 100644 drivers/mux/mux-adg792a.c
 create mode 100644 drivers/mux/mux-core.c
 create mode 100644 drivers/mux/mux-gpio.c
 create mode 100644 drivers/mux/mux-mmio.c
 create mode 100644 include/dt-bindings/mux/mux.h
 create mode 100644 include/linux/mux/consumer.h
 create mode 100644 include/linux/mux/driver.h

-- 
2.1.4

