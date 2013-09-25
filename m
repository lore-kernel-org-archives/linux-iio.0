Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH Resend 00/32] iio: Introduce devm_iio_device_{register,unregister}
Date: Wed, 25 Sep 2013 16:19:36 +0530
Message-Id: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

With the conversion of iio drivers to use device managed APIs, several
drivers now have a remove function with only the iio_device_unregister()
call. Thus introduce device managed version of iio_device_register() to
clean up lot of such code. 3 patches also removes the unregister call in drivers
where it happens to be the last call before return statement.

This is only compile tested as I do not have any actual hardware to test ATM.

Sachin Kamat (32):
  iio: core: Implement devm_iio_device_{register,unregister}
  iio: accel: kxsd9: Use devm_iio_device_register
  iio: adc: mcp3422: Use devm_iio_device_register
  iio: adc: twl6030-gpadc: Use devm_iio_device_register
  iio: adc: viperboard: Use devm_iio_device_register
  iio: dac: ad5421: Use devm_iio_device_register
  iio: dac: ad5755: Use devm_iio_device_register
  iio: dac: max517: Use devm_iio_device_register
  iio: dac: mcp4725: Use devm_iio_device_register
  iio: gyro: adis16130: Use devm_iio_device_register
  iio: gyro: adxrs450: Use devm_iio_device_register
  iio: light: vcnl4000: Use devm_iio_device_register
  staging: iio: adis16220: Use devm_iio_device_register
  staging: iio: ad7816: Use devm_iio_device_register
  staging: iio: lpc32xx_adc: Use devm_iio_device_register
  staging: iio: addac: Use devm_iio_device_register
  staging: iio: ad7150: Use devm_iio_device_register
  staging: iio: ad7746: Use devm_iio_device_register
  staging: iio: ad5930: Use devm_iio_device_register
  staging: iio: ad9850: Use devm_iio_device_register
  staging: iio: ad9852: Use devm_iio_device_register
  staging: iio: ad9910: Use devm_iio_device_register
  staging: iio: ad9951: Use devm_iio_device_register
  staging: iio: adis16060: Use devm_iio_device_register
  staging: iio: isl29018: Use devm_iio_device_register
  staging: iio: isl29028: Use devm_iio_device_register
  staging: iio: tsl2583: Use devm_iio_device_register
  staging: iio: tsl2x7x_core: Use devm_iio_device_register
  staging: iio: ade7854: Use devm_iio_device_register
  staging: iio: ad2s1200: Use devm_iio_device_register
  staging: iio: ad2s90: Use devm_iio_device_register
  staging: iio: ad7152: Use devm_iio_device_register

 Documentation/driver-model/devres.txt      |    2 ++
 drivers/iio/accel/kxsd9.c                  |   10 +-------
 drivers/iio/adc/mcp3422.c                  |    9 +------
 drivers/iio/adc/twl6030-gpadc.c            |    5 +---
 drivers/iio/adc/viperboard_adc.c           |   12 +---------
 drivers/iio/dac/ad5421.c                   |   12 +---------
 drivers/iio/dac/ad5755.c                   |   12 +---------
 drivers/iio/dac/max517.c                   |    9 +------
 drivers/iio/dac/mcp4725.c                  |    9 +------
 drivers/iio/gyro/adis16130.c               |    9 +------
 drivers/iio/gyro/adxrs450.c                |   14 ++---------
 drivers/iio/industrialio-core.c            |   35 ++++++++++++++++++++++++++++
 drivers/iio/light/vcnl4000.c               |    9 +------
 drivers/staging/iio/accel/adis16220_core.c |    7 ++----
 drivers/staging/iio/adc/ad7816.c           |   12 +---------
 drivers/staging/iio/adc/lpc32xx_adc.c      |   12 +---------
 drivers/staging/iio/addac/adt7316-i2c.c    |    6 -----
 drivers/staging/iio/addac/adt7316-spi.c    |    6 -----
 drivers/staging/iio/addac/adt7316.c        |   12 +---------
 drivers/staging/iio/addac/adt7316.h        |    1 -
 drivers/staging/iio/cdc/ad7150.c           |   12 +---------
 drivers/staging/iio/cdc/ad7152.c           |   12 +---------
 drivers/staging/iio/cdc/ad7746.c           |   12 +---------
 drivers/staging/iio/frequency/ad5930.c     |   10 +-------
 drivers/staging/iio/frequency/ad9850.c     |   10 +-------
 drivers/staging/iio/frequency/ad9852.c     |   10 +-------
 drivers/staging/iio/frequency/ad9910.c     |   10 +-------
 drivers/staging/iio/frequency/ad9951.c     |   10 +-------
 drivers/staging/iio/gyro/adis16060_core.c  |   10 +-------
 drivers/staging/iio/light/isl29018.c       |   13 +----------
 drivers/staging/iio/light/isl29028.c       |   11 +--------
 drivers/staging/iio/light/tsl2583.c        |   10 +-------
 drivers/staging/iio/light/tsl2x7x_core.c   |    4 +---
 drivers/staging/iio/meter/ade7854-i2c.c    |    6 -----
 drivers/staging/iio/meter/ade7854-spi.c    |    7 ------
 drivers/staging/iio/meter/ade7854.c        |   14 +----------
 drivers/staging/iio/meter/ade7854.h        |    1 -
 drivers/staging/iio/resolver/ad2s1200.c    |   10 +-------
 drivers/staging/iio/resolver/ad2s90.c      |   10 +-------
 include/linux/iio/iio.h                    |   25 ++++++++++++++++++++
 40 files changed, 95 insertions(+), 315 deletions(-)

-- 
1.7.9.5
