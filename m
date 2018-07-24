Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388748AbeGXWFy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Jul 2018 18:05:54 -0400
Date: Tue, 24 Jul 2018 21:57:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: Second set of new device support, cleanups and features
 for the 4.19 cycle.
Message-ID: <20180724215731.71c540ff@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a98a5c27b54e01dd9c42e2b0addb543f0dc494cd:

  staging: rtl8188eu: remove whitespace - coding style (2018-06-28 22:46:01=
 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
4.19b

for you to fetch changes up to c5b974bee9d2ceae4c441ae5a01e498c2674e100:

  iio: sca3000: Fix missing return in switch (2018-07-24 18:17:18 +0100)

----------------------------------------------------------------
Second set of IIO new device support, features and cleanups.

There are also a couple of fixes that can wait for the coming merge
window.

Core new features

* Support for phase channels (used in time of flight sensors amongst
  other things)
* Support for deep UV light channel modifier.

New Device Support

* AD4758 DAC
  - New driver and dt bindings.
* adxl345
  - Support the adxl375 +-200g part which is register compatible.
* isl29501 Time of flight sensor.
  - New driver
* meson-saradc
  - Support the Meson8m2 Socs - right now this is just an ID, but there will
    be additional difference in future.
* mpu6050
  - New ID for 6515 variant.
* si1133 UV sensor.
  - New driver
* Spreadtrum SC27xx PMIC ADC
  - New driver and dt bindings.

Features

* adxl345
  - Add calibration offset readback and writing.
  - Add sampling frequency control.

Fixes and Cleanups

* ad5933
  - Use a macro for the channel definition to reduce duplication.
* ad9523
  - Replace use of core mlock with a local lock. Part of ongoing efforts
    to avoid confusing the purpose of mlock which is only about iio core
    state changes.
  - Fix displayed phase which was out by a factor of 10.
* adxl345
  - Add a link to the datasheet.
  - Rework the use of the address field in the chan_spec structures to
    allow addition of more per channel information.
* adis imu
  - Mark switch fall throughs.
* at91-sama5d2
  - Fix some casting on big endian systems.
* bmp280
  - Drop some DT elements that aren't used and should mostly be done from
    userspace rather than in DT.
* hx711
  - add clock-frequency dt binding and resulting delay to deal with capacit=
ance
    issue on some boards.
  - fix a spurious unit-address in the example.
* ina2xx
  - Avoid a possible kthread_stop with a stale task_struct.
* ltc2632
  - Remove some unused local variables (assigned but value never used).
* max1363
  - Use device_get_match_data to remove some boilerplate.
* mma8452
  - Mark switch fall throughs.
* sca3000
  - Fix a missing return in a switch statement (a bad fallthrough
    previously!)
* sigma-delta-modulator
  - Drop incorrect unit address from the DT example.
* st_accel
  - Use device_get_match_data to drop some boiler plate.
  - Move to probe_new for i2c driver as second parameter not used.
* st_sensors library
  - Use a strlcpy (safe in this case).
* st_lsm6dsx
  - Add some error logging.
* ti-ads7950
  - SPDX
  - Allow simultaneous buffered and polled reads. Needed on a Lego Mindstor=
ms
    EV3 where some channels are used for power supply monitoring at a very =
low
    rate.
* ti-dac5571
  - Remove an unused variable.
* xadc
  - Drop some dead code.

----------------------------------------------------------------
Akinobu Mita (5):
      iio: accel: adxl345: add link to datasheet
      iio: accel: adxl345: convert address field usage in iio_chan_spec
      iio: accel: adxl345: add calibration offset support
      iio: adc: ina2xx: avoid kthread_stop() with stale task_struct
      iio: accel: adxl345: add sampling frequency support

Andreas Klinger (3):
      iio: hx711: add clock-frequency property in DT
      iio: hx711: add delay until DOUT is ready
      iio: hx711: fix spurious unit-address in example

Baolin Wang (1):
      dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC controller document=
ation

Brian Masney (2):
      iio: imu: mpu6050: add support for 6515 variant
      iio: pressure: bmp280: remove unused options from device tree documen=
tation

Colin Ian King (2):
      iio: dac: ti-dac5571 remove redundant variable 'shift'
      iio: dac: ltc2632 remove redundant pointer chip_info and spi_dev_id

Dan Carpenter (1):
      iio: adc: at91-sama5d2_adc: fix up casting in at91_adc_read_info_raw()

David Lechner (2):
      iio: adc: ti-ads7950: use SPDX-License-Identifier
      iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode

Dominique Martinet (1):
      iio: change strncpy+truncation to strlcpy

Fabrice Gasnier (1):
      dt-bindings: iio: sigma-delta-modulator: fix unit-address in example

Freeman Liu (1):
      iio: adc: Add Spreadtrum SC27XX PMICs ADC support

Gustavo A. R. Silva (3):
      iio:imu:adis: Mark expected switch fall-throughs
      iio: mma8452: Mark expected switch fall-through
      iio: sca3000: Fix missing return in switch

Julia Lawall (1):
      iio: adc: max1363: merge calls to of_match_device and of_device_get_m=
atch_data

Karim Eshapa (1):
      staging:iio:impedance-analyzer:ad5933: Macro replacement Cleanups.

Lars-Peter Clausen (3):
      iio: adxl345: Add support for the ADXL375
      iio: ad9523: replace core mlock with local lock
      iio: ad9523: Fix displayed phase

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: add error logs to st_lsm6dsx_read_fifo()

Manish Narani (1):
      iio: adc: xilinx: Remove dead code from xadc_zynq_setup

Martin Blumenstingl (2):
      dt-bindings: iio: adc: add Meson8m2 support
      iio: adc: meson-saradc: add support for the Meson8m2 SoCs

Mathieu Othacehe (2):
      iio: Add channel for Phase
      iio: light: isl29501: Add support for the ISL29501 ToF sensor.

Maxime Roussin-B=C3=A9langer (2):
      iio: Add modifier for DUV light
      iio: light: introduce si1133

Nikolaus Voss (2):
      IIO: st_accel_i2c.c: Simplify access to driver data
      IIO: st_accel_i2c.c: Use probe_new() instead of probe()

Stefan Popa (2):
      iio: dac: Add AD5758 support
      dt-bindings: iio: dac: Add docs for AD5758 DAC

 Documentation/ABI/testing/sysfs-bus-iio            |   14 +-
 Documentation/ABI/testing/sysfs-bus-iio-isl29501   |   47 +
 .../ABI/testing/sysfs-bus-iio-light-si1133         |   22 +
 .../devicetree/bindings/iio/accel/adxl345.txt      |    7 +-
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |    1 +
 .../devicetree/bindings/iio/adc/avia-hx711.txt     |    8 +-
 .../bindings/iio/adc/sigma-delta-modulator.txt     |    2 +-
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 +
 .../devicetree/bindings/iio/dac/ad5758.txt         |   78 ++
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |    1 +
 .../devicetree/bindings/iio/light/isl29501.txt     |   13 +
 .../devicetree/bindings/iio/pressure/bmp085.txt    |    7 -
 MAINTAINERS                                        |    8 +
 drivers/iio/accel/Kconfig                          |    4 +-
 drivers/iio/accel/adxl345.h                        |    7 +-
 drivers/iio/accel/adxl345_core.c                   |  140 ++-
 drivers/iio/accel/adxl345_i2c.c                    |    7 +-
 drivers/iio/accel/adxl345_spi.c                    |    6 +-
 drivers/iio/accel/mma8452.c                        |    1 +
 drivers/iio/accel/sca3000.c                        |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |   64 +-
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 |    7 +-
 drivers/iio/adc/hx711.c                            |   39 +
 drivers/iio/adc/ina2xx-adc.c                       |   17 +-
 drivers/iio/adc/max1363.c                          |    8 +-
 drivers/iio/adc/meson_saradc.c                     |    9 +
 drivers/iio/adc/sc27xx_adc.c                       |  522 ++++++++++
 drivers/iio/adc/ti-ads7950.c                       |   43 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    4 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    3 +-
 drivers/iio/dac/Kconfig                            |   10 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5758.c                           |  897 ++++++++++++++++
 drivers/iio/dac/ltc2632.c                          |    5 -
 drivers/iio/dac/ti-dac5571.c                       |    6 -
 drivers/iio/frequency/ad9523.c                     |   36 +-
 drivers/iio/imu/adis.c                             |    3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    5 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   16 +-
 drivers/iio/industrialio-core.c                    |    2 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/si1133.c                         | 1068 ++++++++++++++++=
++++
 drivers/iio/pressure/st_pressure_i2c.c             |    3 +-
 drivers/iio/proximity/Kconfig                      |   13 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/isl29501.c                   | 1027 ++++++++++++++++=
+++
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   57 +-
 include/uapi/linux/iio/types.h                     |    2 +
 tools/iio/iio_event_monitor.c                      |    4 +
 54 files changed, 4139 insertions(+), 175 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-si1133
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-a=
dc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29501.txt
 create mode 100644 drivers/iio/adc/sc27xx_adc.c
 create mode 100644 drivers/iio/dac/ad5758.c
 create mode 100644 drivers/iio/light/si1133.c
 create mode 100644 drivers/iio/proximity/isl29501.c
