Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33884 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3CWKyA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Mar 2013 06:54:00 -0400
Message-ID: <514D89C4.60609@kernel.org>
Date: Sat, 23 Mar 2013 10:53:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new drivers and fixes (IIO set 1 for the 3.10
 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a14592896023adcab12307774c89284ce0744ce2:

  staging: comedi: ni_labpc: fix common detach (2013-03-15 09:17:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.10a

for you to fetch changes up to 51b53dc991ae7eebc5d45b06d576da6486fbf823:

  hwmon: Move the IIO client driver for hwmon out of staging (2013-03-23 10:08:15 +0000)

----------------------------------------------------------------
First set of IIO new drivers and cleanup for the 3.10 cycle.

New stuff

1) Add OF support for specifying mappings between iio devices and their
   in kernel consumers.
2) Driver for AD7923 (extra functionality and support for ad7904, ad7914 and
   ad7924 added later in series)
3) Driver for Exynos adc (dt suppor for phy added later in series).
4) Make iio_push_event save IRQ context - necessary if it is to be used
   within an interrupt handler.  Users of this functionality to follow.
5) For iio use the device tree node name to provide the hwmon name attribute
   if available.

Removal and moves out of staging

1) Drop the adt7410 driver from IIO now that there is a hmwon driver with
   equivalent support. This device is very much targeted at hardware
   monitoring so hwmon is a more appropriate host for the driver.
2) Move iio_hwmon driver to drivers/hwmon.

Cleanups

1) Minor cleanup in ST common library.
2) Large set of patches to break the info_mask element which previously used
odd and even bits to specify if a channel attribute was either shared across
similar channels or specific to only one.  Now we have two bitmaps, one for
those parameters that are specific to this channel and one for those shared
by all channels with the same type as this one.  This has no effect on the
userspace abi. It simplifies the core code and provides more space for new
channel parameters. It has been on the todo list for a long time!

----------------------------------------------------------------
Christophe Leroy (1):
      IIO ADC support for AD7923

Denis Ciocca (1):
      iio:common: Use spi_sync_transfer() in STMicroelectronics common library

Doug Anderson (1):
      iio: adc: Add dt support for turning on the phy in exynos-adc

Ge Gao (1):
      using kfifo_in_spinlocked instead of separate code.

Guenter Roeck (2):
      iio: Add OF support
      staging/iio: iio_hwmon: Use device tree node name for hwmon name attribute

