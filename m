Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60090 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756753AbcJWVOY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2016 17:14:24 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] First set of new drivers, features and cleanups for IIO in the
 4.10 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a7987bd2-812f-ad93-e76e-953995c45366@kernel.org>
Date: Sun, 23 Oct 2016 22:14:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a04c28d0797bb9b8743efe814672dea8e3b91c55:

  Staging: speakup: kobjects: Add space around the operator. (2016-09-22 12:01:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.10a

for you to fetch changes up to 30df2d1879ff65af7b269ee94e9c7fc276b54105:

  iio: dac: mcp4725: fix odd_ptr_err.cocci warnings (2016-10-23 19:34:27 +0100)

----------------------------------------------------------------
First round of IIO new device support, features and cleanups for the 4.10 cycle.

Fair number of outreachy related patches in here. Some of these may well
have already been picked up by Greg but git will sort that out for us.

Also some good staging cleanup work from other sources. Thanks Brian and Lars
in particular for this.

New device support
* ACCES 104-quad-8
  - New driver for this 8 channel encoder input board. Lots of new ABI with
    this one.
* AD7766
  - New driver supporting AD7766, AD7766-1, AD7766-2, AD7767, AD7767-1 and
    AD7767-2 24 bit ADCs.
* dmard 10
  - New driver for this 3 axis accelerometer.
* Honeywell ABP pressure sensors.
  - New driver covering 56 parts in this series (too many to list here!)
* HTS221
  - New driver to support this relative humidiy and temperature device.
* LMP91000
  - New driver for this potentiostat (form of chemical sensor). Nice example
    of use of the buffered consumer interfaces and the use of a consumer
    provided trigger.
* MiraMEMS DA311
  - New driver for this 3 axis accelerometer.
* MiraMEMS DA280
  - New driver for this 3 axis accelerometer. Follow up caught up with
  vendor prefixes for these.

Staging graduations
* isl29018 light sensor
  - Fixes and cleanups listed below (thanks for your hard work on this Brian!)
* sca3000
  - Fixes and cleanups listed below.  This was one of the small set of drivers
  that went into staging when IIO was first added.  Turns out it had a few
  bugs and needed to be brought into the modern era!  Not clear if I am
  the only person who actually has one of these still wired to a board.

New features (Core)
 - Add an iio_trigger_validate_own_device helper which relies on the device
   and trigger having the same parent.  Convenient to have this for some
   of the more complex trigger / device interactions. Was hand rolled in
   a few drivers already so good to bring it into the core.
 - Add an iio_read_channel_offset in kernel access helper (similar to
   the existing one for scale).
 - IIO_ATTR_{RO, WO, RW} and IIO_DEVICE_ATTR_{RO, WO, RW} macros.  These
   lead some rather contrived function naming, but there is no denying they
   do reduced boilerplate.  I'm going to resist their introduction in
   drivers 'unless' they form part of a larger set of cleanups.
 - Counter channel type and index type.

New features (Drivers)
* hdc100x
  - Triggered buffer support.
* mcp4725
  - Device tree bindings and support.
  - Voltage reference selection.
* ti-adc0832
  - Triggered buffer support.
* ti-adc161s626
  - Add regulator support allowing _scale and _offset values to be established
  and exported.

New features (Tools)
* iio_generic_buffer
  - -A option to force enable all channels rather than faulting if some are
  already enabled (like -a does).  Followup patches tidied this support up.

Cleanups (Core)
 - Use kmalloc_array in iio_scan_mask_set.
 - Take event_attrs field of iio_info structure constant
 - Staging todo list updates. Most of it was long done.
 - MAINTAINERS had a wrong directory listing.

Cleanups (Drivers)
* Missing i2c trivial devices entries.
* ad5592r
  - Fix an endian type related sparse warnings.
* ad7150
  - Constify the event attribute_group structures.
* ad7152
  - Add some blank lines to improve readability.
  - Sampling frequency control via chan-info element rather than hand rolled
  attributes.
  - add a new lock to avoid use of mlock for non state change related locking.
* ad7280
  - Constify atrribute_group structure (second patch covers the event ones)
* ad7606 (Lars is driving most of the cleanup on this with some additions from
  Eva)
  - Fix improper setting of oversampling pins.  This has been broken a very
  long time in this staging driver, so not going to push this back to stable.
  - Implement oversampling configuration via the chan_info mask element.
  - Remove an unused int_vref_mv field.
  - Remove a reundant name field from ad7606_chip_info.
  - Remove default device configuration from platform_data in favour of
  whatever the power on defaults are.
  - Remove out of band error reporting in the kernel log as not providing
  much information.
  - Fix oversampling ratio by having 1 be the value for no oversampling.
  - Avoid allocating buffer for each data capture.
  - Factor out common code between periodic and one-shot capture.
  - Move set_drvdat into common code.
  - Let the common probe function return int rather than jumping through
  an ERR_PTR.
  - Pass struct device * into common remove to simplify code.
  - Always run trigger handler only once per event (no one can remember why
  it was being possibly done twice).
  - Move over to the GPIO descriptor API to shorten and clarify code.
  - Move the buffer code into the main file as it's not optional and is
  now rather short in this driver.
  - Fix the naming of the supply regulator.
  - Rework regulator handling to handle errors including deferred probing.
  - Tidy up a ptr_err or 0 return.
* ad7746
  - Sampling frequency control via info_mask element rather than hand rolled
* ad7758
  - Sampling frequency control via info_mask element rather than hand rolled
  attributes.
* ad7816
  - Constify the event attribute_group structure.
* adt7316
  - Constify the event attribute group structures.
* ak8974
  - Cleanup some sparse warnings about endian types.
* ak8975
  - Cleanup some sparse warnings about endian types.
* bmi160
  - Spare endian warning cleanups.
* isl29018 (towards staging graduation)
  - Remove unusedvariables and defines.
  - Improve consistency of error handling.
  - Signed / unsigned comparison fixes.
  - Use the IIO_DEVICE_ATTR_{RO, RW} macros
  - Fix a race in in_illuminance_scale_available_show.
  - Cleanup exit points of _read_raw
  - Sanity check if in suspended state during a write_raw call as was already
    done for read_raw.
  - Document device tree bidnings.
  - Document infrared supression controls.
  - Add some newlines to improve readability and drop one that shouldn't be
    there.
  - Fix a poorly named functions name.
  - Fix multiline coment syntax.
  - Tidy up a pair or return statements by unifying them.
  - Rename description in Kconfig for consistency with similar drivers.
* lidar
  - cleanup power management by dropping unnecessary call.
* ltr501
  - Use the claim_direct_mode helpers. Fix a race condition along the way.
* max1027
  - Fix a dubious x | !y sparse warning.
  - Use the new iio_trigger_validate_own_device helper.
* max440000
  - Clean up some sparse warnings about endian types.
* mcp4725
  - Use the regulator framework to establish the reference voltage rather than
    getting it from platform data.
  - Tidy up a comment typo.
  - Fix a wrong PTR_ERR query (wrong regulator).
* mma7660
  - Take a mma7660_nscale static.
* mma8452
  - Use the new iio_trigger_validate_own_device helper.
  - Use claim_direct_mode helpers - fix a race condition along the way.
* mpl3115
  - Use claim_direct_mode helpers - fix a race condition along the way.
* ms65611
  - Tidy up regulator error handling and clean out a static warning in the mix.
* sca3000
  - Avoid a potential unitialized variable if a hardware read returns a value
  that isn't actually supported (mostly warning supression).
  - Fix a use before setting of the indio_dev->buffer pointer. Broken for
  a very long time so not going to rush this into stable.
  - Merge buffer file with core file.  We used to always split these.
  Sometimes it's just not worth the hassle. In this case the device's main
  feature is it's hardware fifos so unlikely anyone would want to run it
  without.
  - Drop the sca3000_register_ring_funcs function as it's a pointless wrapper
  once we have only one file.
  - Fix cleaning of flag + setting of size of scan. Without this you can't
  start the buffer twice and expect sensible (or any) results.  Again,
  broken for a long time so not heading for stable.
  - Drop the custom watershed setting ABI - for now we'll just support one
  value.
  - Move to a hybrid hard / soft buffer design (how we've been doing it
  for similar devices for a while now!)
  - Cleanup some unusued variables.
  - Use a fake channel to support core handling of freefall event registration.
  - Cleanup the register defines.
  - Fix an off by one error in axis due to IIO_NO_MOD taking up the 0 value.
  Been broken since first admission of IIO to the staging tree.
  - Add readback of the 3db low pass filter frequency and later writing
    allowing droppign of custom measurement mode attributes as they can
    be represented by the filter choices that is their main characteristic.
  - Drop non standard revision attr and replace with dev_info on probe.
  - Avoid a race in probe.
  - Various formatting fixes.
  - Kernel-docify docs that were very nearly in the write format.
* tsl2583
  - Constify attribute_group structure.
* zpa2326
  - Drop a redundant DEBUG ifdef.

Cleanups (Tools)
* iio_generic_buffer
  - Fix the ? arguement. Previously it sort of worked as you got the help
    message as a result of it not recognising the arguement.

----------------------------------------------------------------
Akinobu Mita (1):
      iio: ti-adc0832: add triggered buffer support

Alison Schofield (5):
      iio: accel: mma8452: claim direct mode during raw reads
      iio: pressure: mpl3115: claim direct mode during raw reads
      iio: light: ltr501: claim direct mode during select raw reads
      iio: light: ltr501: claim direct mode during raw writes
      iio: humidity: hdc100x: add triggered buffer support for HDC100X

Anchal Jain (1):
      staging: iio: cdc: ad7152: Add blank line after declarations to increase readability

Arnd Bergmann (2):
      iio: accel: sca3000_core: avoid potentially uninitialized variable
      iio:pressure: zpa2326: remove redundant "DEBUG" ifdef

Bhumika Goyal (7):
      Staging:iio:adc:ad7280a: constify attribute_group structures
      Staging:iio:light:tsl2583: constify attribute_group structures
      iio: Declare event_attrs field of iio_info structure as const
      Staging: iio: ad7280a: constify attribute_group structures
      Staging: iio: ad7816: constify attribute_group structures
      Staging: iio: addac: constify attribute_group structures
      Staging: iio: ad7150: constify attribute_group structures

Brian Masney (18):
      staging: iio: isl29018: remove unused variable and defines
      staging: iio: isl29018: made error handling consistent
      staging: iio: isl29018: fix comparison between signed and unsigned integers
      include: linux: iio: add IIO_ATTR_{RO, WO, RW} and IIO_DEVICE_ATTR_{RO, WO, RW} macros
      staging: iio: isl29018: use IIO_DEVICE_ATTR_{RO, RW} macros
      staging: iio: isl29018: fixed race condition in in_illuminance_scale_available_show()
      staging: iio: isl29018: change isl29018_read_raw() to only have one exit point
      staging: iio: isl29018: check if the chip is in a suspended state
      staging: iio: isl29018: document device tree bindings
      staging: iio: isl29018: add documentation about the infrared suppression
      staging: iio: isl29018: add newlines to improve readability
      staging: iio: isl29018: fix poorly named function
      staging: iio: isl29018: fix multiline comment syntax
      staging: iio: isl29018: combine two return statements into one
      staging: iio: isl29018: remove blank line for consistency
      staging: iio: isl29018: rename description in Kconfig for consistency
      staging: iio: isl29018: add ABI documentation for infrared suppression
      staging: iio: isl29018: move out of staging

Crt Mori (1):
      iio: ms65611_core: Fixes dereferencing regulator pointer

Dan Carpenter (1):
      Staging: iio: fix a MAINTAINERS entry

Eva Rachel Retuya (9):
      staging: iio: ad7606: fix improper setting of oversampling pins
      staging: iio: ad7606: implement IIO_CHAN_INFO_OVERSAMPLING_RATIO
      staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ
      staging: iio: cdc: ad7746: implement IIO_CHAN_INFO_SAMP_FREQ
      tools: iio: iio_generic_buffer: add -A to force-enable all channels
      tools: iio: iio_generic_buffer: rename and change type of force variable
      tools: iio: iio_generic_buffer: drop unneeded parentheses
      staging: iio: ad7606: set proper supply name to devm_regulator_get()
      staging: iio: ad7606: rework regulator handling

Hans de Goede (5):
      dt: bindings: i2c/trivial-devices.txt: Add 2 iio supported accelerometers
      iio: accel: Add driver for dmard10 3-axis Accelerometer
      iio: accel: Add driver for the MiraMEMS DA311 3-axis 12-bit digital accelerometer
      iio: accel: Add driver for the MiraMEMS DA280 3-axis 14-bit digital accelerometer
      dt: bindings: vendor-prefix: Add 3 accelerometer vendor prefixes

Ico Doornekamp (1):
      iio: magnetometer: ak8974: small endianness fixes

Jonathan Cameron (20):
      staging:iio:TODO drop outdated entries in this todo.
      iio: accel: mma8452: claim direct mode during write raw
      staging:iio:accel:sca3000 Fix a use before setting of the indio_dev->buffer pointer.
      staging:iio:accel:sca3000 merge files into one.
      staging:iio:accel:sca3000 drop sca3000_register_ring_funcs
      staging:iio:accel:sca3000 Fix clearing of flag + setting of size of scan.
      staging:iio:accel:sca3000 Drop custom ABI for watersheds.
      staging:iio:accel:sca3000 move to hybrid hard / soft buffer design.
      staging:iio:accel:sca3000 drop some unused variables.
      staging:iio:accel:sca3000 use a 'fake' channel to handle freefall event registration.
      staging:iio:accel:sca3000 Clean up register defines.
      staging:iio:accel:sca3000 add readback of the 3db low pass filter frequency
      staging:iio:accel:sca3000: Fix off by one error in axis due to IIO_NO_MOD
      staging:iio:accel:sca3000 Add write support to the low pass filter control
      staging:iio:accel:sca3000 Drop custom measurement mode attributes
      staging:iio:accel:sca3000 replace non standard revision attr with dev_info on probe
      staging:iio:accel:sca3000 Tidy up probe order to avoid a race.
      staging:iio:accel:sca3000 small checkpatch fixes (alignment etc)
      staging:iio:accel:sca3000 kernel docify comments that were nearly kernel doc.
      staging:iio:accel:sca3000 Move out of staging.

Julia Lawall (1):
      iio: dac: mcp4725: fix odd_ptr_err.cocci warnings

Lars-Peter Clausen (17):
      iio:trigger: Add helper function to verify that a trigger belongs to the same device
      iio:mma8452: Use new iio_trigger_validate_own_device() helper
      iio:max1027: Use iio_trigger_validate_own_device() helper
      iio:adc: Add support for AD7766/AD7767
      staging:iio:ad7606: Remove unused int_vref_mv field
      staging:iio:ad7606: Remove redundant name field from ad7606_chip_info
      staging:iio:ad7606: Remove default device configuration from platform data
      staging:iio:ad7606: Remove out-of-band error reporting
      staging:iio:ad7606: Use oversampling ratio of 1 for no oversampling
      staging:iio:ad7606: Avoid allocating buffer for each data capture
      staging:iio:ad7606: Factor out common code between periodic and one-shot capture
      staging:iio:ad7606: Move set_drvdata() into common code
      staging:iio:ad7606: Let the common probe function return int
      staging:iio:ad7606: Let common remove function take a struct device *
      staging:iio:ad7606: Run trigger handler only once per trigger event
      staging:iio:ad7606: Use GPIO descriptor API
      staging:iio:ad7606: Move buffer code to main source file

Lorenzo Bianconi (2):
      iio: humidity: add support to hts221 rh/temp combo device
      Documentation: dt: iio: humidity: add hts221 sensor device binding

Marcin Malagowski (1):
      iio: pressure: Add driver for Honeywell ABP family

Markus Elfring (1):
      iio: Use kmalloc_array() in iio_scan_mask_set()

Matt Ranostay (4):
      iio: inkern: add iio_read_channel_offset helper
      iio: adc: ti-adc161s626: add regulator support
      iio: potentiostat: add LMP91000 support
      iio: proximity: pulsedlight-lidar-lite-v2: cleanup power management

Mugunthan V N (1):
      tools: iio: iio_generic_buffer: fix argument '?' option

Sandhya Bankar (5):
      drivers: iio: max1027: Fix sparse warning: "dubious: x | !y"
      drivers: iio: dac: Fix sparse warning
      drivers: iio: light: Fix sparse warnings
      drivers: iio: magnetometer: Fix sparse endianness warnings cast to restricted __be16
      Staging: iio: meter: ade7758_core: implement IIO_CHAN_INFO_SAMP_FREQ

Tomas Novotny (5):
      iio: dac: mcp4725: use regulator framework
      iio: dac: mcp4725: fix incorrect comment
      Documentation: dt: iio: add mcp4725/6 dac device binding
      iio: dac: mcp4725: support voltage reference selection
      iio: dac: mcp4725: add devicetree support

Wei Yongjun (1):
      iio: accel: mma7660: fix non static symbol warning

William Breathitt Gray (2):
      iio: Implement counter channel type and info constants
      iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8

kbuild test robot (1):
      staging:iio:ad7606: fix ptr_ret.cocci warnings

sayli karnik (3):
      staging: iio: cdc: ad7152: Implement IIO_CHAN_INFO_SAMP_FREQ attribute
      staging: iio: cdc: ad7152: Replace mlock with a local mutex lock
      iio: bmi160_core: Fix sparse warning due to incorrect type in assignment

 Documentation/ABI/testing/sysfs-bus-iio            |   18 +
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   |  125 ++
 .../ABI/testing/sysfs-bus-iio-light-isl29018       |   19 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |    6 +
 .../devicetree/bindings/iio/adc/ti-adc161s626.txt  |    2 +
 .../devicetree/bindings/iio/dac/mcp4725.txt        |   35 +
 .../devicetree/bindings/iio/humidity/hts221.txt    |   22 +
 .../devicetree/bindings/iio/light/isl29018.txt     |   28 +
 .../bindings/iio/potentiostat/lmp91000.txt         |   30 +
 .../devicetree/bindings/vendor-prefixes.txt        |    3 +
 MAINTAINERS                                        |    8 +-
 drivers/iio/Kconfig                                |    2 +
 drivers/iio/Makefile                               |    2 +
 drivers/iio/accel/Kconfig                          |   42 +
 drivers/iio/accel/Makefile                         |    5 +
 drivers/iio/accel/da280.c                          |  183 +++
 drivers/iio/accel/da311.c                          |  305 ++++
 drivers/iio/accel/dmard10.c                        |  266 ++++
 drivers/iio/accel/mma7660.c                        |    2 +-
 drivers/iio/accel/mma8452.c                        |   79 +-
 drivers/iio/accel/sca3000.c                        | 1576 ++++++++++++++++++++
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7766.c                           |  330 ++++
 drivers/iio/adc/max1027.c                          |   17 +-
 drivers/iio/adc/ti-adc0832.c                       |  106 +-
 drivers/iio/adc/ti-adc161s626.c                    |   55 +-
 drivers/iio/counter/104-quad-8.c                   |  593 ++++++++
 drivers/iio/counter/Kconfig                        |   24 +
 drivers/iio/counter/Makefile                       |    7 +
 drivers/iio/dac/ad5592r.c                          |    2 +-
 drivers/iio/dac/mcp4725.c                          |  176 ++-
 drivers/iio/humidity/Kconfig                       |   24 +
 drivers/iio/humidity/Makefile                      |    7 +
 drivers/iio/humidity/hdc100x.c                     |  130 +-
 drivers/iio/humidity/hts221.h                      |   73 +
 drivers/iio/humidity/hts221_buffer.c               |  169 +++
 drivers/iio/humidity/hts221_core.c                 |  687 +++++++++
 drivers/iio/humidity/hts221_i2c.c                  |  110 ++
 drivers/iio/humidity/hts221_spi.c                  |  125 ++
 drivers/iio/imu/bmi160/bmi160_core.c               |    3 +-
 drivers/iio/industrialio-buffer.c                  |    7 +-
 drivers/iio/industrialio-core.c                    |    2 +
 drivers/iio/industrialio-trigger.c                 |   21 +
 drivers/iio/inkern.c                               |   39 +-
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/{staging => }/iio/light/isl29018.c         |  159 +-
 drivers/iio/light/ltr501.c                         |  111 +-
 drivers/iio/light/max44000.c                       |    5 +-
 drivers/iio/magnetometer/ak8974.c                  |    8 +-
 drivers/iio/magnetometer/ak8975.c                  |   16 +-
 drivers/iio/potentiostat/Kconfig                   |   22 +
 drivers/iio/potentiostat/Makefile                  |    6 +
 drivers/iio/potentiostat/lmp91000.c                |  446 ++++++
 drivers/iio/pressure/Kconfig                       |   10 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/abp060mg.c                    |  276 ++++
 drivers/iio/pressure/mpl3115.c                     |   26 +-
 drivers/iio/pressure/ms5611_core.c                 |   19 +-
 drivers/iio/pressure/zpa2326.c                     |    4 -
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    2 -
 drivers/staging/iio/TODO                           |   70 +-
 drivers/staging/iio/accel/Kconfig                  |   10 -
 drivers/staging/iio/accel/Makefile                 |    3 -
 drivers/staging/iio/accel/sca3000.h                |  279 ----
 drivers/staging/iio/accel/sca3000_core.c           | 1208 ---------------
 drivers/staging/iio/accel/sca3000_ring.c           |  350 -----
 drivers/staging/iio/adc/Makefile                   |    1 -
 drivers/staging/iio/adc/ad7192.c                   |   84 +-
 drivers/staging/iio/adc/ad7280a.c                  |    4 +-
 .../staging/iio/adc/{ad7606_core.c => ad7606.c}    |  436 +++---
 drivers/staging/iio/adc/ad7606.h                   |   58 +-
 drivers/staging/iio/adc/ad7606_par.c               |   23 +-
 drivers/staging/iio/adc/ad7606_ring.c              |  102 --
 drivers/staging/iio/adc/ad7606_spi.c               |   19 +-
 drivers/staging/iio/adc/ad7816.c                   |    2 +-
 drivers/staging/iio/addac/adt7316.c                |    4 +-
 drivers/staging/iio/cdc/ad7150.c                   |    2 +-
 drivers/staging/iio/cdc/ad7152.c                   |  140 +-
 drivers/staging/iio/cdc/ad7746.c                   |  120 +-
 drivers/staging/iio/light/Kconfig                  |   12 -
 drivers/staging/iio/light/Makefile                 |    1 -
 drivers/staging/iio/light/tsl2583.c                |    2 +-
 drivers/staging/iio/meter/ade7758_core.c           |   86 +-
 drivers/staging/iio/ring_hw.h                      |   27 -
 include/linux/iio/adc/ad_sigma_delta.h             |    1 +
 include/linux/iio/consumer.h                       |   13 +
 include/linux/iio/dac/mcp4725.h                    |   12 +-
 include/linux/iio/iio.h                            |    2 +-
 include/linux/iio/sysfs.h                          |   24 +
 include/linux/iio/trigger.h                        |    2 +
 include/uapi/linux/iio/types.h                     |    2 +
 tools/iio/iio_generic_buffer.c                     |   18 +-
 94 files changed, 6844 insertions(+), 2877 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-isl29018
 create mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29018.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
 create mode 100644 drivers/iio/accel/da280.c
 create mode 100644 drivers/iio/accel/da311.c
 create mode 100644 drivers/iio/accel/dmard10.c
 create mode 100644 drivers/iio/accel/sca3000.c
 create mode 100644 drivers/iio/adc/ad7766.c
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile
 create mode 100644 drivers/iio/humidity/hts221.h
 create mode 100644 drivers/iio/humidity/hts221_buffer.c
 create mode 100644 drivers/iio/humidity/hts221_core.c
 create mode 100644 drivers/iio/humidity/hts221_i2c.c
 create mode 100644 drivers/iio/humidity/hts221_spi.c
 rename drivers/{staging => }/iio/light/isl29018.c (88%)
 create mode 100644 drivers/iio/potentiostat/Kconfig
 create mode 100644 drivers/iio/potentiostat/Makefile
 create mode 100644 drivers/iio/potentiostat/lmp91000.c
 create mode 100644 drivers/iio/pressure/abp060mg.c
 delete mode 100644 drivers/staging/iio/accel/sca3000.h
 delete mode 100644 drivers/staging/iio/accel/sca3000_core.c
 delete mode 100644 drivers/staging/iio/accel/sca3000_ring.c
 rename drivers/staging/iio/adc/{ad7606_core.c => ad7606.c} (50%)
 delete mode 100644 drivers/staging/iio/adc/ad7606_ring.c
 delete mode 100644 drivers/staging/iio/ring_hw.h
