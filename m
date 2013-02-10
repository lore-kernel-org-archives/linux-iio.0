Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57208 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab3BJViw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Feb 2013 16:38:52 -0500
Message-ID: <51181368.8070107@kernel.org>
Date: Sun, 10 Feb 2013 21:38:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new drivers and fixes (IIO set 4 for the 3.9
 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 82e9ee616a89f152f42c7051c5f9f5f0d7663652:

  staging: comedi: ni_mio_cs: use pcmcia_request_irq() (2013-02-05 18:16:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.9d

for you to fetch changes up to 09a642b78523e9f4c5970c806ad218aa3de31551:

  Invensense MPU6050 Device Driver. (2013-02-10 17:42:43 +0000)

----------------------------------------------------------------
4th set of IIO new drivers cleanups and fixes for the 3.9 cycle
+ a new spi helper function.

1) Introduce spi_sync_transfer and use it within IIO.  Originally
   it was envisioned that this nice little boilerplate replacement
   would go through the spi tree, but Grant Likely stated he'd
   prefer we take it through IIO as the example usecases were all
   in IIO (and are also in this pull request).  Note that given
   their may have been some unresolved elements related to the
   coccinelle element of the patch, that has been stripped out
   and will doubtlessly follow at a later date (along with
   lots of other patches for drivers elsewhere in the tree).

2) New Invensense MPU6050 driver.  This is stripped down to pretty
   much the basics from the original submission with the intent
   to build up all the fancy bits in an incremental (and hence
   reviewable fashion). It's been through a good few revisions
   so nice to finally merge this.

3) Change to iio_channel_get api to simplify device tree based
   mappings.  The actual mappings are currently under review.

4) Build fixes for !CONFIG_IIO_TRIGGER in the st_sensors driver.
   This one snuck past during review and testing but got picked
   up by Randy Dunlap in a randconfig build.

5) Some max1363 cleanups and enhancements.

6) Some comment fixes to make them coherent and comprehensible.

7) Trivial build warning fix in mxs-lradc

----------------------------------------------------------------
Denis CIOCCA (1):
      iio:common: added allocate and deallocate trigger functions when trigger is disabled.

Fabio Estevam (1):
      iio: mxs-lradc: Fix 'duplicate const' warning

Ge Gao (1):
      Invensense MPU6050 Device Driver.

Guenter Roeck (3):
      iio: max1363: Use devm_ functions whereever possible to allocate resources
      iio/adc: (max1363) Add support for external reference voltage
      iio: Update iio_channel_get API to use consumer device pointer as argument

Jonathan Cameron (2):
      iio:triggers Protect functions in triggers.h from use when not compiled
      iio:st_sensors fix build when !CONFIG_IIO_TRIGGER

Lars-Peter Clausen (3):
      spi: Add helper functions for setting up transfers
      iio: Use spi_sync_transfer()
      staging:iio: Use spi_sync_transfer()

Peter Meerwald (1):
      iio: tweak language in industrialio-trigger comments

 Documentation/ABI/testing/sysfs-bus-iio-mpu6050  |  13 +
 drivers/extcon/extcon-adc-jack.c                 |   3 +-
 drivers/iio/accel/kxsd9.c                        |   6 +-
 drivers/iio/accel/st_accel_core.c                |   9 +-
 drivers/iio/accel/st_accel_i2c.c                 |   1 -
 drivers/iio/accel/st_accel_spi.c                 |   1 -
 drivers/iio/adc/max1363.c                        |  81 ++-
 drivers/iio/dac/ad5360.c                         |   7 +-
 drivers/iio/dac/ad5421.c                         |   7 +-
 drivers/iio/dac/ad5504.c                         |   6 +-
 drivers/iio/dac/ad5686.c                         |   7 +-
 drivers/iio/dac/ad5755.c                         |   7 +-
 drivers/iio/dac/ad5764.c                         |   7 +-
 drivers/iio/dac/ad5791.c                         |   6 +-
 drivers/iio/frequency/ad9523.c                   |  14 +-
 drivers/iio/gyro/adxrs450.c                      |   5 +-
 drivers/iio/gyro/st_gyro_core.c                  |   9 +-
 drivers/iio/gyro/st_gyro_i2c.c                   |   1 -
 drivers/iio/gyro/st_gyro_spi.c                   |   1 -
 drivers/iio/imu/Kconfig                          |   2 +
 drivers/iio/imu/Makefile                         |   2 +
 drivers/iio/imu/inv_mpu6050/Kconfig              |  13 +
 drivers/iio/imu/inv_mpu6050/Makefile             |   6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       | 795 +++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h        | 246 +++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c       | 196 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c    | 155 +++++
 drivers/iio/industrialio-trigger.c               |  12 +-
 drivers/iio/inkern.c                             |  11 +-
 drivers/iio/magnetometer/st_magn_core.c          |   1 -
 drivers/iio/magnetometer/st_magn_i2c.c           |   1 -
 drivers/iio/magnetometer/st_magn_spi.c           |   1 -
 drivers/power/generic-adc-battery.c              |   4 +-
 drivers/power/lp8788-charger.c                   |   8 +-
 drivers/staging/iio/accel/lis3l02dq_core.c       |  18 +-
 drivers/staging/iio/accel/sca3000_core.c         |  13 +-
 drivers/staging/iio/accel/sca3000_ring.c         |   6 +-
 drivers/staging/iio/adc/ad7280a.c                |   6 +-
 drivers/staging/iio/adc/mxs-lradc.c              |   2 +-
 drivers/staging/iio/frequency/ad5930.c           |   5 +-
 drivers/staging/iio/frequency/ad9850.c           |   5 +-
 drivers/staging/iio/frequency/ad9852.c           |   5 +-
 drivers/staging/iio/meter/ade7753.c              |   6 +-
 drivers/staging/iio/meter/ade7754.c              |   5 +-
 drivers/staging/iio/meter/ade7758_core.c         |  28 +-
 drivers/staging/iio/meter/ade7759.c              |   5 +-
 drivers/staging/iio/meter/ade7854-spi.c          |  44 +-
 drivers/staging/iio/resolver/ad2s1210.c          |   5 +-
 include/linux/iio/common/st_sensors.h            |  10 +
 include/linux/iio/consumer.h                     |   5 +-
 include/linux/iio/trigger.h                      |   5 +
 include/linux/platform_data/invensense_mpu6050.h |  31 +
 include/linux/spi/spi.h                          |  44 ++
 53 files changed, 1646 insertions(+), 246 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-mpu6050
 create mode 100644 drivers/iio/imu/inv_mpu6050/Kconfig
 create mode 100644 drivers/iio/imu/inv_mpu6050/Makefile
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
 create mode 100644 include/linux/platform_data/invensense_mpu6050.h
