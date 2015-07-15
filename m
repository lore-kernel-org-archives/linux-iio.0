Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47151 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbGOSKo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2015 14:10:44 -0400
Message-ID: <55A6A221.30003@kernel.org>
Date: Wed, 15 Jul 2015 19:10:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First round of IIO new device support, functionality and cleanups
 for the 4.3 cycle.
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 4f3ca89351e62f72144ca592c1c482e529d31539:

  staging:lustre: Update license and copyright for the LNET headers (2015-06-11 22:41:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.3a

for you to fetch changes up to 2155971a66f89924edb37c213251c4fe9f7776c0:

  iio: Drop owner assignment from i2c_driver (2015-07-11 18:50:07 +0100)

----------------------------------------------------------------
First round of new drivers, cleanups and functionality for IIO in the 4.3 cycle.

Core and tools new stuff
* Allow explicit flush of hardware fifo by using an non blocking read.
  This is needed to support some of the Android requirements for HW fifo
  devices - also makes sense generally and clarifies a corner of the ABI.
* Add some missing modifier names.  Mostly these exist for weird and
  wonderful event types, but should still be present in the name array.
* Update iio_event_monitor to cope with new channel types.
* generic_buffer gains support for single byte scan elements (no idea
  how this never got implemented before!)

New device support
* ROHM rpr0521 light and proximity sensor driver.
* bmc150 gains bmc156 support.
* ms5611 gains ms5607 temperature and pressure sensor support.

Driver functionality
* inv-mpu - add scale_available attributes to aid userspace in
  configuring these devices.
* isl29125 - add scale_available attributes.
* stk8ba50 - sampling frequency control, triggered buffer support.
* stk8312 - sampling frequency control, triggered buffer support.
* cc10001 - ensure ADC powered up at probe time if shared by non linux
  running CPUs.
* bmc150-magn - decouple the buffer and trigger allowing other triggers
  to be used to drive this device's sampling.
Documentation
* Add some previously missed *scale_available attributes to the ABI docs.

Cleanups
* Clarify some crazy naming in iio_triggered_buffer_setup that seems to
  have somehow ended up backwards (dates back a long way).  Avoid the top
  half and bottom half naming entirely given we are how dealing with a
  handler and a thread in all cases.
* Tools cleanup including coding style, variable naming improvements, also
  a new sanity check on a full event having been read.
* stk8ba50 - replace the scale table with a struct for clarity. Also suspend
  the sensor if an error occurs in init.
* hid-sensor-prox - drop uneeded line break.
* mma9551 - use size in words for word read / write avoiding accidental
  sending of an odd number of bytes.
* mma9553 - fix code alignment and document the use of a mutex.
* light/Kconfig - typo fix in commment.
* cm3323 - don't eat an error value, replace an unneeded local variable with
  a generic local variable with the same use, add some blank lines for clarity.
* pressure/Kconfig - typo in Measurement Specialties name.
* bmc150-accel - actually use a mask definition rather than repeating the
  value inline, code style cleanup.
* adc/Kconfig - general help description cleanup.
* ssp_sensors - drop redundant spi driver bus initialization (done in the
  spi core)
* tmp006 - use genmask rather than hand generated masks.
* ms5611 - drop IIO_CHAN_INFO_SCALE as this driver provides a processed
  output and as such the read only scale adds nothing useful.
* kxcjk-1013, adf4350, dummy - drop unwanted blank lines.
* Drop all owner assignments from i2c_drivers and this is done in the
  i2c core.

----------------------------------------------------------------
Adriana Reus (2):
      iio: Documentation: Add additional *scale_available attributes
      iio: inv-mpu: Export scale_available attributes

Ana Calinov (2):
      iio: accel: kxcjk-1013: Remove blank lines
      iio: frequency: adf4350: Delete blank line

Antonio Borneo (1):
      iio: ssp_sensors: Remove redundant spi driver bus initialization

Cristina Opriceana (2):
      iio: Fix parameters in iio_triggered_buffer_setup
      Staging: iio: dummy: Fix blank line warnings

Daniel Baluta (1):
      iio: light: Add support for ROHM RPR0521 sensor

Fabio Estevam (1):
      iio: light: hid-sensor-prox: Fit assignment in one line

Hartmut Knaack (11):
      tools:iio: adjust coding style
      tools:iio: rename variables
      iio:light:Kconfig: fix typo in description
      iio:light:cm3323: pass up error value
      iio:light:cm3323: replace unneeded variable
      iio:light:cm3323: make use of GENMASK
      iio:light:cm3323: add empty lines for code structure
      iio:accel:bmc150-accel: make use of mask definition
      iio:accel:bmc150-accel: code style cleanup
      tools:iio:iio_event_monitor: check if event is fully read
      iio:adc:Kconfig: rework help descriptions

Irina Tirdea (3):
      iio: accel: mma9551_core: use size in words for word buffers
      iio: accel: mma9553: fix alignment issues
      iio: accel: mma9553: document use of mutex

Krzysztof Kozlowski (2):
      staging: iio: Drop owner assignment from i2c_driver
      iio: Drop owner assignment from i2c_driver

Naidu Tellapati (1):
      iio: adc: cc10001: Power-up the ADC at probe time when used remotely

Octavian Purdila (1):
      iio: allow userspace to flush the hwfifo with non-blocking reads

Peter Meerwald (5):
      iio: Add missing modifier names to core
      tools: iio: Add missing names to iio_event_monitor
      iio: light: isl29125: Add scale_available information
      iio: pressure: Fix Measurement Specialties vendor name
      iio: tmp006: Use GENMASK

Tiberiu Breana (7):
      iio: accel: STK8BA50: replace scale table with a struct
      iio: accel: Add sampling rate support for STK8BA50
      iio: accel: STK8BA50: suspend sensor on init errors
      tools: iio: Add single-byte case for generic_buffer
      iio: accel: Add trigger support for STK8BA50
      iio: accel: Add buffer mode for Sensortek STK8312
      iio: accel: Add sampling rate support for STK8312

Tomasz Duszynski (2):
      iio: pressure: ms5611: remove IIO_CHAN_INFO_SCALE from mask
      iio: pressure: ms5611: add support for MS5607 temperature and pressure sensor

Vlad Dogaru (2):
      iio: magn: bmc150: decouple buffer and trigger
      iio: magn: bmc150: add support for bmc156

 Documentation/ABI/testing/sysfs-bus-iio       |   5 +
 drivers/iio/accel/bma180.c                    |   1 -
 drivers/iio/accel/bmc150-accel.c              |  93 ++--
 drivers/iio/accel/kxcjk-1013.c                |   3 -
 drivers/iio/accel/mma9551_core.c              |  35 +-
 drivers/iio/accel/mma9551_core.h              |   6 +-
 drivers/iio/accel/mma9553.c                   |  81 ++--
 drivers/iio/accel/st_accel_i2c.c              |   1 -
 drivers/iio/accel/stk8312.c                   | 380 ++++++++++++++--
 drivers/iio/accel/stk8ba50.c                  | 368 +++++++++++++--
 drivers/iio/adc/Kconfig                       |  48 +-
 drivers/iio/adc/cc10001_adc.c                 |  26 +-
 drivers/iio/adc/mcp3422.c                     |   1 -
 drivers/iio/adc/ti-adc081c.c                  |   1 -
 drivers/iio/common/ssp_sensors/ssp_dev.c      |   1 -
 drivers/iio/dac/ad5064.c                      |   1 -
 drivers/iio/dac/ad5380.c                      |   1 -
 drivers/iio/dac/ad5446.c                      |   1 -
 drivers/iio/dac/max5821.c                     |   1 -
 drivers/iio/frequency/adf4350.c               |   1 -
 drivers/iio/gyro/itg3200_core.c               |   1 -
 drivers/iio/gyro/st_gyro_i2c.c                |   1 -
 drivers/iio/humidity/si7005.c                 |   1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |   7 +-
 drivers/iio/industrialio-buffer.c             |  18 +-
 drivers/iio/industrialio-core.c               |   8 +
 drivers/iio/industrialio-triggered-buffer.c   |  12 +-
 drivers/iio/light/Kconfig                     |  13 +-
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/apds9300.c                  |   1 -
 drivers/iio/light/bh1750.c                    |   1 -
 drivers/iio/light/cm32181.c                   |   1 -
 drivers/iio/light/cm3232.c                    |   1 -
 drivers/iio/light/cm3323.c                    |  19 +-
 drivers/iio/light/cm36651.c                   |   1 -
 drivers/iio/light/gp2ap020a00f.c              |   1 -
 drivers/iio/light/hid-sensor-prox.c           |   3 +-
 drivers/iio/light/isl29125.c                  |  13 +-
 drivers/iio/light/jsa1212.c                   |   1 -
 drivers/iio/light/ltr501.c                    |   1 -
 drivers/iio/light/rpr0521.c                   | 615 ++++++++++++++++++++++++++
 drivers/iio/light/tcs3414.c                   |   1 -
 drivers/iio/light/tcs3472.c                   |   1 -
 drivers/iio/light/tsl4531.c                   |   1 -
 drivers/iio/light/vcnl4000.c                  |   1 -
 drivers/iio/magnetometer/bmc150_magn.c        |  71 +--
 drivers/iio/magnetometer/st_magn_i2c.c        |   1 -
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/ms5611.h                 |  16 +-
 drivers/iio/pressure/ms5611_core.c            |  82 +++-
 drivers/iio/pressure/ms5611_i2c.c             |   6 +-
 drivers/iio/pressure/ms5611_spi.c             |   6 +-
 drivers/iio/pressure/st_pressure_i2c.c        |   1 -
 drivers/iio/temperature/mlx90614.c            |   1 -
 drivers/iio/temperature/tmp006.c              |   5 +-
 drivers/staging/iio/addac/adt7316-i2c.c       |   1 -
 drivers/staging/iio/iio_dummy_evgen.c         |   1 +
 drivers/staging/iio/iio_simple_dummy.c        |   2 -
 drivers/staging/iio/iio_simple_dummy.h        |   1 +
 drivers/staging/iio/iio_simple_dummy_buffer.c |   2 +-
 drivers/staging/iio/light/isl29018.c          |   1 -
 drivers/staging/iio/light/isl29028.c          |   1 -
 include/linux/iio/triggered_buffer.h          |   4 +-
 tools/iio/generic_buffer.c                    |  67 ++-
 tools/iio/iio_event_monitor.c                 |  27 +-
 tools/iio/iio_utils.c                         | 121 +++--
 tools/iio/iio_utils.h                         |  15 +-
 tools/iio/lsiio.c                             |  43 +-
 68 files changed, 1839 insertions(+), 421 deletions(-)
 create mode 100644 drivers/iio/light/rpr0521.c
