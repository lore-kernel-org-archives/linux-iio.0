Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37499 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbbATWIT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jan 2015 17:08:19 -0500
Message-ID: <54BED1D1.5020509@kernel.org>
Date: Tue, 20 Jan 2015 22:08:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "gregk >> Greg KH" <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: PULL] First round of new IIO drivers, features and cleanups for the
 3.20 cycle - take 2
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 5e62863aea463c9bf24538315327d0922be35d64:

  staging: comedi: das800: use comedi_async 'scans_done' to detect EOA (2014-11-05 14:59:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.20a_take2

for you to fetch changes up to df1fad80dfa0a7644b525c4a0dd8f2be21f57358:

  iio kmx61 / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM (2015-01-20 22:00:19 +0000)

----------------------------------------------------------------
First round of IIO new drivers, cleanups and functionality for the 3.20 cycle take 2

Updated pull request with Daniel's fix on top for the power management
Kconfig changes that had snuck in since last update of the IIO tree
worked it's way through from mainline.

Original pull message

New device support
* jsa1212 proxmity / ambient light sensor
* SM08500 supported added to the kxcjk-1013 accelerometer driver
* KMX61 Accelerometer/Magnetometer.  This took a somewhat rocky path
  being first merged, then reverted for a rewrite after a discussion of
  how to support additional functionality and finally being merged prior
  to some last reviews coming in, with resultant follow up patches.
* Freescale mma9551l driver (minor follow up warning supression patch).
* Semtech SX9500 proximity device driver.
* ak8975 gains support for ak09911 and ak09912 and drop the standalone driver
  for the ak09911.

New functionality
 * Dummy driver gains some virtual registers making it more flexible.
 * IIO_ACTIVITY channel types, with modifiers running, walking etc.  This is
   to support on chip motion clasifiers.  As such it is in the form of a
   confidence percentage.  The only devices so far only do binary decisions
   but this gives us room when other devices give more nuanced clasification.
 * IIO_EV_DIR_NONE type for events where there is no obvious direction.
   First case is step detection.
 * IIO_STEPS channel type for pedometers.
 * ENABLE mask element used to control turning on counting types such as
   the pedometer that need a 'start point'.
 * INSTANCE event type to support things that happen once.
 * info element for height calibration (used in various motion estimation
   algorithms). Note heigh tof use
 * dummy driver demonstration of the use of all the new bits above.
 * event monitor support for the new events.
 * inv_mpu6050 gains an i2c mux to allow bypassing the device to access
   additional devices connected on the other side of it.  Note that in
   Windows these are handled by firmware on the device and not exposed
   directly.
 * inv_mpu6050 gains ACPI enumeration.
 * inkern interface gains iio_write_channel_raw to allow in kernel users
   of DAC functionality via a simple wrapper.
 * Document input current readings in the ABI docs.
 * Add an error message when we get an out of range error in device tree
   processing for the in kernel interfaces.  Basically a device tree debugging
   aid.
 * Add a sanity check that a scan index for a channel is unique during
   registration.  There to help catch bugs as this should never happen
   in a bug free driver.

Cleanups and fixlets

 A rework of buffer registration from Lars - a precursor to some other
 upcoming new stuff (a few patches from others rolled in here as well).
 * Ensure all drivers register the same channels for the device and buffer.
 * Move buffer registration into the core rather than using the old
   two step approach.  Now we have simple ways of using a unified set channels
   for both without requiring channels be exposed by both interface, this
   removes a fair bit of boilerplate.
 * Stop sca3000 and ad5933 (both in staging) enabling buffer channels by
   default. It has long be convention in IIO to startup with no channels
   enabled and leave it up to userspace to say what goes in the buffer.
   Getting rid of these allows us to drop export of iio_scan_mask_set.
 * Drop get_bytes_per_datum from iio_buffer_access_funcs as not been used
   for a while.
 * Allocate standard buffer attributes in the core rather than in every
   driver with a buffer.
 * Make the length attribute read only when a driver is not able to set
   the length.
 * Drop the get_length callback for buffers as it is already available in
   struct iio_buffer.
 * Drop an unused arguement form iio_kfifo_allocate and add devm allocator
   for it.
 * some kconfig entries gain anotation with the resulting module name.
 * Fix a resulting compile issue in dummy driver due to a stub taking
   wrong parameters as a result of the above rework.
 * Fix an off by 2 error in copying the core assigned buffer attributes.

Other cleanups,
 * Trivial space before comma fixups.
 * ak8975 fixlets - none critical.  Rework to allow more device support.
 * Drop unnecessary sizeof(u8) calls.
 * bmp280 - refactor the compensation code to reduce copy operations and
   code length.  A second patch futher optimized this and performed some
   other minor cleanups.
 * kxcjk-1013 - various power control cleanups to avoid unnecessary enable
   / disable of device.  Make sure it is only controlled at all if CONFIG_PM
   is enabled.  Also som cleanups of error paths.
 * Small cleanups in adf4530 driver - pointless message and unnecessary braces.
 * Clarifiy the proximity ABI docs to make it clear it should get bigger
   as we move futher away.
 * Drop a misleading comment form industrialio-core.c
 * Trivial white space cleanups.
 * sca3000 looses an unused debug function.
 * Fix char unsigned ordering in ad8366
 * Increase the sleep time in ad9523 to make it predictable (value didn't
   really matter so make it more than 20 msecs)
 * mxs-lradc touchscreen property cleanups in device tree are fixed to ensure
   the meet all the 'interesting' documentation.
 * A couple of cleanups for the staging ad5933 driver to avoid unnecessary
   conversion to a processed temperature vlaue in kernel and remove
   platform data form the state structure as not needed after probe.
 * Fix a wrong scale factor in the docs.

Misc
 * Add IIO include files to the maintainers entry.

----------------------------------------------------------------
Adam Thomson (1):
      iio: Add ABI documentation for input current readings

Bastien Nocera (1):
      iio:kxcjk-1013: Add support for SMO8500 device

Daniel Baluta (22):
      MAINTAINERS: Add IIO include files
      iio: imu: Add support for Kionix KMX61 sensor
      iio: dummy: Add virtual registers for dummy device
      iio: core: Introduce IIO_ACTIVITY channel
      iio: dummy: Demonstrate the usage of new channel types
      iio: event_monitor: Add support for new channel types
      iio: imu: Add support for Kionix KMX61 sensor
      iio: imu: kmx61: Add acpi support
      iio: imu: kmx61: Add PM runtime support
      iio: imu: kmx61: Add PM sleep support
      iio: imu: kmx61: Add support for data ready triggers
      iio: imu: kmx61: Add support for any motion trigger
      iio: imu: kmx61: Save odr_bits for later use
      iio: imu: kmx61: Don't ignore kmx61_set_power_state errors
      iio: imu: kmx61: Enhance error handling
      iio: imu: kmx61: Fixup parameters alignment
      iio: imu: kmx61: Drop unused device parameter
      iio: imu: kmx61: Use false instead of 0 for ev_enable_state
      iio: imu: kmx61: Fix device initialization when setting trigger state
      iio: imu: kmx61: Remove unnecessary REG_INS1 read
      iio: imu: kmx61: Use correct base when reading data
      iio kmx61 / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM

Dmitry Eremin-Solenikov (1):
      iio: inkern: add iio_write_channel_raw

Fabian Frederick (1):
      iio: common: remove unnecessary sizeof(u8)

Gwendal Grignou (3):
      iio: ak8975: minor fixes
      iio: ak8975: add definition structure per compass type
      iio: ak8975: add ak09911 and ak09912 support

Hartmut Knaack (1):
      iio:pressure:bmp280: cleanup

Irina Tirdea (7):
      iio: core: Introduce IIO_EV_DIR_NONE
      iio: core: Introduce STEPS channel, ENABLE mask and INSTANCE event
      iio: core: Introduce IIO_CHAN_INFO_CALIBHEIGHT
      iio: accel: kxcjk-1013: always power on device in resume
      iio: accel: kxcjk-1013: only set power state if CONFIG_PM is defined
      iio: accel: kxcjk-1013: error handling when set mode fails
      iio: accel: kxcjk-1013: power off device if probe fails

Ivan T. Ivanov (1):
      iio: consumer.h: Fix scale factor in function comment

Jonathan Cameron (1):
      Revert "iio: imu: Add support for Kionix KMX61 sensor"

Karol Wrona (3):
      iio: kfifo: Remove unused argument in iio_kfifo_allocate
      iio: kfifo: Add resource management devm_iio_kfifo_allocate/free
      iio: core: Get rid of misleading comment

Kuppuswamy Sathyanarayanan (1):
      iio: jsa1212: Add JSA1212 proximity/ALS sensor

Lars-Peter Clausen (13):
      staging:iio:ad5933: Don't enable channels by default
      staging:iio:sca3000: Don't enable channels by default
      iio: Unexport iio_scan_mask_set()
      staging:iio:sca3000: Register same channels for device and buffer
      staging:iio:dummy: Register same channels for device and buffer
      iio: Move buffer registration to the core
      iio: Remove get_bytes_per_datum() from iio_buffer_access_funcs
      iio: buffer: Move iio_buffer_alloc_sysfs and iio_buffer_free_sysfs
      iio: buffer: Allocate standard attributes in the core
      iio: buffer: Make length attribute read only for buffers without set_length
      iio: buffer: Drop get_length callback
      staging:iio:ad5933: Report temperature as raw value
      staging:iio:ad5933: Remove platform data from state struct

Octavian Purdila (1):
      iio: buffer: fix custom buffer attributes copy

Rickard Strandqvist (1):
      staging: iio: accel: sca3000_core.c: Remove unused function

Roberta Dobrescu (11):
      iio: frequency: Remove 'out of memory' message
      iio: frequency: Remove unnecessary braces around single statement block
      iio: trigger: Add a blank line after declarations
      iio: accel: kxcjk-1013: Add a blank line after declarations
      iio: accel: mma8452: Remove trailing whitespace
      iio: accel: Annotate Kconfig entries with module name information
      iio: light: Annotate Kconfig entry with module name information
      iio: light: lm3533-als: Remove space before ','
      iio: amplifiers: ad8366: Remove space before ','
      iio: amplifiers: ad8366: Use right order for type specification
      iio: frequency: ad9523: Increase sleep time in ad9523_store_eeprom

Srinivas Pandruvada (2):
      iio: imu: inv_mpu6050: Add i2c mux for by pass
      iio: imu: inv_mpu6050: ACPI enumeration

Stefan Wahren (3):
      iio: inkern: add out of range error message
      DT: mxs-lradc: fix ranges of ts properties
      iio: mxs-lradc: check ranges of ts properties

Vlad Dogaru (7):
      iio: bmp280: refactor compensation code
      iio: add driver for Freescale MMA9551L
      iio: ABI: add clarification for proximity
      iio: mma9551: fix sparse warning
      staging: iio: dummy: fix compile error when not using buffering
      iio: driver for Semtech SX9500 proximity solution
      iio: ensure scan index is unique at device register

Zachary Warren (1):
      drivers:staging:iio: fix checkpatch complaint about space before comma

kbuild test robot (1):
      iio: imu: kmx61: kmx61_set_wake_up_odr() can be static

 Documentation/ABI/testing/sysfs-bus-iio            |   95 +-
 .../bindings/staging/iio/adc/mxs-lradc.txt         |    4 +-
 Documentation/driver-model/devres.txt              |    2 +
 MAINTAINERS                                        |    1 +
 drivers/iio/accel/Kconfig                          |   16 +
 drivers/iio/accel/Makefile                         |    1 +
 drivers/iio/accel/kxcjk-1013.c                     |   52 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/accel/mma9551.c                        |  956 ++++++++++++
 drivers/iio/adc/ti_am335x_adc.c                    |   11 +-
 drivers/iio/amplifiers/ad8366.c                    |    4 +-
 drivers/iio/common/st_sensors/st_sensors_spi.c     |    2 +-
 drivers/iio/frequency/ad9523.c                     |    2 +-
 drivers/iio/frequency/adf4350.c                    |    7 +-
 drivers/iio/iio_core.h                             |    9 +
 drivers/iio/imu/Kconfig                            |   11 +
 drivers/iio/imu/Makefile                           |    2 +
 drivers/iio/imu/inv_mpu6050/Kconfig                |    1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  124 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    6 +
 drivers/iio/imu/kmx61.c                            | 1595 ++++++++++++++++++++
 drivers/iio/industrialio-buffer.c                  |  408 ++---
 drivers/iio/industrialio-core.c                    |   50 +-
 drivers/iio/industrialio-event.c                   |   13 +-
 drivers/iio/industrialio-triggered-buffer.c        |   13 +-
 drivers/iio/inkern.c                               |   30 +-
 drivers/iio/kfifo_buf.c                            |   87 +-
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/jsa1212.c                        |  471 ++++++
 drivers/iio/light/lm3533-als.c                     |    2 +-
 drivers/iio/magnetometer/Kconfig                   |   15 +-
 drivers/iio/magnetometer/Makefile                  |    1 -
 drivers/iio/magnetometer/ak09911.c                 |  326 ----
 drivers/iio/magnetometer/ak8975.c                  |  504 +++++--
 drivers/iio/pressure/bmp280.c                      |  150 +-
 drivers/iio/proximity/Kconfig                      |   17 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/sx9500.c                     |  752 +++++++++
 drivers/iio/trigger/iio-trig-sysfs.c               |    2 +
 .../staging/iio/Documentation/iio_event_monitor.c  |   23 +-
 drivers/staging/iio/Documentation/ring.txt         |    8 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |   13 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    2 +-
 drivers/staging/iio/accel/sca3000_core.c           |   45 +-
 drivers/staging/iio/accel/sca3000_ring.c           |   29 +-
 drivers/staging/iio/adc/ad7192.c                   |    2 +-
 drivers/staging/iio/adc/mxs-lradc.c                |   45 +-
 drivers/staging/iio/iio_dummy_evgen.c              |   17 +
 drivers/staging/iio/iio_dummy_evgen.h              |    6 +
 drivers/staging/iio/iio_simple_dummy.c             |  210 ++-
 drivers/staging/iio/iio_simple_dummy.h             |   13 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c      |   12 +-
 drivers/staging/iio/iio_simple_dummy_events.c      |   66 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   49 +-
 drivers/staging/iio/meter/ade7758.h                |    1 -
 drivers/staging/iio/meter/ade7758_core.c           |   15 +-
 drivers/staging/iio/meter/ade7758_ring.c           |    7 +-
 drivers/staging/iio/meter/ade7759.c                |    2 +-
 include/linux/iio/buffer.h                         |   76 +-
 include/linux/iio/consumer.h                       |   12 +-
 include/linux/iio/iio.h                            |    2 +
 include/linux/iio/kfifo_buf.h                      |    5 +-
 include/linux/iio/types.h                          |   10 +-
 64 files changed, 5314 insertions(+), 1115 deletions(-)
 create mode 100644 drivers/iio/accel/mma9551.c
 create mode 100644 drivers/iio/imu/kmx61.c
 create mode 100644 drivers/iio/light/jsa1212.c
 delete mode 100644 drivers/iio/magnetometer/ak09911.c
 create mode 100644 drivers/iio/proximity/sx9500.c
