Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47129 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3C2KXs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 06:23:48 -0400
Message-ID: <51556BB0.5060505@kernel.org>
Date: Fri, 29 Mar 2013 10:23:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups and fixes (IIO set 2 for the 3.10 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c5cf4606b6659e711258b6e567415ab83a3b646c:

  staging: comedi: s626: remove MC_DISABLE macro (2013-03-25 11:44:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.10b

for you to fetch changes up to 2b684024b59c4b1a1440e8c7499b7060a22d1ec1:

  iio: adc: Document the regulator/clocks for exynos-adc (2013-03-29 09:33:45 +0000)

----------------------------------------------------------------
Second round of IIO cleanups for the 3.10 cycle

1) A nice little removal of the unwanted private pointer from
   struct iio_trigger.
2) Some clean up of the ad799x driver.
3) Couple of cleanups for the exynos_adc driver and some documentation.
4) Move the mxs-lradc initialization a little earlier in the driver to avoid
   wiping out the configuration just after setting it.

A nice small set of worthy bits and bobs.

----------------------------------------------------------------
Alexandre Belloni (1):
      iio: mxs-lradc: Do hardware initialization earlier

Doug Anderson (1):
      iio: adc: Document the regulator/clocks for exynos-adc

Lars-Peter Clausen (8):
      iio:trigger: Introduce iio_tigger_{set,get}_drvdata
      iio:trigger: Use dev_{set,get}_drvdata for private data management
      staging:iio:ad799x: Remove unused ad799x_state fields
      staging:iio:ad799x: Remove internal reference support
      staging:iio:ad799x: Use i2c_smbus_{read,write}_word_data_swapped
      staging:iio:ad799x: Add helper macro for channel initialization
      staging:iio:ad799x: Set IIO_CHAN_INFO_SCALE mask
      staging:iio:ad799x: Preallocate sample buffer

Sachin Kamat (2):
      iio: exynos_adc: Remove redundant of_match_ptr macro
      iio: exynos-adc: Fix typo in DT documentation

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  12 +-
 drivers/iio/accel/st_accel_buffer.c                |   2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   2 +-
 drivers/iio/adc/at91_adc.c                         |   4 +-
 drivers/iio/adc/exynos_adc.c                       |   2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   4 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   2 +-
 drivers/iio/gyro/itg3200_buffer.c                  |   4 +-
 drivers/iio/gyro/st_gyro_buffer.c                  |   2 +-
 drivers/iio/imu/adis_trigger.c                     |   4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   4 +-
 drivers/staging/iio/Documentation/trigger.txt      |   3 -
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   6 +-
 drivers/staging/iio/adc/ad799x.h                   |   7 +-
 drivers/staging/iio/adc/ad799x_core.c              | 417 ++++-----------------
 drivers/staging/iio/adc/ad799x_ring.c              |  16 +-
 drivers/staging/iio/adc/mxs-lradc.c                |  10 +-
 drivers/staging/iio/meter/ade7758_trigger.c        |   6 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   8 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |   6 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |  12 +-
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |   4 +-
 include/linux/iio/trigger.h                        |  26 +-
 23 files changed, 154 insertions(+), 409 deletions(-)
