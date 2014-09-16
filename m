Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44241 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbaIPUPa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Sep 2014 16:15:30 -0400
Message-ID: <54189A58.604@kernel.org>
Date: Tue, 16 Sep 2014 21:15:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new driver, features and cleanups for 3.18 - set 2
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 29a9e89548408028498bb63bcaabe2806232e26a:

  staging: unisys: fix indentation of uisutil_copy_fragsinfo_from_skb() (2014-08-25 17:16:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.18b

for you to fetch changes up to 2017cff24cc08b145bff7256dd6b0ef99e7e8a01:

  iio:bma180: Add BMA250 chip support (2014-09-14 20:52:25 +0100)

----------------------------------------------------------------
Second round of new IIO drivers, features and cleanups for the 3.18 cycle.

New drivers and part support
* Bosch bmg160 Gyroscope driver
* Dyna-Image al3320a ambient light sensor driver
* Bosh bmi055 gyroscope part driver (accelerometer part supported by bmc150)
* isl29018 - add support for isl29023 and isl29035
* kxcjk-1013 - add support for kxcj9-1008 and kxtj2-1009
* bmc150 - additional part support (BMI055 accelerometer part, BMA255,
  BMA222E, BMA250E and BMA280).  Different resolutions but otherwise similar
  parts.
* bma180 - add BMA250 (note different from the BMA250E support above despite
  the naming).  A lot of driver reworking lead up to this - described below.

New features
* kxcjk1013 - add threshold event support.
* rockchip - document DT bindings.
* isl29018 - ACPI support
* bma180 - enable use without IRQ

Cleanups
* Tree wide - drop owner field assignment if using the module_platform_driver
  helper as that assigns it anyway.
* kxcjk1013 - drop a redundant assignment of the current range and fix a
  a defined but not used warning.
* inv_mpu6050 - Remove an unnecessary cast form a void pointer.
* rockchip - drop and unused variable.
* at91_adc - make a local function static.
* st-sensors-core - correctly handle an error in setting in
  st_sensors_set_drdy_int_pin
* isl29018 - typo fix
* bmc150 - fix incorrect scale value for 16G range (Driver new this cycle)
* bmc150 - fix issues when CONFIG_PM_RUNTIME not set (Driver new this cycle)
* ad7606 - line length tidy up.
* bmg160 - set power state only if PM_RUNTIME is defined.
* ak8975 - fix some unnecessary casting between char * and const char *
* bma180 - prefix remaining bits and bobs with bma180_ and ensure consistent.
         - use a bool instead of an int for state (as its either on or off).
         - expose the temperature channel
         - statically allocate buffers to avoid need for update_scan_mode
           callback.
         - refactor to allow futher chip variants including support for part
           specific config and disable code + different resolutions.

----------------------------------------------------------------
Daniel Baluta (5):
      io: accel: kxcjk1013: Remove redundant assignment
      iio: accel: kxcjk-1013: add support for kxcj9-1008
      iio: Add Dyna-Image AL3320A ambient light sensor driver
      iio: accel: kxcjk-1013: add support for kxtj2-1009
      iio: accel: kxcjk-1013: Fix defined but unused warning

Heiko Stübner (2):
      iio: adc: rockchip_saradc: remove unused variable in probe
      dt-bindings: document Rockchip saradc

Irina Tirdea (3):
      iio: gyro: bmg160: only set power state if PM_RUNTIME is defined
      iio: magn: ak8975: fix unnecessary casting between char* and const char*
      iio: gyro: bmi055 gyro sensor driver

Jingoo Han (1):
      iio: imu: inv_mpu6050: Remove casting the return value which is a void pointer

Josh Wu (1):
      iio: adc: at91: make the function handle_adc_eoc_trigger() static

Laurentiu Palcu (6):
      staging: iio: light: isl29018: fix typo
      staging: iio: light: isl29018: add support for isl29023 and isl29035
      iio: accel: BMC150: fix scale value for 16G
      iio: accel: BMC150: fix issues when CONFIG_PM_RUNTIME is not set
      staging: iio: light: isl29018: add ACPI support
      iio: accel: BMC150: add support for other Bosch chips

Lee Jones (1):
      iio: sensors-core: st: Check st_sensors_set_drdy_int_pin()'s return value

Peter Meerwald (11):
      iio:bma180: Enable use of device without IRQ
      iio:bma180: Prefix remaining tables and functions with bma18_
      iio:bma180: Rename BMA_180 to BMA180_
      iio:bma180: Use bool instead of int for state
      iio:bma180: Expose temperature channel
      iio:bma180: Drop _update_scan_mode()
      iio:bma180: Introduce part_info to differentiate further chip variants
      iio:bma180: Introduce part-specific _config() and disable() code
      iio:bma180: Prepare for accelerometer channels with different resolutions
      iio:bma180: Implement _available sysfs attribute dynamically
      iio:bma180: Add BMA250 chip support

Sanjeev Sharma (1):
      iio: remove .owner field for driver using module_platform_driver

Srinivas Pandruvada (3):
      iio:gyro:bmg160 Gyro Sensor driver
      iio:gyro:bmg160 documentation
      iio: accel: kxcjk-1013: Support thresholds

Sören Brinkmann (1):
      staging: ad7606_core: Fix checkpatch warning

 .../ABI/testing/sysfs-bus-iio-gyro-bmg160          |    7 +
 .../bindings/iio/adc/rockchip-saradc.txt           |   24 +
 drivers/iio/accel/Kconfig                          |   13 +-
 drivers/iio/accel/bma180.c                         |  476 +++++---
 drivers/iio/accel/bmc150-accel.c                   |  241 +++-
 drivers/iio/accel/hid-sensor-accel-3d.c            |    1 -
 drivers/iio/accel/kxcjk-1013.c                     |  611 ++++++++--
 drivers/iio/adc/at91_adc.c                         |    2 +-
 drivers/iio/adc/exynos_adc.c                       |    1 -
 drivers/iio/adc/lp8788_adc.c                       |    1 -
 drivers/iio/adc/rockchip_saradc.c                  |    1 -
 drivers/iio/adc/ti_am335x_adc.c                    |    1 -
 drivers/iio/adc/twl4030-madc.c                     |    1 -
 drivers/iio/adc/twl6030-gpadc.c                    |    1 -
 drivers/iio/adc/vf610_adc.c                        |    1 -
 drivers/iio/adc/viperboard_adc.c                   |    1 -
 drivers/iio/common/st_sensors/st_sensors_core.c    |    5 +-
 drivers/iio/gyro/Kconfig                           |   11 +
 drivers/iio/gyro/Makefile                          |    1 +
 drivers/iio/gyro/bmg160.c                          | 1228 ++++++++++++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    1 -
 drivers/iio/humidity/dht11.c                       |    1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    3 +-
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/al3320a.c                        |  232 ++++
 drivers/iio/light/hid-sensor-als.c                 |    1 -
 drivers/iio/light/hid-sensor-prox.c                |    1 -
 drivers/iio/light/lm3533-als.c                     |    1 -
 drivers/iio/magnetometer/ak8975.c                  |   10 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    1 -
 drivers/iio/orientation/hid-sensor-incl-3d.c       |    1 -
 drivers/iio/orientation/hid-sensor-rotation.c      |    1 -
 drivers/iio/pressure/hid-sensor-press.c            |    1 -
 drivers/iio/trigger/iio-trig-interrupt.c           |    1 -
 drivers/staging/iio/adc/ad7606_core.c              |    2 +-
 drivers/staging/iio/light/isl29018.c               |  205 +++-
 37 files changed, 2763 insertions(+), 338 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
 create mode 100644 drivers/iio/gyro/bmg160.c
 create mode 100644 drivers/iio/light/al3320a.c
The following changes since commit 29a9e89548408028498bb63bcaabe2806232e26a:

  staging: unisys: fix indentation of uisutil_copy_fragsinfo_from_skb() (2014-08-25 17:16:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.18b

for you to fetch changes up to 2017cff24cc08b145bff7256dd6b0ef99e7e8a01:

  iio:bma180: Add BMA250 chip support (2014-09-14 20:52:25 +0100)

----------------------------------------------------------------
Second round of new IIO drivers, features and cleanups for the 3.18 cycle.

New drivers and part support
* Bosch bmg160 Gyroscope driver
* Dyna-Image al3320a ambient light sensor driver
* Bosh bmi055 gyroscope part driver (accelerometer part supported by bmc150)
* isl29018 - add support for isl29023 and isl29035
* kxcjk-1013 - add support for kxcj9-1008 and kxtj2-1009
* bmc150 - additional part support (BMI055 accelerometer part, BMA255,
  BMA222E, BMA250E and BMA280).  Different resolutions but otherwise similar
  parts.
* bma180 - add BMA250 (note different from the BMA250E support above despite
  the naming).  A lot of driver reworking lead up to this - described below.

New features
* kxcjk1013 - add threshold event support.
* rockchip - document DT bindings.
* isl29018 - ACPI support
* bma180 - enable use without IRQ

Cleanups
* Tree wide - drop owner field assignment if using the module_platform_driver
  helper as that assigns it anyway.
* kxcjk1013 - drop a redundant assignment of the current range and fix a
  a defined but not used warning.
* inv_mpu6050 - Remove an unnecessary cast form a void pointer.
* rockchip - drop and unused variable.
* at91_adc - make a local function static.
* st-sensors-core - correctly handle an error in setting in
  st_sensors_set_drdy_int_pin
* isl29018 - typo fix
* bmc150 - fix incorrect scale value for 16G range (Driver new this cycle)
* bmc150 - fix issues when CONFIG_PM_RUNTIME not set (Driver new this cycle)
* ad7606 - line length tidy up.
* bmg160 - set power state only if PM_RUNTIME is defined.
* ak8975 - fix some unnecessary casting between char * and const char *
* bma180 - prefix remaining bits and bobs with bma180_ and ensure consistent.
         - use a bool instead of an int for state (as its either on or off).
         - expose the temperature channel
         - statically allocate buffers to avoid need for update_scan_mode
           callback.
         - refactor to allow futher chip variants including support for part
           specific config and disable code + different resolutions.

----------------------------------------------------------------
Daniel Baluta (5):
      io: accel: kxcjk1013: Remove redundant assignment
      iio: accel: kxcjk-1013: add support for kxcj9-1008
      iio: Add Dyna-Image AL3320A ambient light sensor driver
      iio: accel: kxcjk-1013: add support for kxtj2-1009
      iio: accel: kxcjk-1013: Fix defined but unused warning

Heiko Stübner (2):
      iio: adc: rockchip_saradc: remove unused variable in probe
      dt-bindings: document Rockchip saradc

Irina Tirdea (3):
      iio: gyro: bmg160: only set power state if PM_RUNTIME is defined
      iio: magn: ak8975: fix unnecessary casting between char* and const char*
      iio: gyro: bmi055 gyro sensor driver

Jingoo Han (1):
      iio: imu: inv_mpu6050: Remove casting the return value which is a void pointer

Josh Wu (1):
      iio: adc: at91: make the function handle_adc_eoc_trigger() static

Laurentiu Palcu (6):
      staging: iio: light: isl29018: fix typo
      staging: iio: light: isl29018: add support for isl29023 and isl29035
      iio: accel: BMC150: fix scale value for 16G
      iio: accel: BMC150: fix issues when CONFIG_PM_RUNTIME is not set
      staging: iio: light: isl29018: add ACPI support
      iio: accel: BMC150: add support for other Bosch chips

Lee Jones (1):
      iio: sensors-core: st: Check st_sensors_set_drdy_int_pin()'s return value

Peter Meerwald (11):
      iio:bma180: Enable use of device without IRQ
      iio:bma180: Prefix remaining tables and functions with bma18_
      iio:bma180: Rename BMA_180 to BMA180_
      iio:bma180: Use bool instead of int for state
      iio:bma180: Expose temperature channel
      iio:bma180: Drop _update_scan_mode()
      iio:bma180: Introduce part_info to differentiate further chip variants
      iio:bma180: Introduce part-specific _config() and disable() code
      iio:bma180: Prepare for accelerometer channels with different resolutions
      iio:bma180: Implement _available sysfs attribute dynamically
      iio:bma180: Add BMA250 chip support

Sanjeev Sharma (1):
      iio: remove .owner field for driver using module_platform_driver

Srinivas Pandruvada (3):
      iio:gyro:bmg160 Gyro Sensor driver
      iio:gyro:bmg160 documentation
      iio: accel: kxcjk-1013: Support thresholds

Sören Brinkmann (1):
      staging: ad7606_core: Fix checkpatch warning

 .../ABI/testing/sysfs-bus-iio-gyro-bmg160          |    7 +
 .../bindings/iio/adc/rockchip-saradc.txt           |   24 +
 drivers/iio/accel/Kconfig                          |   13 +-
 drivers/iio/accel/bma180.c                         |  476 +++++---
 drivers/iio/accel/bmc150-accel.c                   |  241 +++-
 drivers/iio/accel/hid-sensor-accel-3d.c            |    1 -
 drivers/iio/accel/kxcjk-1013.c                     |  611 ++++++++--
 drivers/iio/adc/at91_adc.c                         |    2 +-
 drivers/iio/adc/exynos_adc.c                       |    1 -
 drivers/iio/adc/lp8788_adc.c                       |    1 -
 drivers/iio/adc/rockchip_saradc.c                  |    1 -
 drivers/iio/adc/ti_am335x_adc.c                    |    1 -
 drivers/iio/adc/twl4030-madc.c                     |    1 -
 drivers/iio/adc/twl6030-gpadc.c                    |    1 -
 drivers/iio/adc/vf610_adc.c                        |    1 -
 drivers/iio/adc/viperboard_adc.c                   |    1 -
 drivers/iio/common/st_sensors/st_sensors_core.c    |    5 +-
 drivers/iio/gyro/Kconfig                           |   11 +
 drivers/iio/gyro/Makefile                          |    1 +
 drivers/iio/gyro/bmg160.c                          | 1228 ++++++++++++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    1 -
 drivers/iio/humidity/dht11.c                       |    1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    3 +-
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/al3320a.c                        |  232 ++++
 drivers/iio/light/hid-sensor-als.c                 |    1 -
 drivers/iio/light/hid-sensor-prox.c                |    1 -
 drivers/iio/light/lm3533-als.c                     |    1 -
 drivers/iio/magnetometer/ak8975.c                  |   10 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    1 -
 drivers/iio/orientation/hid-sensor-incl-3d.c       |    1 -
 drivers/iio/orientation/hid-sensor-rotation.c      |    1 -
 drivers/iio/pressure/hid-sensor-press.c            |    1 -
 drivers/iio/trigger/iio-trig-interrupt.c           |    1 -
 drivers/staging/iio/adc/ad7606_core.c              |    2 +-
 drivers/staging/iio/light/isl29018.c               |  205 +++-
 37 files changed, 2763 insertions(+), 338 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
 create mode 100644 drivers/iio/gyro/bmg160.c
 create mode 100644 drivers/iio/light/al3320a.c
