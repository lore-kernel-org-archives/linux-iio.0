Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753001AbdHTPJr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 11:09:47 -0400
Date: Sun, 20 Aug 2017 16:09:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: [PULL] Second set of new device support, features and cleanups for
 IIO in the 4.14 cycle.
Message-ID: <20170820160943.4d707f89@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0d0d4d21a09981e65b2bd386c999e8c0ecc6444e:

  staging: fbtft: array underflow in fbtft_request_gpios_match() (2017-07-28 17:08:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.14b

for you to fetch changes up to 87587016f614e96d873f883609a0099e820172e8:

  iio: adc: rockchip_saradc: explicitly request exclusive reset control (2017-08-20 15:41:18 +0100)

----------------------------------------------------------------
Second set of IIO new device support, features and cleanup for the 4.14 cycle.

New device support:
* ak8974
  - support the AMI306.
* st_magnetometer
  - add support for the LIS2MDL with bindings.
* rockchip-saradc
  - add binding for rv1108 SoC (no driver change).
* srf08
  - add srf02 (i2c only) and srf10 support.
* stm32-timer
  - support for the STM32H7 to existing driver.

Features:
* tools
  - move over to the tools buildsystem rather than hand rolling.
  - add an install section to the build.
* ak8974
  - use serial number to add device randomness.
  - add AMI306 calibration data output.
* ccs811
  - triggered buffer support.
* srf08
  - add a device tree table as the old style i2c probing is going away,
  - add triggered buffer support
* st32-adc
  - add optional st,min-sample-time-nsecs binding to allow control of
    sampling against analog circuitry.
* stm32-timer
  - add output compare triggers.
* ti-ads1015
  - add threshold event support.
* ti-ads7950
  - Allow use on ACPI platforms including providing a default reference
    voltage as there is no way to obtain this on ACPI currently.

Cleanup and fixes:
* ad7606
  - fix an error return code in probe.
* ads1015
  - fix incorrect data rate setting update when capture in progress,
  - fix wrong scale information for the ADS1115,
  - make conversions work when CONFIG_PM is not set,
  - make sure we don't get a stale result after a runtime resume by
    ensuring we wait long enough,
  - avoid returning a false error form the buffer setup callbacks,
  - add enough wait time to get the correct conversion,
  - remove an unnecessary config register update,
  - add a helper to set conversion mode reducing repeated boilerplate,
  - use devm_iio_triggered_buffer_setup to simplify error and remove
    paths,
  - use iio_device_claim_direct_mode instead of opencoding the same.
* ak8974
  - mark the INT_CLEAR register as precious to prevent debugfs access.
* apds9300
  - constify the i2c_device_id.
* at91-sama5 adc
  - add missing Kconfig dependency.
* bma180 accel
  - constify the i2c_device_id.
* rockchip_saradc
  - explicitly request exclusive reset control as part of the reset rework
    on going throughout the kernel.
* st_accel
  - fix drdy configuration for a load of accelerometers that only have
    the int1 line.  Fix is unimportant as presumably no deviec tree actually
    used the non existent hardware line.
* st_pressure
  - fix drdy configuration for LPS22HB and LPS25H by dropping int2 support
    as they don't have this. Fix is unimportant as presumably no device tree
    actually used the non existent hardware line.
* stm32-dac
  - explicitly request exclusive reset control (part of reset being reworked).
* tsl2583
  - constify the i2c_device_id.
* xadc
  - coding style fixes.

----------------------------------------------------------------
Akinobu Mita (11):
      iio: adc: ti-ads1015: fix incorrect data rate setting update
      iio: adc: ti-ads1015: fix scale information for ADS1115
      iio: adc: ti-ads1015: enable conversion when CONFIG_PM is not set
      iio: adc: ti-ads1015: avoid getting stale result after runtime resume
      iio: adc: ti-ads1015: don't return invalid value from buffer setup callbacks
      iio: adc: ti-ads1015: add adequate wait time to get correct conversion
      iio: adc: ti-ads1015: remove unnecessary config register update
      iio: adc: ti-ads1015: add helper to set conversion mode
      iio: adc: ti-ads1015: use devm_iio_triggered_buffer_setup
      iio: adc: ti-ads1015: use iio_device_claim_direct_mode()
      iio: adc: ti-ads1015: add threshold event support

Andreas Klinger (4):
      iio: srf08: add device tree table
      iio: srf08: add triggered buffer support
      iio: srf08: add sensor type srf10
      iio: srf08: add support for srf02 in i2c mode

Andy Shevchenko (4):
      iio: adc: ti-ads7950: Add OF device ID table
      iio: tools: move to tools buildsystem
      iio: tools: add install section
      iio: adc: ti-ads7950: Allow to use on ACPI platforms

Andy Yan (1):
      dt-bindings: adc: add description for rv1108 saradc

Arnd Bergmann (1):
      iio: adc: select triggered buffer for sama5d2 adc

Arvind Yadav (3):
      iio: accel: bma180: constify i2c_device_id
      iio: light: apds9300: constify i2c_device_id
      iio: light: tsl2583: constify i2c_device_id

Fabrice Gasnier (5):
      dt-bindings: iio: adc: stm32: add optional st,min-sample-time-nsecs
      iio: adc: stm32: add optional st,min-sample-time-nsecs
      dt-bindings: iio: timer: stm32: add support for STM32H7
      iio: trigger: stm32-timer: add support for STM32H7
      iio: trigger: stm32-timer: add output compare triggers

Gustavo A. R. Silva (1):
      staging: iio: adc: fix error return code in ad7606_par_probe()

Lorenzo Bianconi (4):
      iio: pressure: st_pressure: fix drdy configuration for LPS22HB and LPS25H
      iio: accel: st_accel: fix data-ready line configuration
      iio: magnetometer: add support to LIS2MDL
      dt-bindings: iio: magn: add LIS2MDL sensor device binding

Michał Mirosław (4):
      iio: magnetometer: ak8974: support AMI306 variant
      iio: magnetometer: ak8974: add_device_randomness (serial number)
      iio: magnetometer: ak8974: mark INT_CLEAR as precious
      iio: magnetometer: ak8974: debug AMI306 calibration data

Narcisa Ana Maria Vasile (1):
      iio: chemical: ccs811: Add triggered buffer support

Philipp Zabel (2):
      iio: dac: stm32-dac-core: explicitly request exclusive reset control
      iio: adc: rockchip_saradc: explicitly request exclusive reset control

Sai Krishna Potthuri (1):
      iio: adc: xadc: Fix coding style violations

 .../bindings/iio/adc/rockchip-saradc.txt           |   1 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   5 +
 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 .../bindings/iio/timer/stm32-timer-trigger.txt     |   4 +-
 drivers/iio/accel/bma180.c                         |   2 +-
 drivers/iio/accel/st_accel_core.c                  |   4 +-
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/rockchip_saradc.c                  |   3 +-
 drivers/iio/adc/stm32-adc.c                        | 140 ++++-
 drivers/iio/adc/ti-ads1015.c                       | 595 +++++++++++++++++----
 drivers/iio/adc/ti-ads7950.c                       |  42 +-
 drivers/iio/adc/xilinx-xadc-events.c               |  38 +-
 drivers/iio/adc/xilinx-xadc.h                      |  10 +-
 drivers/iio/chemical/Kconfig                       |   2 +
 drivers/iio/chemical/ccs811.c                      |  76 ++-
 drivers/iio/dac/stm32-dac-core.c                   |   2 +-
 drivers/iio/light/apds9300.c                       |   2 +-
 drivers/iio/light/tsl2583.c                        |   2 +-
 drivers/iio/magnetometer/Kconfig                   |   4 +-
 drivers/iio/magnetometer/ak8974.c                  | 133 ++++-
 drivers/iio/magnetometer/st_magn.h                 |   1 +
 drivers/iio/magnetometer/st_magn_core.c            |   1 +
 drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
 drivers/iio/magnetometer/st_magn_spi.c             |   5 +
 drivers/iio/pressure/st_pressure_core.c            |   4 +-
 drivers/iio/proximity/Kconfig                      |   8 +-
 drivers/iio/proximity/srf08.c                      | 227 ++++++--
 drivers/iio/trigger/stm32-timer-trigger.c          |  78 ++-
 drivers/staging/iio/adc/ad7606_par.c               |   4 +-
 include/linux/iio/timer/stm32-timer-trigger.h      |  14 +
 tools/Makefile                                     |   6 +-
 tools/iio/Build                                    |   3 +
 tools/iio/Makefile                                 |  76 ++-
 33 files changed, 1268 insertions(+), 231 deletions(-)
 create mode 100644 tools/iio/Build
