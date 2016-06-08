Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35880 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbcFHRk5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 13:40:57 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: [PULL] First round of IIO new device support, features and cleanups
 for the 4.8 cycle.
Message-ID: <73597afb-466a-caf7-4c8e-dd91318f2ac4@kernel.org>
Date: Wed, 8 Jun 2016 18:40:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit fbced0e9465152d628ece5fd0d11de4e7a1f5ce5:

  iio: inv_mpu6050: Add explicit support for MPU9150 (2016-04-25 20:19:38 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

for you to fetch changes up to bc2e1126eccb47517b9d1c685020c38600f99a3d:

  iio:trigger: Experimental kthread tight loop trigger (thread only) (2016-06-03 13:18:44 +0100)

----------------------------------------------------------------
Alison Schofield (8):
      iio: light: jsa1212: remove unneeded i2c check functionality test
      iio: adc: ad7266: claim direct mode during sensor read
      iio: adc: ad7476: use iio helper function to guarantee direct mode
      iio: adc: ad7887: use iio helper function to guarantee direct mode
      iio: adc: ad7923: use iio helper function to guarantee direct mode
      iio: adc: ad799x: use iio helper function to guarantee direct mode
      iio: adc: ad7793: claim direct mode when writing frequency
      iio: adc: ad7791: claim direct mode when writing frequency

Andrew F. Davis (15):
      iio: health/afe440x: Fix kernel-doc format
      iio: health/afe440x: Remove of_match_ptr and ifdefs
      iio: health/afe440x: Remove unneeded initializers
      iio: health/afe440x: Always use separate gain values
      iio: health/afe440x: Fix scan_index assignment
      iio: health/afe440x: Remove unneeded offset handling
      iio: health/afe4404: Remove LED3 input channel
      iio: health/afe440x: Remove channel names
      iio: health/afe440x: Use regmap fields
      iio: health/afe440x: Make gain settings a modifier for the stages
      iio: health/afe440x: Match LED currents to stages
      iio: health/afe440x: Remove unused definitions
      iio: health/afe4404: ENSEPGAIN is part of CONTROL2 register
      iio: adc: ti_am335x_adc: use variable names for sizeof() operator
      iio: adc: ti_am335x_adc: use SIMPLE_DEV_PM_OPS helper macro

Constantin Musca (1):
      iio: accel: Add support for Freescale MMA7660FC

Crestez Dan Leonard (4):
      iio: ak8975: Support adapters limited to BYTE_DATA
      iio: iio_generic_buffer: Cleanup when receiving signals
      iio: iio_generic_buffer: Add --device-num option
      iio: iio_generic_buffer: Add --trigger-num option

Cristina Moraru (1):
      iio: max5487: Add support for Maxim digital potentiometers

Daniel Baluta (7):
      imu: bmi160: Add avail frequency and scale attributes
      iio: Add support for creating IIO devices via configfs
      iio: dummy: Convert IIO dummy to configfs
      Documentation: iio: Add IIO software devices docs
      iio: magn: Add support for BMM150 magnetometer
      tools: iio: Rename generic_buffer to iio_generic_buffer
      iio: magnetometer: bmc150: Document Bosch supported chips

Geert Uytterhoeven (2):
      MAINTAINERS: Add file patterns for iio device tree bindings
      MAINTAINERS: Add file patterns for staging iio device tree bindings

Gregor Boirie (4):
      iio:st_pressure:initial lps22hb sensor support
      iio:st_sensors: unexport st_sensors_get_buffer_element
      iio:st_sensors: emulate SMBus block read if needed
      iio:st_sensors: fix power regulator usage

Javier Martinez Canillas (1):
      iio: Export I2C module alias information

Jonathan Cameron (2):
      iio: triggers: Make trigger ops structure explicitly non optional.
      iio:trigger: Experimental kthread tight loop trigger (thread only)

Martin Kepplinger (1):
      iio: mma8452: add support for oversampling ratio

Matt Ranostay (8):
      iio: potentiometer: tpl0102: remove unneeded i2c check functionality test
      iio: adc: ti-ads1015: add support for ADS1115 part
      iio: pressure: bmp280: add humidity support
      iio: adc: ti-ads1015: add datasheet names
      iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips
      iio: electricalconductivity: add IIO_ELECTRICALCONDUCTIVITY type
      iio: chemical: atlas-ph-sensor: add EC feature
      iio: proximity: as3935: remove redundant MODULE_ALIAS

Peter Robinson (1):
      tools: iio: Add ability to install/uninstall

Quentin Schulz (1):
      iio: adc: nau7802: Expose possible gains in sysfs

Stefan Wahren (3):
      iio: mxs-lradc: simplify TS registration
      iio: mxs-lradc: remove mxs_lradc_ts_unregister
      iio: mxs-lradc: disable only masked channels in mxs_lradc_hw_stop

Tiberiu Breana (2):
      iio: accel: Add support for Bosch BMA220
      iio: accel: Add triggered buffer support for BMA220

 Documentation/ABI/testing/configfs-iio             |  13 +
 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../ABI/testing/sysfs-bus-iio-health-afe440x       |  63 ++--
 .../bindings/iio/chemical/atlas,ec-sm.txt          |  22 ++
 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 MAINTAINERS                                        |   2 +
 drivers/iio/Kconfig                                |   8 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/Kconfig                          |  20 ++
 drivers/iio/accel/Makefile                         |   3 +
 drivers/iio/accel/bma220_spi.c                     | 338 +++++++++++++++++++++
 drivers/iio/accel/mma7660.c                        | 277 +++++++++++++++++
 drivers/iio/accel/mma8452.c                        | 185 +++++++++--
 drivers/iio/accel/st_accel_core.c                  |  12 +-
 drivers/iio/adc/ad7266.c                           |   7 +-
 drivers/iio/adc/ad7476.c                           |  11 +-
 drivers/iio/adc/ad7791.c                           |  36 +--
 drivers/iio/adc/ad7793.c                           |  32 +-
 drivers/iio/adc/ad7887.c                           |  11 +-
 drivers/iio/adc/ad7923.c                           |  11 +-
 drivers/iio/adc/ad799x.c                           |  24 +-
 drivers/iio/adc/mxs-lradc.c                        |  34 +--
 drivers/iio/adc/nau7802.c                          |  19 ++
 drivers/iio/adc/ti-ads1015.c                       | 128 +++++++-
 drivers/iio/adc/ti_am335x_adc.c                    |  22 +-
 drivers/iio/chemical/Kconfig                       |   8 +-
 drivers/iio/chemical/atlas-ph-sensor.c             | 267 ++++++++++++----
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |   3 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  29 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   4 +-
 drivers/iio/dummy/Kconfig                          |   1 +
 drivers/iio/dummy/iio_simple_dummy.c               | 102 +++----
 drivers/iio/gyro/st_gyro_core.c                    |  12 +-
 drivers/iio/health/afe4403.c                       | 299 +++++++-----------
 drivers/iio/health/afe4404.c                       | 308 ++++++++-----------
 drivers/iio/health/afe440x.h                       |  48 +--
 drivers/iio/humidity/am2315.c                      |   1 +
 drivers/iio/humidity/htu21.c                       |   1 +
 drivers/iio/imu/bmi160/bmi160_core.c               |  27 ++
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/industrialio-sw-device.c               | 182 +++++++++++
 drivers/iio/industrialio-trigger.c                 |  13 +-
 drivers/iio/light/jsa1212.c                        |   3 -
 drivers/iio/magnetometer/Kconfig                   |   2 +
 drivers/iio/magnetometer/ak8975.c                  |  20 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |   3 +
 drivers/iio/magnetometer/bmc150_magn_spi.c         |   3 +
 drivers/iio/magnetometer/st_magn_core.c            |  12 +-
 drivers/iio/potentiometer/Kconfig                  |  11 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/max5487.c                | 161 ++++++++++
 drivers/iio/potentiometer/tpl0102.c                |   4 -
 drivers/iio/pressure/Kconfig                       |   5 +-
 drivers/iio/pressure/bmp280.c                      | 200 +++++++++++-
 drivers/iio/pressure/hp206c.c                      |   1 +
 drivers/iio/pressure/ms5637.c                      |   1 +
 drivers/iio/pressure/st_pressure.h                 |   1 +
 drivers/iio/pressure/st_pressure_core.c            | 105 ++++++-
 drivers/iio/pressure/st_pressure_i2c.c             |   4 +
 drivers/iio/pressure/st_pressure_spi.c             |   1 +
 drivers/iio/proximity/as3935.c                     |   1 -
 drivers/iio/temperature/tsys02d.c                  |   1 +
 drivers/iio/trigger/Kconfig                        |  12 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/iio-trig-loop.c                | 143 +++++++++
 include/linux/iio/common/st_sensors.h              |   4 +-
 include/linux/iio/sw_device.h                      |  70 +++++
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/Makefile                                 |  21 +-
 .../iio/{generic_buffer.c => iio_generic_buffer.c} | 261 +++++++++++-----
 70 files changed, 2780 insertions(+), 866 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
 create mode 100644 drivers/iio/accel/bma220_spi.c
 create mode 100644 drivers/iio/accel/mma7660.c
 create mode 100644 drivers/iio/industrialio-sw-device.c
 create mode 100644 drivers/iio/potentiometer/max5487.c
 create mode 100644 drivers/iio/trigger/iio-trig-loop.c
 create mode 100644 include/linux/iio/sw_device.h
 rename tools/iio/{generic_buffer.c => iio_generic_buffer.c} (76%)
The following changes since commit fbced0e9465152d628ece5fd0d11de4e7a1f5ce5:

  iio: inv_mpu6050: Add explicit support for MPU9150 (2016-04-25 20:19:38 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

for you to fetch changes up to bc2e1126eccb47517b9d1c685020c38600f99a3d:

  iio:trigger: Experimental kthread tight loop trigger (thread only) (2016-06-03 13:18:44 +0100)

----------------------------------------------------------------
Alison Schofield (8):
      iio: light: jsa1212: remove unneeded i2c check functionality test
      iio: adc: ad7266: claim direct mode during sensor read
      iio: adc: ad7476: use iio helper function to guarantee direct mode
      iio: adc: ad7887: use iio helper function to guarantee direct mode
      iio: adc: ad7923: use iio helper function to guarantee direct mode
      iio: adc: ad799x: use iio helper function to guarantee direct mode
      iio: adc: ad7793: claim direct mode when writing frequency
      iio: adc: ad7791: claim direct mode when writing frequency

Andrew F. Davis (15):
      iio: health/afe440x: Fix kernel-doc format
      iio: health/afe440x: Remove of_match_ptr and ifdefs
      iio: health/afe440x: Remove unneeded initializers
      iio: health/afe440x: Always use separate gain values
      iio: health/afe440x: Fix scan_index assignment
      iio: health/afe440x: Remove unneeded offset handling
      iio: health/afe4404: Remove LED3 input channel
      iio: health/afe440x: Remove channel names
      iio: health/afe440x: Use regmap fields
      iio: health/afe440x: Make gain settings a modifier for the stages
      iio: health/afe440x: Match LED currents to stages
      iio: health/afe440x: Remove unused definitions
      iio: health/afe4404: ENSEPGAIN is part of CONTROL2 register
      iio: adc: ti_am335x_adc: use variable names for sizeof() operator
      iio: adc: ti_am335x_adc: use SIMPLE_DEV_PM_OPS helper macro

Constantin Musca (1):
      iio: accel: Add support for Freescale MMA7660FC

Crestez Dan Leonard (4):
      iio: ak8975: Support adapters limited to BYTE_DATA
      iio: iio_generic_buffer: Cleanup when receiving signals
      iio: iio_generic_buffer: Add --device-num option
      iio: iio_generic_buffer: Add --trigger-num option

Cristina Moraru (1):
      iio: max5487: Add support for Maxim digital potentiometers

Daniel Baluta (7):
      imu: bmi160: Add avail frequency and scale attributes
      iio: Add support for creating IIO devices via configfs
      iio: dummy: Convert IIO dummy to configfs
      Documentation: iio: Add IIO software devices docs
      iio: magn: Add support for BMM150 magnetometer
      tools: iio: Rename generic_buffer to iio_generic_buffer
      iio: magnetometer: bmc150: Document Bosch supported chips

Geert Uytterhoeven (2):
      MAINTAINERS: Add file patterns for iio device tree bindings
      MAINTAINERS: Add file patterns for staging iio device tree bindings

Gregor Boirie (4):
      iio:st_pressure:initial lps22hb sensor support
      iio:st_sensors: unexport st_sensors_get_buffer_element
      iio:st_sensors: emulate SMBus block read if needed
      iio:st_sensors: fix power regulator usage

Javier Martinez Canillas (1):
      iio: Export I2C module alias information

Jonathan Cameron (2):
      iio: triggers: Make trigger ops structure explicitly non optional.
      iio:trigger: Experimental kthread tight loop trigger (thread only)

Martin Kepplinger (1):
      iio: mma8452: add support for oversampling ratio

Matt Ranostay (8):
      iio: potentiometer: tpl0102: remove unneeded i2c check functionality test
      iio: adc: ti-ads1015: add support for ADS1115 part
      iio: pressure: bmp280: add humidity support
      iio: adc: ti-ads1015: add datasheet names
      iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips
      iio: electricalconductivity: add IIO_ELECTRICALCONDUCTIVITY type
      iio: chemical: atlas-ph-sensor: add EC feature
      iio: proximity: as3935: remove redundant MODULE_ALIAS

Peter Robinson (1):
      tools: iio: Add ability to install/uninstall

Quentin Schulz (1):
      iio: adc: nau7802: Expose possible gains in sysfs

Stefan Wahren (3):
      iio: mxs-lradc: simplify TS registration
      iio: mxs-lradc: remove mxs_lradc_ts_unregister
      iio: mxs-lradc: disable only masked channels in mxs_lradc_hw_stop

Tiberiu Breana (2):
      iio: accel: Add support for Bosch BMA220
      iio: accel: Add triggered buffer support for BMA220

 Documentation/ABI/testing/configfs-iio             |  13 +
 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../ABI/testing/sysfs-bus-iio-health-afe440x       |  63 ++--
 .../bindings/iio/chemical/atlas,ec-sm.txt          |  22 ++
 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 MAINTAINERS                                        |   2 +
 drivers/iio/Kconfig                                |   8 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/Kconfig                          |  20 ++
 drivers/iio/accel/Makefile                         |   3 +
 drivers/iio/accel/bma220_spi.c                     | 338 +++++++++++++++++++++
 drivers/iio/accel/mma7660.c                        | 277 +++++++++++++++++
 drivers/iio/accel/mma8452.c                        | 185 +++++++++--
 drivers/iio/accel/st_accel_core.c                  |  12 +-
 drivers/iio/adc/ad7266.c                           |   7 +-
 drivers/iio/adc/ad7476.c                           |  11 +-
 drivers/iio/adc/ad7791.c                           |  36 +--
 drivers/iio/adc/ad7793.c                           |  32 +-
 drivers/iio/adc/ad7887.c                           |  11 +-
 drivers/iio/adc/ad7923.c                           |  11 +-
 drivers/iio/adc/ad799x.c                           |  24 +-
 drivers/iio/adc/mxs-lradc.c                        |  34 +--
 drivers/iio/adc/nau7802.c                          |  19 ++
 drivers/iio/adc/ti-ads1015.c                       | 128 +++++++-
 drivers/iio/adc/ti_am335x_adc.c                    |  22 +-
 drivers/iio/chemical/Kconfig                       |   8 +-
 drivers/iio/chemical/atlas-ph-sensor.c             | 267 ++++++++++++----
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |   3 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  29 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   4 +-
 drivers/iio/dummy/Kconfig                          |   1 +
 drivers/iio/dummy/iio_simple_dummy.c               | 102 +++----
 drivers/iio/gyro/st_gyro_core.c                    |  12 +-
 drivers/iio/health/afe4403.c                       | 299 +++++++-----------
 drivers/iio/health/afe4404.c                       | 308 ++++++++-----------
 drivers/iio/health/afe440x.h                       |  48 +--
 drivers/iio/humidity/am2315.c                      |   1 +
 drivers/iio/humidity/htu21.c                       |   1 +
 drivers/iio/imu/bmi160/bmi160_core.c               |  27 ++
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/industrialio-sw-device.c               | 182 +++++++++++
 drivers/iio/industrialio-trigger.c                 |  13 +-
 drivers/iio/light/jsa1212.c                        |   3 -
 drivers/iio/magnetometer/Kconfig                   |   2 +
 drivers/iio/magnetometer/ak8975.c                  |  20 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |   3 +
 drivers/iio/magnetometer/bmc150_magn_spi.c         |   3 +
 drivers/iio/magnetometer/st_magn_core.c            |  12 +-
 drivers/iio/potentiometer/Kconfig                  |  11 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/max5487.c                | 161 ++++++++++
 drivers/iio/potentiometer/tpl0102.c                |   4 -
 drivers/iio/pressure/Kconfig                       |   5 +-
 drivers/iio/pressure/bmp280.c                      | 200 +++++++++++-
 drivers/iio/pressure/hp206c.c                      |   1 +
 drivers/iio/pressure/ms5637.c                      |   1 +
 drivers/iio/pressure/st_pressure.h                 |   1 +
 drivers/iio/pressure/st_pressure_core.c            | 105 ++++++-
 drivers/iio/pressure/st_pressure_i2c.c             |   4 +
 drivers/iio/pressure/st_pressure_spi.c             |   1 +
 drivers/iio/proximity/as3935.c                     |   1 -
 drivers/iio/temperature/tsys02d.c                  |   1 +
 drivers/iio/trigger/Kconfig                        |  12 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/iio-trig-loop.c                | 143 +++++++++
 include/linux/iio/common/st_sensors.h              |   4 +-
 include/linux/iio/sw_device.h                      |  70 +++++
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/Makefile                                 |  21 +-
 .../iio/{generic_buffer.c => iio_generic_buffer.c} | 261 +++++++++++-----
 70 files changed, 2780 insertions(+), 866 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
 create mode 100644 drivers/iio/accel/bma220_spi.c
 create mode 100644 drivers/iio/accel/mma7660.c
 create mode 100644 drivers/iio/industrialio-sw-device.c
 create mode 100644 drivers/iio/potentiometer/max5487.c
 create mode 100644 drivers/iio/trigger/iio-trig-loop.c
 create mode 100644 include/linux/iio/sw_device.h
 rename tools/iio/{generic_buffer.c => iio_generic_buffer.c} (76%)
