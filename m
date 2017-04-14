Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58574 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbdDNV2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 17:28:48 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] 4th set of new device support, features and cleanups for IIO
 in the 4.12 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bdff0c16-32bb-63c9-321e-c104d6467cb9@kernel.org>
Date: Fri, 14 Apr 2017 22:28:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit edf5e79422a9dd98fb896606124edd8407d97d70:

  Merge tag 'iio-for-4.12c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2017-04-03 15:29:12 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.12d

for you to fetch changes up to d454ae2edbfefabe7903c4f6881d1db8fea4b9f7:

  iio: light: apds9960: add system-wide suspend (2017-04-14 16:43:32 +0100)

----------------------------------------------------------------
Fourth set of IIO new device support, features and cleanups for the 4.12 cycle

New device support
* max1117, 1118 and 1119
  - new ADC driver
* max9611
  - new ADC driver
* pm8xxx hk/xoadc
  - new driver with some shared features broken out from the SPMI vadc.
* sun4i-gpadc
  - A33 thermal sensor support (with associated rework)
* stm32-dac
  - new driver and bindings
* stm32 trigger
  - enable support of quadrature encoder device and counter modes

Features
* apds9960
  - use the runtime pm for normal suspend
* stm32-adc
  - add opition to sest resolution via devicetree
* xoadc
  - augment DT bindings to deal with some weird mux cases

Cleanups
* ad5933
  - protect direct mode using claim and release helpers
* ade7759
  - S_IRUGO and friends to octal in two goes
* adis16203
  - drop unnecessary brackets
* hid-sensor
  - fix unbalanced pm_runtieme_enable error when probing after remove
* lsm6dsx
  - use actual part numbers for device name when known
  - simplify data read pin parsing
* mpu3050
  - avoid double reporting errors

----------------------------------------------------------------
Akinobu Mita (1):
      iio: adc: add max1117/max1118/max1119 ADC driver

Benjamin Gaignard (2):
      iio: stm32 trigger: Add quadrature encoder device
      iio: stm32 trigger: Add counter enable modes

Chen Guanqiao (2):
      iio:meter:ade7759: Removing use of deprecated macros (S_IRUGO, S_IWUSR, S_IXUGO)
      iio:meter:ade7759: Removing use of deprecated macros (S_IRUGO, S_IWUSR)

Fabrice Gasnier (4):
      dt-bindings: iio: stm32-adc: add option to set resolution
      iio: adc: stm32: add dt option to set resolution
      dt-bindings: iio: stm32-dac: Add support for STM32 DAC
      iio: dac: add support for stm32 DAC

Jacopo Mondi (3):
      dt-bindings: iio: adc: Add max9611 ADC
      iio: Documentation: Add max9611 sysfs documentation
      iio: adc: Add Maxim max9611 ADC driver

Linus Walleij (3):
      iio: xoadc: augment DT bindings a bit
      iio: adc: break out common code from SPMI VADC
      iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: use i2c/spi device name for iio_dev name
      iio: imu: st_lsm6dsx: simplify data ready pin parsing

Matt Ranostay (1):
      iio: light: apds9960: add system-wide suspend

Narcisa Ana Maria Vasile (1):
      staging: iio: ad5933: Protect DIRECT mode using claim/release helpers

Peter Rosin (1):
      iio: gyro: mpu3050: stop double error reporting

Quentin Schulz (2):
      iio: adc: sun4i-gpadc-iio: move code used in MFD probing to new function
      iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor

René Hickersberger?= (1):
      Staging: iio: accel: adis16203: fixed a brace coding style issue

Srinivas Pandruvada (1):
      iio: hid-sensor: Fix unbalanced pm_runtime_enable error

 .../ABI/testing/sysfs-bus-iio-adc-max9611          |   17 +
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |   71 +-
 .../devicetree/bindings/iio/adc/max1118.txt        |   21 +
 .../devicetree/bindings/iio/adc/max9611.txt        |   27 +
 .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         |   76 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |    4 +
 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |   61 ++
 drivers/iio/adc/Kconfig                            |   39 +-
 drivers/iio/adc/Makefile                           |    4 +
 drivers/iio/adc/max1118.c                          |  307 ++++++
 drivers/iio/adc/max9611.c                          |  585 +++++++++++
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                | 1036 ++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-vadc.c                   |  325 +-----
 drivers/iio/adc/qcom-vadc-common.c                 |  230 +++++
 drivers/iio/adc/qcom-vadc-common.h                 |  108 ++
 drivers/iio/adc/stm32-adc.c                        |   50 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |  170 +++-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    4 +
 drivers/iio/dac/Kconfig                            |   15 +
 drivers/iio/dac/Makefile                           |    2 +
 drivers/iio/dac/stm32-dac-core.c                   |  180 ++++
 drivers/iio/dac/stm32-dac-core.h                   |   51 +
 drivers/iio/dac/stm32-dac.c                        |  334 +++++++
 drivers/iio/gyro/mpu3050-i2c.c                     |    5 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   24 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    2 +-
 drivers/iio/light/apds9960.c                       |    2 +
 drivers/iio/trigger/stm32-timer-trigger.c          |  314 +++++-
 drivers/staging/iio/accel/adis16203.c              |    3 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   50 +-
 drivers/staging/iio/meter/ade7759.c                |   24 +-
 include/linux/mfd/stm32-timers.h                   |    2 +
 include/linux/mfd/sun4i-gpadc.h                    |    4 +
 35 files changed, 3709 insertions(+), 444 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max1118.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max9611.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
 create mode 100644 drivers/iio/adc/max1118.c
 create mode 100644 drivers/iio/adc/max9611.c
 create mode 100644 drivers/iio/adc/qcom-pm8xxx-xoadc.c
 create mode 100644 drivers/iio/adc/qcom-vadc-common.c
 create mode 100644 drivers/iio/adc/qcom-vadc-common.h
 create mode 100644 drivers/iio/dac/stm32-dac-core.c
 create mode 100644 drivers/iio/dac/stm32-dac-core.h
 create mode 100644 drivers/iio/dac/stm32-dac.c
