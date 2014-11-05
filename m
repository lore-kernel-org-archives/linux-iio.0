Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44969 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaKETN4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 14:13:56 -0500
Message-ID: <545A76F1.1040008@kernel.org>
Date: Wed, 05 Nov 2014 19:13:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First round of new IIO drivers, features and cleanups for
 the 3.19 cycle.
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 3f76a4ea5383ba2f9e76f9625f77ff246907a134:

  Staging: rtl8192e: Fix __constant_htons to htons style warning (2014-09-19 17:54:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.19a

for you to fetch changes up to 4e4cd14e7cbead5ca20465f4a7ce973d42434a2f:

  iio: Add ABI documentation for scaled voltage (2014-11-05 18:27:11 +0000)

----------------------------------------------------------------
First round of new drivers, features and cleanups for IIO in the 3.19 cycle.

New drivers / supported parts
* rockchip - rk3066-tsadc variant
* si7020 humidity and temperature sensor
* mcp320x - add mcp3001, mcp3002, mcp3004, mcp3008, mcp3201, mcp3202
* bmp280 pressure and temperature sensor
* Qualcomm SPMI PMIC current ADC driver
* Exynos_adc - support exynos7

New features
* vf610-adc - add temperature sensor support
* Documentation of current attributes, scaled pressure, offset and
  scaled humidity, RGBC intensity gain factor and scale applied to
  differential voltage channels.
* Bring iio_event_monitor up to date with newer modifiers.
* Add of_xlate function to allow for complex channel mappings from the
  device tree.
* Add -g parameter to generic_buffer example to allow for devices with
  directly fed (no trigger) buffers.
* Move exynos driver over to syscon for PMU register access.

Cleanups, fixes for new drivers
* lis3l02dq drop an unneeded else.
* st sensors - renam st_sensors to st_sensor_settings (for clarity)
* st sensors - drop an unused parameter from all the probe utility
  functions.
* vf610 better error handling and tidy up.
* si7020 - cleanups following merge
* as3935 - drop some unnecessary semicolons.
* bmp280 - fix the pressure calculation.

----------------------------------------------------------------
Abhilash Kesavan (1):
      iio: adc: exynos_adc: Add support for exynos7

Chris Ruffin (1):
      staging: iio: accel: remove unnecessary syntax

Darshana Padmadas (1):
      iio: Add ABI documentation for scaled voltage

David Barksdale (1):
      IIO: add si7020 driver

Denis CIOCCA (7):
      iio:imu: changed structure name from st_sensors to st_sensor_settings
      iio:accel: Removed unnecessary parameter on common_probe function
      iio:gyro: Removed unnecessary parameter on common_probe function
      iio:magnetometer: Removed unnecessary parameter on common_probe function
      iio:pressure: Removed unnecessary parameter on common_probe function
      iio:pressure: Changed pressure data variable name to press_data
      iio:common: Set the device pointer into ST common sensors library

Fabio Estevam (4):
      iio: adc: vf610: Return the error code directly
      iio: adc: vf610: Disable the regulator on error
      iio: adc: vf610: SIMPLE_DEV_PM_OPS can fit on a single line
      iio: adc: vf610: Propagate the real error when platform_get_irq() fails

George McCollister (1):
      iio: as3935: Remove unnecessary semicolons

Hartmut Knaack (3):
      iio:humidity:si7020: cleanup read_raw and probe
      iio:humidity:si7020: fix pointer to i2c client
      iio:pressure:bmp280: fix pressure calculation

Heiko Stübner (1):
      iio: adc: rockchip_saradc: add support for rk3066-tsadc variant

Ivan T. Ivanov (2):
      iio: inkern: Add of_xlate function to struct iio_info
      iio: iadc: Qualcomm SPMI PMIC current ADC driver

Jacob Pan (1):
      iio: add documentation for current attribute

Karol Wrona (1):
      staging: iio: Add notrigger mode for generic_buffer

Naveen Krishna Chatradhi (3):
      iio: exyno-adc: use syscon for PMU register access
      Documentation: dt-bindings: update exynos-adc.txt with syscon handle
      ARM: dts: exynos: Add sysreg phandle to ADC node

Roberta Dobrescu (3):
      iio: Add ABI documentation for offset and scaled humidity
      iio: Add ABI documentation for RGBC intensity hardware gain factor
      staging: iio: iio_event_monitor: Add support for missing IIO modifiers

Sanchayan Maity (1):
      iio:adc:vf610-adc: Add temperature sensor support

Søren Andersen (1):
      iio: adc: mcp320x. Add support for more ADCs

Vlad Dogaru (3):
      iio: add ABI documentation for scaled pressure
      iio: add bmp280 pressure and temperature driver
      bmp280: use correct routine for division

 Documentation/ABI/testing/sysfs-bus-iio            |  23 +
 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  11 +-
 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.txt |  46 ++
 .../bindings/iio/adc/rockchip-saradc.txt           |   2 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   3 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |   3 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   3 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   3 +-
 drivers/iio/accel/st_accel.h                       |   3 +-
 drivers/iio/accel/st_accel_core.c                  |  22 +-
 drivers/iio/accel/st_accel_i2c.c                   |   3 +-
 drivers/iio/accel/st_accel_spi.c                   |   3 +-
 drivers/iio/adc/Kconfig                            |  14 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/exynos_adc.c                       |  62 ++-
 drivers/iio/adc/mcp320x.c                          | 222 ++++++--
 drivers/iio/adc/qcom-spmi-iadc.c                   | 595 +++++++++++++++++++++
 drivers/iio/adc/rockchip_saradc.c                  |  64 ++-
 drivers/iio/adc/vf610_adc.c                        |  45 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    | 126 +++--
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   1 +
 drivers/iio/common/st_sensors/st_sensors_spi.c     |   1 +
 drivers/iio/gyro/st_gyro.h                         |   3 +-
 drivers/iio/gyro/st_gyro_core.c                    |  19 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   4 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   4 +-
 drivers/iio/humidity/Kconfig                       |  10 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/si7020.c                      | 161 ++++++
 drivers/iio/inkern.c                               |  33 +-
 drivers/iio/magnetometer/st_magn.h                 |   3 +-
 drivers/iio/magnetometer/st_magn_core.c            |  18 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |   3 +-
 drivers/iio/magnetometer/st_magn_spi.c             |   3 +-
 drivers/iio/pressure/Kconfig                       |  11 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/bmp280.c                      | 455 ++++++++++++++++
 drivers/iio/pressure/st_pressure.h                 |   3 +-
 drivers/iio/pressure/st_pressure_buffer.c          |  12 +-
 drivers/iio/pressure/st_pressure_core.c            |  49 +-
 drivers/iio/pressure/st_pressure_i2c.c             |  11 +-
 drivers/iio/pressure/st_pressure_spi.c             |  11 +-
 drivers/iio/proximity/as3935.c                     |  16 +-
 drivers/staging/iio/Documentation/generic_buffer.c |  77 +--
 .../staging/iio/Documentation/iio_event_monitor.c  |  32 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   5 +-
 include/linux/iio/common/st_sensors.h              |  10 +-
 include/linux/iio/iio.h                            |   8 +
 48 files changed, 1939 insertions(+), 280 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.txt
 create mode 100644 drivers/iio/adc/qcom-spmi-iadc.c
 create mode 100644 drivers/iio/humidity/si7020.c
 create mode 100644 drivers/iio/pressure/bmp280.c
