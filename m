Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34013 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3JSKYj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Oct 2013 06:24:39 -0400
Message-ID: <52626C1C.2070105@kernel.org>
Date: Sat, 19 Oct 2013 12:25:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.13 - set 4
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit edf7abde26cd2625fe17a1a1f6a35aa758f72cd0:

  Staging: iio: adt7316-i2c: quoted string split across lines (2013-10-06 23:02:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.12d

for you to fetch changes up to 43e01beda4b578e947aafb5b5ee19e5bb598e8ca:

  iio: light: gp2ap020a00f: Include linux/of.h header (2013-10-18 20:05:57 +0100)

----------------------------------------------------------------
Fourth round of IIO new drivers, functionality and cleanups for the 3.13 cycle.

New Drivers
* cm36651 combined RGB light and proximity sensor.

Core improvements

* Some more fixes and cleanups related to buffers.  These include the second
  half of a series which went is as fixes.  The basis for delaying until the
  next merge window is that some are too invasive for this late in a cycle
  and others only effect code paths current unused in the mainline tree.
  In this case we have:
   * protecting against concurrent userspace access
   * fixing a memory leak if a device goes away
   * avoiding always reallocating the buffer whether or not it has changed
     (a bug fix, but one with no functional changes other than a small speed
     improvement.)
   * Add reference counting for buffers to ensure they hang around if open
     from userspace or in kernel when the device is forcefully removed.
   * Return -ENODEV for buffer access operations when the device has gone
     away.
   * Add proper locking for iio_update_buffers (currently we only have one
     buffer per device in mainline, but an input bridge driver is under
     development which would make this bug 'real'.)
   * Wake up anyone waiting on a buffer if the device is unregistered.  A
     subsequent read will fail, notifying userspace that the device is no
     longer there rather than having it wait possibly for ever.

* Move the iio_sw_preenable functionality into the core.  This avoids drivers
  having to 'know' about how the buffers are implemented and is called by
  almost all drivers anyway.  Those that don't call it are not harmed by it
  being called.
* New registration approach for information (i.e. sysfs attributes) about
  events.  Much more generic and now similar to how the equivalent is
  handled for channel information.  The events infrastructure had been left
  behind by other changes so this brings it back in line.
* Using the new events registration approach, add a hysterisis event_info
  element and apply this to those drivers with this property.
* A little unitialized variable bug in the generic_buffer.c example.
* Factor out the code for freeing lists of IIO Device attributes to avoid
  some repitition.

Driver cleanups
* At91 driver gains touch screen support and some related fixes.
* Follow up series of patches removing the now redundant
  iio_sw_buffer_preenable calls.
* Lots of conversions to the new event registration methods.
* Another round of hmc5843 cleanups as that driver moves towards graduating
  from staging.
* Make some SoC drivers buildable if COMPILE_TEST is used.  Follow up fixes
  for a few bits and bobs that revealed.
* Add explicit includes of linux/of.h to those drivers making us of linux/of.h

----------------------------------------------------------------
Beomho Seo (2):
      iio: cm36651: Add CM36651 proximity/light sensor
      DT: Add documentation for cm36651 proximity/light sensor

Josh Wu (3):
      iio: at91: ADC start-up time calculation changed since at91sam9x5
      iio: at91: move the num_channels from DT to driver itself
      iio: at91: introduce touch screen support in iio adc driver

Lars-Peter Clausen (52):
      iio: Add reference counting for buffers
      iio: Return -ENODEV for file operations if the device has been unregistered
      iio: Wakeup poll and blocking reads when the device is unregistered
      iio:buffer: Add proper locking for iio_update_buffers()
      iio: Add a helper to free a list of IIO device attributes
      iio: Factor IIO value formating into its own function
      iio: Extend the event config interface
      iio:max1363: Switch to new event config interface
      iio:ad5421: Switch to new event config interface
      iio:gp2ap020a00f: Switch to new event config interface
      iio:tsl2563: Switch to new event config interface
      iio:apds9300: Use new event config interface
      staging:iio:lis3l02dq: Switch to new event config interface
      staging:iio:lis2l02dq: Share threshold value between axis
      staging:iio:sca3000: Switch to new config interface
      staging:iio:ad7291: Switch to new event config interface
      staging:iio:ad799x: Switch to new event config interface
      staging:iio:ad7150: Switch to new event config interface
      staging:iio:simple_dummy: Switch to new event config interface
      staging:iio:tsl2x7x: Switch to new event config interface
      iio: Add a hysteresis event info attribute
      staging:iio:ad799x: Simplify threshold register look-up
      staging:iio:ad799x: Use event spec for threshold hysteresis
      staging:iio:ad7291: Use event spec for threshold hysteresis
      iio:buffer: Ignore noop requests for iio_update_buffers()
      staging:iio:spear_adc: Remove unused variable
      staging:iio:spear_adc: Fix sparse warning
      staging:iio:mxs-lradc: Select STMP_DEVICE
      staging:iio: Allow to build SoC specific drivers when COMPILE_TEST is set
      iio:kfifo: Fix memory leak
      iio:kfifo: Protect against concurrent access from userspace
      iio:kfifo: Empty buffer on update
      iio:kfifo: Set update_needed to false after allocating a new buffer
      iio: Update buffer's bytes per datum after updating the scan mask
      iio:st_accel: Drop redundant call to iio_sw_buffer_preenable()
      iio:ad7266: Remove redundant call to iio_sw_preenable()
      iio:ad7887: Remove redundant call to iio_sw_buffer_preenable().
      iio:ad_sigma_delta: Remove redundant call to iio_sw_buffer_preenable().
      iio:ti_am335x: Remove redundant call to iio_sw_buffer_preenable()
      iio:st_gyro: Remove redundant call to iio_sw_buffer_preenable().
      iio:triggered-buffer: Remove redundant call to iio_sw_buffer_preenable().
      iio:st_magn: Remove redundant call to iio_sw_buffer_preenable().
      iio:st_pressure: Remove redundant call to iio_sw_buffer_preenable().
      iio:gp2ap020a00f: Remove redundant call to iio_sw_buffer_preenable()
      staging:iio:lis3l02dq: Remove redundant call to iio_sw_buffer_preenable().
      staging:iio:mxs-lradc: Remove redundant call to iio_sw_buffer_preenable()
      staging:iio:simple-dummy: Remove redundant call to iio_sw_buffer_preenable()
      staging:iio:ad5933: Remove redundant call to iio_sw_buffer_preenable()
      staging:iio:ade7758: Remove redundant call to iio_sw_buffer_preenable()
      iio: Remove unused iio_sw_buffer_preenable()
      staging:iio:lpc32xx_adc: Fix IRQ check
      staging:iio:spear_adc: Fix IRQ check

Peter Meerwald (11):
      staging:iio:hmc5843: Use SCALE instead of magn_range
      staging:iio:hmc5843: Rename _check_samp_freq to get_samp_freq_index
      staging:iio:hmc5843: Always read all channels values otherwise no updates
      staging:iio:hmc5843: Add trigger handling
      staging:iio:hmc5843: Remove ability to change operating mode
      staging:iio:hmc5843: Rename _configure() to _set_mode()
      staging:iio:hmc5843: Reorganize _set_meas_conf()
      staging:iio:hmc5843: Rename _set_rate() to _set_samp_freq()
      staging:iio:hmc5843: Introduce _set_range_gain()
      staging:iio:hmc5843: Check initialization and chip identifier
      staging:iio:hmc5843: Trivial cleanup

Sachin Kamat (4):
      iio: adc: mcp3422: Include linux/of.h header
      iio: adc: nau7802: Include linux/of.h header
      iio: adc: ti-adc081c: Include linux/of.h header
      iio: light: gp2ap020a00f: Include linux/of.h header

Sebastian Andrzej Siewior (1):
      staging: iio: generic_buffer: initialize ret

 Documentation/ABI/testing/sysfs-bus-iio            |  56 ++
 .../devicetree/bindings/arm/atmel-adc.txt          |   8 +-
 .../devicetree/bindings/iio/light/cm36651.txt      |  26 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/mach-at91/include/mach/at91_adc.h         |  34 +
 drivers/iio/accel/st_accel_buffer.c                |  11 +-
 drivers/iio/adc/ad7266.c                           |  12 +-
 drivers/iio/adc/ad7887.c                           |   5 -
 drivers/iio/adc/ad_sigma_delta.c                   |   1 -
 drivers/iio/adc/at91_adc.c                         | 453 +++++++++++--
 drivers/iio/adc/max1363.c                          | 200 +++---
 drivers/iio/adc/mcp3422.c                          |   1 +
 drivers/iio/adc/nau7802.c                          |   1 +
 drivers/iio/adc/ti-adc081c.c                       |   1 +
 drivers/iio/adc/ti_am335x_adc.c                    |   2 +-
 drivers/iio/buffer_cb.c                            |  21 +-
 drivers/iio/dac/ad5421.c                           |  62 +-
 drivers/iio/gyro/st_gyro_buffer.c                  |  11 +-
 drivers/iio/iio_core.h                             |   6 +
 drivers/iio/industrialio-buffer.c                  | 188 ++++--
 drivers/iio/industrialio-core.c                    |  82 ++-
 drivers/iio/industrialio-event.c                   | 230 ++++++-
 drivers/iio/industrialio-triggered-buffer.c        |   8 +-
 drivers/iio/kfifo_buf.c                            |  44 +-
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/apds9300.c                       |  53 +-
 drivers/iio/light/cm36651.c                        | 708 +++++++++++++++++++++
 drivers/iio/light/gp2ap020a00f.c                   | 107 +++-
 drivers/iio/light/tsl2563.c                        |  53 +-
 drivers/iio/magnetometer/st_magn_buffer.c          |  11 +-
 drivers/iio/pressure/st_pressure_buffer.c          |  11 +-
 drivers/staging/iio/Documentation/iio_utils.h      |   2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |  64 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   3 +-
 drivers/staging/iio/accel/sca3000_core.c           |  58 +-
 drivers/staging/iio/accel/sca3000_ring.c           |  13 +-
 drivers/staging/iio/adc/Kconfig                    |   7 +-
 drivers/staging/iio/adc/ad7291.c                   | 219 +++----
 drivers/staging/iio/adc/ad799x.h                   |  16 +-
 drivers/staging/iio/adc/ad799x_core.c              | 273 ++++----
 drivers/staging/iio/adc/lpc32xx_adc.c              |   2 +-
 drivers/staging/iio/adc/mxs-lradc.c                |   6 -
 drivers/staging/iio/adc/spear_adc.c                |   5 +-
 drivers/staging/iio/cdc/ad7150.c                   | 163 +++--
 drivers/staging/iio/iio_simple_dummy.c             |  30 +-
 drivers/staging/iio/iio_simple_dummy.h             |  22 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c      |  10 +-
 drivers/staging/iio/iio_simple_dummy_events.c      |  49 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  12 +-
 drivers/staging/iio/light/tsl2x7x_core.c           | 120 ++--
 drivers/staging/iio/magnetometer/hmc5843.c         | 516 +++++++--------
 drivers/staging/iio/meter/ade7758_ring.c           |  12 +-
 include/linux/iio/buffer.h                         |  30 +-
 include/linux/iio/events.h                         |  14 -
 include/linux/iio/iio.h                            |  58 ++
 include/linux/iio/types.h                          |  20 +
 57 files changed, 2905 insertions(+), 1238 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 create mode 100644 drivers/iio/light/cm36651.c