Jonathan Cameron (73):
      iio: Add broken out info_mask fields for shared_by_type and separate
      iio:adc:max1363 move to info_mask_(shared_by_type/separate)
      staging:iio:dummy move to info_mask_(shared_by_type/separate)
      iio:hid_sensors move to info_mask_(shared_by_type/separate)
      iio:accel:kxsd9 move to info_mask_(shared_by_type/separate)
      iio:st_sensors move to info_mask_(shared_by_type/separate)
      iio:adc:ad_sigma_delta move to info_mask_(shared_by_type/separate)
      iio:adc:ad7266 move to info_mask_(shared_by_type/separate)
      iio:adc:ad7298 move to info_mask_(shared_by_type/separate)
      iio:adc:ad7476 move to info_mask_(shared_by_type/separate)
      iio:adc:ad7887 move to info_mask_(shared_by_type/separate)
      iio:adc:at91_adc move to info_mask_(shared_by_type/separate)
      iio:adc:lp8778_adc move to info_mask_(shared_by_type/separate)
      iio:adc:ti-adc081 move to info_mask_(shared_by_type/separate)
      iio:adc:ti_am335x_adc move to info_mask_(shared_by_type/separate)
      iio:adc:viperboard_adc move to info_mask_(shared_by_type/separate)
      iio:amplifiers:ad8366 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5064 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5360 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5380 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5421 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5446 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5449 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5504 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5624r move to info_mask_(shared_by_type/separate)
      iio:dac:ad5686 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5755 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5764 move to info_mask_(shared_by_type/separate)
      iio:dac:ad5791 move to info_mask_(shared_by_type/separate)
      iio:dac:max517 move to info_mask_(shared_by_type/separate)
      iio:dac:mcp4725 move to info_mask_(shared_by_type/separate)
      iio:freq:ad9523 move to info_mask_(shared_by_type/separate)
      iio:gyro:adis16080 move to info_mask_(shared_by_type/separate)
      iio:gyro:adis16136 move to info_mask_(shared_by_type/separate)
      iio:gyro:adxrs450 move to info_mask_(shared_by_type/separate)
      iio:gyro:itg3200_core move to info_mask_(shared_by_type/separate)
      iio:imu:adis16400 move to info_mask_(shared_by_type/separate)
      iio:imu:adis16480 move to info_mask_(shared_by_type/separate)
      iio:imu:mpu6050 move to info_mask_(shared_by_type/separate)
      iio:light:adjd_s311 move to info_mask_(shared_by_type/separate)
      iio:light:lm3533 move to info_mask_(shared_by_type/separate)
      iio:light:tsl2563 move to info_mask_(shared_by_type/separate)
      iio:light:vcnl4000 move to info_mask_(shared_by_type/separate)
      staging:iio:accel:adis move to info_mask_(shared_by_type/separate)
      staging:iio:accel:adis16220 move to info_mask_(shared_by_type/separate)
      staging:iio:accel:lis3l02dq move to info_mask_(shared_by_type/separate)
      staging:iio:accel:sca3000 move to info_mask_(shared_by_type/separate)
      staging:iio:adc:ad7280a move to info_mask_(shared_by_type/separate)
      staging:iio:adc:ad7291 move to info_mask_(shared_by_type/separate)
      staging:iio:adc:ad7606 move to info_mask_(shared_by_type/separate)
      staging:iio:adc:ad799x move to info_mask_(shared_by_type/separate)
      staging:iio:cdc:ad7150 move to info_mask_(shared_by_type/separate)
      staging:iio:cdc:ad7152 move to info_mask_(shared_by_type/separate)
      staging:iio:cdc:ad7746 move to info_mask_(shared_by_type/separate)
      staging:iio:gyro:adis16060 move to info_mask_(shared_by_type/separate)
      staging:iio:gyro:adis16130 move to info_mask_(shared_by_type/separate)
      staging:iio:impedance:ad5933 move to info_mask_(shared_by_type/separate)
      staging:iio:light:isl29018 move to info_mask_(shared_by_type/separate)
      staging:iio:light:isl29028 move to info_mask_(shared_by_type/separate)
      staging:iio:light:tsl2x7x move to info_mask_(shared_by_type/separate)
      staging:iio:mag:ak8975 move to info_mask_(shared_by_type/separate)
      staging:iio:magnetometer:hmc5843 move to info_mask_(shared_by_type/separate)
      staging:iio:meter:ade7758 move to info_mask_(shared_by_type/separate)
      staging:iio:resolver:ad2s1200 move to info_mask_(shared_by_type/separate)
      staging:iio:resolver:ad2s1210 move to info_mask_(shared_by_type/separate)
      staging:iio:resolver:ad2s90 move to info_mask_(shared_by_type/separate)
      iio:adc:exynos move to info_mask_(shared_by_type/separate)
      iio:adc:ad7923 move to info_mask_(shared_by_type/separate)
      staging:iio:adc:spear move to info_mask_(shared_by_type/separate)
      staging:iio:adc:mxs move to info_mask_(shared_by_type/separate)
      staging:iio:adc:lpc32xx move to info_mask_(shared_by_type/separate)
      iio:core drop info_mask from struct iio_info
      hwmon: Move the IIO client driver for hwmon out of staging

Lars-Peter Clausen (5):
      staging:iio: Remove adt7410 driver
      iio: events: Make iio_push_event() IRQ context save
      iio:ad7923: Return error if we didn't get the expected result
      iio:ad7923: Implement scale reporting
      iio:adc:ad7923: Add support for the ad7904/ad7914/ad7924

