Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50518 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdDBSri (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 14:47:38 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Third set of IIO new device support, features and cleanups for
 the 4.12 cycle.
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ce06b602-571b-0dc6-0ac4-1da5c8b01bc6@kernel.org>
Date: Sun, 2 Apr 2017 19:47:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c831c583f8d93185928096b6f3e4735c013f1969:

  Merge tag 'iio-for-4.12b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2017-03-22 11:56:03 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.12c

for you to fetch changes up to 2ccc15036d812e75f334c0fb813104ef765a2c77:

  iio: imu: st_lsm6dsx: do not apply ODR configuration in write_raw handler (2017-04-02 14:36:06 +0100)

----------------------------------------------------------------
Third set of new device support, cleanups and features for IIO in the 4.12 cycle

Somewhat dominated in patch numbers of last of the outreachy application
window related patches (they are still coming, despite window being closed
which is good to see!)

Good set of new drivers as well.

New device support
* ASPEED ADC
  - new driver
* cpcap PMIC ADC
  - new driver
* hid-humidity
  - driver for HID compatible humidity sensors.
* ltc2497 ADC
  - new driver
* mpu6050
  - bring bindings up to date and add trivial support for 9250
* rockchip-saradc
  - update bindings to cover rk3328
* vl6180 light, proximity and time of flight sensor.
  - new driver

Features
* meson-saradc
  - add calibration

Cleanup and minor fixes
* ad5504
  - constify attribute_group structure
  - drop casting of void *
* ad7150
  - replace some shifts of 1 by BIT macro usage
* ad7152
  - blank lines between function definitions
* ad7280a
  - octal permissions.
* ad7606
  - replace use of core mlock mutex with a local lock
* ad7746
  - replace some shifts of 1 by BIT macro usage
  - function parameter alignment
  - drop some excessive brackets (introduced in last pull request)
* ad7753
  - white space cleanup
* ad7754
  - includes in alphabetical order and groupped appropriately.
  - change from missuse of internal mlock mutex to using the buffer lock to
  also protect values during frequency update.
* ad779x
  - constify attribute_group structures
* ad9832
  - octal permissions
* adis16060
  - remove use of core mlock mutex in favour of adding a local
  _spi_write_then_read which can use the local buffer protection lock.
  - fix naming of above function.
* adis16203
  - remove locking during reads of calibbias that doesn't protect anything
  not protected elsewhere.
* adis16209
  - remove unnecessary braces in single statement if
* adis16240
  - remove unnecessary braces in single statement if
* adt7136
  - drop excess blank lines and put some in between functions.
* ams-iaq
  - replace comma with semi colon. Not actual bug, just unusual syntax.
* apds9960
  - constify attribute group structure
* as3935
  - constify attribute group structure
* bm1750
  - constify attribute group structure
* cros_ec
  - devm version of triggered buffer setup to simplify code.
* exynos
  - drop casting of void *
* hdc100x
  - constify attribute_group structure
* hid-accel
  - fix wrong scale for newly introduced gravity sensor.
* hts221
  - drop casting of void *
* hx711
  - constify attribute_group structure
* imx7d_adc
  - drop casting of void *
* lm35333
  - constify attribute_group structure
* lsm6dsx
  - drop casting of void *
  - hold ODR configuration until enabling to avoid a race condition.
* max1027
  - drop casting of void *
* max11100
  - fix a comma where semicolon was intended (no actual bug, just odd)
* max1363
  - constify attribute_group structure
* ms sensors
  - drop casting of void *
* rockchip_saradc
  - drop casting of void *
* sun4i-gpadc
  - fix missing dependency on THERMAL or presence of stubs (issue only
  introduced in pervious set)
  - drop casting of void *
* tsl2x7x
  - fix wrong standard deviation calc.  Note these aren't actually used for
  anything at the moment so bug didn't really matter.
  - constify attribute group structure.
* vf610adc
  - drop casting of void *
* vz89x
  - replace comma with semicolon. Not actual bug, just odd syntax.
* zpa2326
  - drop casting of void *

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: adc: sun4i: add THERMAL dependency

Arushi Singhal (5):
      staging: iio: Replace a bit shift by a use of BIT.
      staging: ad7606: Replace mlock with driver private lock
      staging: iio: Remove extra Parenthesis.
      iio: adc: replace comma with a semicolon
      drivers: iio: chemical: replace comma with a semicolon

Enric Balletbo i Serra (1):
      iio: cros_ec_sensors: Use devm to setup the triggered buffer.

Eva Rachel Retuya (1):
      staging: iio: tsl2x7x_core: Fix standard deviation calculation

Gargi Sharma (2):
      staging: adis16203: Remove locking on raw reads of IIO_CHAN_INFO_CALIBBIAS
      staging: iio: update locking method during frequency writes

Guru Das Srinagesh (1):
      staging: iio: ad9832: use 4-digit octal permissions

Heiner Kallweit (1):
      iio: adc: meson-saradc: add calibration

Jonathan Cameron (2):
      iio:imu:mpu6050 update i2c bindings to reflect i2c-gate and supported parts
      iio:imu:mpu6050 add explicit mpu9250 support

Liang Chen (1):
      dt-bindings: iio: rockchip-saradc: add support for rk3328

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: do not apply ODR configuration in write_raw handler

Manivannan Sadhasivam (1):
      iio:light: Add support for STMicro VL6180 sensor

Mark Stenglein (1):
      staging: iio: accel: remove unneeded braces around single statements

Michael Hennerich (1):
      iio:adc: Driver for Linear Technology LTC2497 ADC

Narcisa Ana Maria Vasile (3):
      staging: iio: adt7136: Remove unnecessary blank lines
      staging: iio: Add blank lines after function declarations
      staging: iio: cdc: ad7746: Fix alignment with paranthesis

Olivier Leveque (1):
      staging: iio: adc: ad7280a: fix permission coding style issue

Rick Altherr (2):
      Documentation: dt-bindings: Document bindings for Aspeed ADC
      iio: Aspeed ADC

Song Hongyan (2):
      iio: hid-sensor-attributes: Fix gravity sensor scale value not right issue
      iio: hid: Add humidity sensor support

Tony Lindgren (1):
      iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC

simran singhal (20):
      staging: iio: adis16060: Remove iio_dev mlock and refactor code
      staging: ade7754: Clean up #includes
      staging: iio: ade7753: Remove trailing whitespaces
      iio: dac: ad5504: constify attribute_group structures
      iio: adc: max1363: constify attribute_group structures
      iio: adc: ad799x: constify attribute_group structures
      iio: proximity: as3935: constify attribute_group structures
      iio: light: bh1750: constify attribute_group structures
      iio: light: apds9960: constify attribute_group structures
      iio: humidity: hdc100x: constify attribute_group structures
      iio: adc: hx711: constify attribute_group structures
      staging: iio: light: tsl2x7x constify attribute_group structures
      iio: light: lm3533-als: constify attribute_group structures
      iio: gyro: adis16060: Change the name of function.
      iio: adc: Remove unnecessary cast on void pointer
      iio: common: ms_sensors: Remove unnecessary cast on void pointer
      iio: dac: ad5504: Remove unnecessary cast on void pointer
      iio: humidity: hts221: Remove unnecessary cast on void pointer
      iio: imu: st_lsm6dsx: Remove unnecessary cast on void pointer
      iio: pressure: zpa2326: Remove unnecessary cast on void pointer

 .../devicetree/bindings/iio/adc/aspeed_adc.txt     |   20 +
 .../devicetree/bindings/iio/adc/cpcap-adc.txt      |   18 +
 .../devicetree/bindings/iio/adc/ltc2497.txt        |   13 +
 .../bindings/iio/adc/rockchip-saradc.txt           |    1 +
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   27 +-
 .../devicetree/bindings/iio/light/vl6180.txt       |   15 +
 MAINTAINERS                                        |    1 +
 drivers/iio/adc/Kconfig                            |   33 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad799x.c                           |    2 +-
 drivers/iio/adc/aspeed_adc.c                       |  295 ++++++
 drivers/iio/adc/cpcap-adc.c                        | 1007 ++++++++++++++++++++
 drivers/iio/adc/exynos_adc.c                       |    2 +-
 drivers/iio/adc/hx711.c                            |    2 +-
 drivers/iio/adc/imx7d_adc.c                        |    2 +-
 drivers/iio/adc/ltc2497.c                          |  279 ++++++
 drivers/iio/adc/max1027.c                          |    2 +-
 drivers/iio/adc/max11100.c                         |    4 +-
 drivers/iio/adc/max1363.c                          |    2 +-
 drivers/iio/adc/meson_saradc.c                     |   77 +-
 drivers/iio/adc/rockchip_saradc.c                  |    2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    2 +-
 drivers/iio/adc/vf610_adc.c                        |    2 +-
 drivers/iio/chemical/ams-iaq-core.c                |    2 +-
 drivers/iio/chemical/vz89x.c                       |    2 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   26 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    8 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |    4 +-
 drivers/iio/dac/ad5504.c                           |    4 +-
 drivers/iio/humidity/Kconfig                       |   14 +
 drivers/iio/humidity/Makefile                      |    3 +
 drivers/iio/humidity/hdc100x.c                     |    2 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |  315 ++++++
 drivers/iio/humidity/hts221_buffer.c               |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    5 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   41 +-
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       |    2 +-
 drivers/iio/light/bh1750.c                         |    2 +-
 drivers/iio/light/lm3533-als.c                     |    4 +-
 drivers/iio/light/vl6180.c                         |  543 +++++++++++
 drivers/iio/pressure/zpa2326.c                     |    4 +-
 drivers/iio/proximity/as3935.c                     |    2 +-
 drivers/staging/iio/accel/adis16203.c              |    3 -
 drivers/staging/iio/accel/adis16209.c              |    3 +-
 drivers/staging/iio/accel/adis16240.c              |    6 +-
 drivers/staging/iio/adc/ad7280a.c                  |   12 +-
 drivers/staging/iio/adc/ad7606.c                   |    9 +-
 drivers/staging/iio/adc/ad7606.h                   |    3 +
 drivers/staging/iio/addac/adt7316.c                |    5 +-
 drivers/staging/iio/cdc/ad7150.c                   |    2 +-
 drivers/staging/iio/cdc/ad7152.c                   |    1 +
 drivers/staging/iio/cdc/ad7746.c                   |   18 +-
 drivers/staging/iio/frequency/ad9832.c             |   20 +-
 drivers/staging/iio/gyro/adis16060_core.c          |   35 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |    4 +-
 drivers/staging/iio/meter/ade7753.c                |    8 +-
 drivers/staging/iio/meter/ade7754.c                |   35 +-
 include/linux/hid-sensor-ids.h                     |    4 +
 64 files changed, 2830 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ltc2497.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vl6180.txt
 create mode 100644 drivers/iio/adc/aspeed_adc.c
 create mode 100644 drivers/iio/adc/cpcap-adc.c
 create mode 100644 drivers/iio/adc/ltc2497.c
 create mode 100644 drivers/iio/humidity/hid-sensor-humidity.c
 create mode 100644 drivers/iio/light/vl6180.c
