Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42716 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdBATTf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2017 14:19:35 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] 3rd set of IIO new device support, features and cleanups for
 the 4.11 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e3c14701-02ba-b05c-f090-34f36bb9c9dc@kernel.org>
Date: Wed, 1 Feb 2017 19:19:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 63d8d50ce356687e0cac575335a9068ddc229b76:

  staging: lustre: lnet: Fix coding style errors (2017-01-27 21:09:33 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.11c

for you to fetch changes up to bfe7288e0dd143268359f703ac9b8d4f904d3f75:

  iio: stx104: Add GPIO set_multiple callback function support (2017-02-01 18:50:54 +0000)

----------------------------------------------------------------
Third set of new device support, features and cleanups for IIO in the 4.11 cycle

This also involves a merge of the ib-mid-iio-pwm-4.11 branch from mfd to
bring in support for the stm32 timer triggers needed for the buffered
features in the stm32 adc driver.

New device support:
* Amligic Meson SAR ADC
  - new driver and bindings
* cros_ec barometer
  - new driver
* max5481 digital potentiometers
  - new driver for 5481, 5482, 5483 and 5484
* Renesas GyroADC - a very specific spi offload engine for ADCs
  - new driver and bindings.
* srf08 ultrasonic ranger
  - new driver, bindings and ABI docs,

New features
* Qualcomm PM8xxx ADC bindings.
  - due to a trivial build issues the driver will be following shortly.
* stm32 ADC
  - Triggered buffer mode
  - Allow use of stm32 timer triggers
  - Add trigger polarity control
  - Optional DMA support with bindings update
* stx104
  - add support for gpio names
  - support set_multiple callback
* tmp007
  - optional interrupt support

Cleanups
* ad7150
  - alignment fix.
* ad7816
  - octal rather than symbolic permissions.
* lsm6dsx
  - allow selection of data ready pin via device tree bindings.
* ssp_sensors
  - use devm_iio_device_register to handle unregister automatically.
* stx104
  - use devm functions in probe allowing removal or the remove function.
  - drop unneeded struct stx104_dev
* tmp007
  - fix the name attribute to be a meaninful description of the part.

----------------------------------------------------------------
Andreas Klinger (3):
      iio: distance: srf08: add trivial DT binding
      iio: distance: srf08: add IIO driver for us ranger
      iio: distance: srf08: add driver ABI documentation

Anthony Brandon (1):
      drivers:staging:iio:cdc: Style fix.

Benjamin Gaignard (6):
      dt-bindings: mfd: Add bindings for STM32 Timers driver
      mfd: Add STM32 Timers driver
      dt-bindings: pwm: Add STM32 bindings
      pwm: Add driver for STM32 plaftorm
      iio: Add bindings for STM32 timer trigger driver
      iio: Add STM32 timer trigger driver

Fabrice Gasnier (5):
      iio: adc: stm32: add support for triggered buffer mode
      iio: adc: stm32: Enable use of stm32 timer triggers
      iio: adc: stm32: add trigger polarity extended attribute
      Documentation: dt: iio: stm32-adc: optional dma support
      iio: adc: stm32: add optional dma support

Gwendal Grignou (1):
      iio: cros_ec: Add cros_ec barometer driver

Jonathan Cameron (1):
      Merge tag 'ib-mfd-iio-pwm-4.11' into test

Julián de Gortari (1):
      Staging: iio: adc: ad7816: fix symbolic permissions coding style issue

Lars-Peter Clausen (1):
      iio: tmp007: Fix `name` attribute ABI

Linus Walleij (1):
      iio: adc: add device tree bindings for Qualcomm PM8xxx ADCs

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: add possibility to select drdy pin
      Documentation: dt: iio: imu: st_lsm6dsx: add st,drdy-int-pin property

Manivannan Sadhasivam (1):
      Documentation: dt-bindings: tmp007: Add optional interrupt support

Marek Vasut (2):
      iio: adc: Add Renesas GyroADC bindings
      iio: adc: Add Renesas GyroADC driver

Martin Blumenstingl (2):
      Documentation: dt-bindings: add the Amlogic Meson SAR ADC documentation
      iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs

Matt Weber (1):
      iio: max5481: Add support for Maxim digital potentiometers

Wei Yongjun (2):
      iio: common: ssp_sensors: accel: use devm_iio_device_register()
      iio: common: ssp_sensors: gyro: use devm_iio_device_register()

William Breathitt Gray (4):
      iio: stx104: Utilize devm_ functions in driver probe callback
      iio: stx104: Remove unneeded struct stx104_dev code
      iio: stx104: Add support for GPIO names
      iio: stx104: Add GPIO set_multiple callback function support

 Documentation/ABI/testing/sysfs-bus-iio-adc-stm32  |  18 +
 .../ABI/testing/sysfs-bus-iio-distance-srf08       |  22 +
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |  32 +
 .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 149 ++++
 .../bindings/iio/adc/renesas,gyroadc.txt           |  99 +++
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   7 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   2 +
 .../bindings/iio/potentiometer/max5481.txt         |  23 +
 .../devicetree/bindings/iio/temperature/tmp007.txt |   8 +
 .../bindings/iio/timer/stm32-timer-trigger.txt     |  23 +
 .../devicetree/bindings/mfd/stm32-timers.txt       |  46 +
 .../devicetree/bindings/pwm/pwm-stm32.txt          |  35 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   6 +
 drivers/iio/accel/ssp_accel_sensor.c               |  12 +-
 drivers/iio/adc/Kconfig                            |  30 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/meson_saradc.c                     | 922 +++++++++++++++++++++
 drivers/iio/adc/rcar-gyroadc.c                     | 631 ++++++++++++++
 drivers/iio/adc/stm32-adc-core.c                   |   1 +
 drivers/iio/adc/stm32-adc-core.h                   |   2 +
 drivers/iio/adc/stm32-adc.c                        | 633 +++++++++++++-
 drivers/iio/adc/stx104.c                           |  72 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |  12 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  59 +-
 drivers/iio/potentiometer/Kconfig                  |  11 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/max5481.c                | 223 +++++
 drivers/iio/pressure/Kconfig                       |  10 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/cros_ec_baro.c                | 220 +++++
 drivers/iio/proximity/Kconfig                      |  13 +-
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/srf08.c                      | 398 +++++++++
 drivers/iio/temperature/tmp007.c                   |   2 +-
 drivers/iio/trigger/Kconfig                        |   9 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/stm32-timer-trigger.c          | 342 ++++++++
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/stm32-timers.c                         |  80 ++
 drivers/platform/chrome/cros_ec_dev.c              |   3 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-stm32.c                            | 397 +++++++++
 drivers/staging/iio/adc/ad7816.c                   |  10 +-
 drivers/staging/iio/cdc/ad7150.c                   |  30 +-
 include/linux/iio/timer/stm32-timer-trigger.h      |  62 ++
 include/linux/mfd/cros_ec_commands.h               |   3 +-
 include/linux/mfd/stm32-timers.h                   |  71 ++
 52 files changed, 4673 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-stm32
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
 create mode 100644 drivers/iio/adc/meson_saradc.c
 create mode 100644 drivers/iio/adc/rcar-gyroadc.c
 create mode 100644 drivers/iio/potentiometer/max5481.c
 create mode 100644 drivers/iio/pressure/cros_ec_baro.c
 create mode 100644 drivers/iio/proximity/srf08.c
 create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
 create mode 100644 drivers/mfd/stm32-timers.c
 create mode 100644 drivers/pwm/pwm-stm32.c
 create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
 create mode 100644 include/linux/mfd/stm32-timers.h