Naveen Krishna Chatradhi (2):
      iio: adc: add exynos adc driver under iio framwork
      iio: adc: Kconfig: exynos_adc depends on CONFIG_OF

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |   52 +
 .../devicetree/bindings/iio/iio-bindings.txt       |   97 ++
 drivers/hwmon/Kconfig                              |    9 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/{staging/iio => hwmon}/iio_hwmon.c         |    8 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   24 +-
 drivers/iio/accel/kxsd9.c                          |    6 +-
 drivers/iio/adc/Kconfig                            |   20 +
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ad7266.c                           |   12 +-
 drivers/iio/adc/ad7298.c                           |   10 +-
 drivers/iio/adc/ad7476.c                           |   10 +-
 drivers/iio/adc/ad7887.c                           |    8 +-
 drivers/iio/adc/ad7923.c                           |  383 +++++++
 drivers/iio/adc/at91_adc.c                         |    4 +-
 drivers/iio/adc/exynos_adc.c                       |  452 ++++++++
 drivers/iio/adc/lp8788_adc.c                       |    4 +-
 drivers/iio/adc/max1363.c                          |    9 +-
 drivers/iio/adc/ti-adc081c.c                       |    4 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    2 +-
 drivers/iio/adc/viperboard_adc.c                   |    2 +-
 drivers/iio/amplifiers/ad8366.c                    |    2 +-
 drivers/iio/common/st_sensors/st_sensors_spi.c     |   11 +-
 drivers/iio/dac/ad5064.c                           |    4 +-
 drivers/iio/dac/ad5360.c                           |   10 +-
 drivers/iio/dac/ad5380.c                           |    8 +-
 drivers/iio/dac/ad5421.c                           |   10 +-
 drivers/iio/dac/ad5446.c                           |    4 +-
 drivers/iio/dac/ad5449.c                           |    4 +-
 drivers/iio/dac/ad5504.c                           |    4 +-
 drivers/iio/dac/ad5624r_spi.c                      |    4 +-
 drivers/iio/dac/ad5686.c                           |    6 +-
 drivers/iio/dac/ad5755.c                           |   10 +-
 drivers/iio/dac/ad5764.c                           |   10 +-
 drivers/iio/dac/ad5791.c                           |    6 +-
 drivers/iio/dac/max517.c                           |    4 +-
 drivers/iio/dac/mcp4725.c                          |    4 +-
 drivers/iio/frequency/ad9523.c                     |    8 +-
 drivers/iio/gyro/adis16080.c                       |   22 +-
 drivers/iio/gyro/adis16136.c                       |   13 +-
 drivers/iio/gyro/adxrs450.c                        |   22 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   24 +-
 drivers/iio/gyro/itg3200_core.c                    |   13 +-
 drivers/iio/iio_core.h                             |    1 +
 drivers/iio/imu/adis16400_core.c                   |   49 +-
 drivers/iio/imu/adis16480.c                        |   32 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |    5 +-
 drivers/iio/industrialio-core.c                    |   35 +-
 drivers/iio/industrialio-event.c                   |   29 +-
 drivers/iio/inkern.c                               |  171 +++
 drivers/iio/light/adjd_s311.c                      |    4 +-
 drivers/iio/light/hid-sensor-als.c                 |    8 +-
 drivers/iio/light/lm3533-als.c                     |    6 +-
 drivers/iio/light/tsl2563.c                        |   10 +-
 drivers/iio/light/vcnl4000.c                       |    6 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   24 +-
 drivers/staging/iio/Kconfig                        |    8 -
 drivers/staging/iio/Makefile                       |    2 -
 drivers/staging/iio/accel/adis16201_core.c         |    8 +-
 drivers/staging/iio/accel/adis16203_core.c         |    2 +-
 drivers/staging/iio/accel/adis16204_core.c         |    8 +-
 drivers/staging/iio/accel/adis16209_core.c         |    4 +-
 drivers/staging/iio/accel/adis16220_core.c         |   26 +-
 drivers/staging/iio/accel/adis16240_core.c         |    9 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |   11 +-
 drivers/staging/iio/accel/sca3000_core.c           |    5 +-
 drivers/staging/iio/adc/Kconfig                    |    7 -
 drivers/staging/iio/adc/Makefile                   |    1 -
 drivers/staging/iio/adc/ad7280a.c                  |   12 +-
 drivers/staging/iio/adc/ad7291.c                   |   10 +-
 drivers/staging/iio/adc/ad7606_core.c              |    4 +-
 drivers/staging/iio/adc/ad799x_core.c              |   76 +-
 drivers/staging/iio/adc/adt7410.c                  | 1102 --------------------
 drivers/staging/iio/adc/lpc32xx_adc.c              |    2 +-
 drivers/staging/iio/adc/mxs-lradc.c                |    2 +-
 drivers/staging/iio/adc/spear_adc.c                |    4 +-
 drivers/staging/iio/cdc/ad7150.c                   |    8 +-
 drivers/staging/iio/cdc/ad7152.c                   |   32 +-
 drivers/staging/iio/cdc/ad7746.c                   |   48 +-
 drivers/staging/iio/gyro/adis16060_core.c          |   11 +-
 drivers/staging/iio/gyro/adis16130_core.c          |    4 +-
 drivers/staging/iio/gyro/adis16260_core.c          |    4 +-
 drivers/staging/iio/iio_simple_dummy.c             |   33 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   10 +-
 drivers/staging/iio/light/isl29018.c               |    8 +-
 drivers/staging/iio/light/isl29028.c               |   10 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |   40 +-
 drivers/staging/iio/magnetometer/ak8975.c          |    4 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |    4 +-
 drivers/staging/iio/meter/ade7758_core.c           |   60 +-
 drivers/staging/iio/resolver/ad2s1200.c            |    4 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    4 +-
 drivers/staging/iio/resolver/ad2s90.c              |    2 +-
 include/linux/iio/adc/ad_sigma_delta.h             |    6 +-
 include/linux/iio/common/st_sensors.h              |    5 +-
 include/linux/iio/iio.h                            |   79 +-
 include/linux/iio/imu/adis.h                       |   34 +-
 98 files changed, 1715 insertions(+), 1710 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
 rename drivers/{staging/iio => hwmon}/iio_hwmon.c (96%)
 create mode 100644 drivers/iio/adc/ad7923.c
 create mode 100644 drivers/iio/adc/exynos_adc.c
 delete mode 100644 drivers/staging/iio/adc/adt7410.c
