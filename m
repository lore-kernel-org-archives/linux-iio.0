Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752075AbdLBQME (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 11:12:04 -0500
Date: Sat, 2 Dec 2017 16:12:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support, features and cleanup for
 IIO in the 4.16 cycle.
Message-ID: <20171202161201.3b85d72e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit dfe571ac12087c22fba62bdd2cc1aad7eb6ab878:

  staging: ipx: depends on NET (2017-11-30 17:13:52 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.16a

for you to fetch changes up to 8d05ffd2b8a08668cfea9e64a2991ab8ec9b494e:

  iio: Add macro to populate struct iio_map array (2017-12-02 13:28:21 +0000)

----------------------------------------------------------------
First set of new device support, cleanups and features for IIO in the 4.16 cycle

New device support
* IDT Z0PT2201 ambient light and UVB sensor
  - new driver and DT bindings.
* MAX30102 (pulse oximetery sensor)
  - support for MAX30105 sensor (smoke detector)  Just goes to show
    how two supposedly totally different applications can use very similar
    devices.
* UVIS25 UV sensor
  - new driver and DT bindings.

Major new features
* at91-sama5d2-adc
  - DMA support including bindings + a fix for an issue with acking the
    interrupt to prevent false overrun reports.
* ina2xx
  - allow control of shunt voltage PGA and bus voltage range to give better
    accuracy in some cases.
* stm32-adc
  - support differential channels (precursor patch reworked how channel names
    were created to enable this).

Cleanups / minor fixes / features
* core
  - mark a deliberate switch fallthrough.
  - macro to populate struct iio_map array elements.
* docs
  - typo fix.
* MAINTAINERS
  - add some missing entries for IIO ABI files.

* ad7152
  - tidy up unlocking paths.
* ad7746
  - tidy up unlocking paths.
* ak8975
  - add an ACPI id found on a prototype board.
* aspeed-adc
  - deassert reset in probe to ensure device is usable.
* bfin-trigger
  - platform_get_irq return value fixing.
* bmc150
  - OF device ID table for i2c (spi to be done).
* cros_ec
  - unused variable cleanup.
* da208
  - ACPI binding seen on Linx 820 tablet.
* ina2xx
  - shift down raw value to drop status flags from value (likely to have
    been hidden in the noise).
  - tidy up a special case that wasn't needed.
* inv_mpu6050
  - i2c_unregister_device knows about null values so don't check it twice.
* kxsd9
  - fix missing MODULE_LICENSE and MODULE_DESCRIPTION.
* max30102
  - missing new lines in dev_err.
  - inconsistent punctuation in error messages.
  - fix LED mode mask number of bits.
  - check return value of power mode functions to handle errors.
  - introduce an intensity channel macro to reduce duplication.
  - fix minor issue where device wasn't necessarily enabled during
    a get temperature.
  - use indicies for LED channels.
  - move the mode seetting to buffer_postenable - precursor to new device
    support.
  - prepare to allow copying of varying numbers of measurement.
* meson-saradc
  - drop irrelevant clock and update bindings.
* mma8452
  - a couple of renames for readability reasons.
* qcom_vadc
  - fix missing MODULE_LICENSE and MODULE_DESCRIPTION.
* st_accel
  - drop an unused variable.
* sx9500
  - add an ACPI id found on a prototype board.

----------------------------------------------------------------
Andy Shevchenko (3):
      iio: proximity: sx9500: Add another ACPI ID
      iio: magnetometer: ak8975: Add another ACPI ID
      iio: imu: inv_mpu6050: Remove duplicate NULL check

Arvind Yadav (1):
      iio: trigger: Fix platform_get_irq's error checking

Colin Ian King (1):
      iio: accel: st_accel: remove redundant pointer pdata

Eugen Hristev (3):
      dt-bindings: iio: at91-sama5d2_adc: add optional dma property
      iio: adc: at91-sama5d2_adc: add support for DMA
      iio: adc: at91-sama5d2_adc: ack DRDY irq in direct mode

Fabrice Gasnier (3):
      dt-bindings: iio: adc: stm32: add support for diff channels
      iio: adc: stm32: remove const channel names definition
      iio: adc: stm32: add support for differential channels

Gustavo A. R. Silva (1):
      iio: core: Mark expected switch fall-through

Harinath Nampally (2):
      iio: accel: mma8452: Rename a struct for code readibility
      iio: accel: mma8452: Rename config structs for readability

Javier Martinez Canillas (1):
      iio: accel: bmc150: Add OF device ID table

Joel Stanley (1):
      iio: adc: aspeed: Deassert reset in probe

Linus Walleij (1):
      iio: adc/accel: Fix up module licenses

Lorenzo Bianconi (2):
      iio: light: add support for UVIS25 sensor
      dt-bindings: iio: light: add UVIS25 device bindings

Lukas Wunner (2):
      MAINTAINERS: Add missing IIO ABI entries
      iio: Add macro to populate struct iio_map array

Luke Ross (1):
      iio:accel:da280: Linx 820 Windows tablet has a da280 mapped via ACPI

Markus Elfring (2):
      staging: iio: ad7152: Improve unlocking of a mutex in ad7152_start_calib()
      staging: iio: ad7746: Improve unlocking of a mutex in ad7746_start_calib()

Paolo Cretaro (1):
      iio: cros_ec: Remove unused variables

Peter Meerwald-Stadler (14):
      iio: light: Add driver for IDT ZOPT2201 ambient light and UVB sensor
      Documentation: iio: Fix typo
      iio: health: max30102: Fix missing newline in dev_err
      iio: health: max30102: Remove inconsistent full stop in error message
      iio: health: max30102: Fix mode config values
      iio: health: max30102: Check retval of powermode function
      iio: health: max30102: Add check for part ID
      iio: health: max30102: Introduce intensity channel macro
      iio: health: max30102: Add power enable parameter to get_temp function
      iio: health: max30102: Introduce indices for LED channels
      iio: health: max30102: Move mode setting to buffer_postenable
      iio: health: max30102: Prepare for copying varying number of measurements
      iio: health: max30102: Add MAX30105 support
      dt-bindings: iio: health: Add MAX30105 support to max30102.txt

Stefan Brüns (3):
      iio: adc: ina2xx: Shift bus voltage register to mask flag bits
      iio: adc: ina2xx: Use LSB specifier instead of divider in config
      iio: adc: ina2xx: Allow setting Shunt Voltage PGA gain and Bus Voltage range

Xingyu Chen (2):
      iio: adc: meson-saradc: remove irrelevant clock "sana"
      dt-bindings: iio: adc: update the doc for SAR ADC

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +-
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |   1 -
 .../devicetree/bindings/iio/adc/aspeed_adc.txt     |   4 +-
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   7 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  24 +
 .../devicetree/bindings/iio/health/max30102.txt    |   8 +-
 .../devicetree/bindings/iio/light/uvis25.txt       |  23 +
 MAINTAINERS                                        |   6 +
 drivers/iio/accel/bmc150-accel-i2c.c               |  12 +
 drivers/iio/accel/da280.c                          |  31 +-
 drivers/iio/accel/kxsd9-i2c.c                      |   3 +
 drivers/iio/accel/mma8452.c                        |  16 +-
 drivers/iio/accel/st_accel_core.c                  |   5 -
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/aspeed_adc.c                       |  25 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 | 456 ++++++++++++++++-
 drivers/iio/adc/axp288_adc.c                       |  20 +-
 drivers/iio/adc/ina2xx-adc.c                       | 149 +++++-
 drivers/iio/adc/meson_saradc.c                     |  20 -
 drivers/iio/adc/qcom-vadc-common.c                 |   4 +
 drivers/iio/adc/stm32-adc.c                        | 181 ++++---
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   2 -
 drivers/iio/health/max30102.c                      | 308 ++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |   3 +-
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/light/Kconfig                          |  34 ++
 drivers/iio/light/Makefile                         |   4 +
 drivers/iio/light/cros_ec_light_prox.c             |   2 -
 drivers/iio/light/st_uvis25.h                      |  37 ++
 drivers/iio/light/st_uvis25_core.c                 | 359 +++++++++++++
 drivers/iio/light/st_uvis25_i2c.c                  |  69 +++
 drivers/iio/light/st_uvis25_spi.c                  |  68 +++
 drivers/iio/light/zopt2201.c                       | 568 +++++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c                  |   1 +
 drivers/iio/proximity/sx9500.c                     |   1 +
 drivers/staging/iio/cdc/ad7152.c                   |  17 +-
 drivers/staging/iio/cdc/ad7746.c                   |  17 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   4 +-
 include/linux/iio/machine.h                        |   7 +
 39 files changed, 2236 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/uvis25.txt
 create mode 100644 drivers/iio/light/st_uvis25.h
 create mode 100644 drivers/iio/light/st_uvis25_core.c
 create mode 100644 drivers/iio/light/st_uvis25_i2c.c
 create mode 100644 drivers/iio/light/st_uvis25_spi.c
 create mode 100644 drivers/iio/light/zopt2201.c
