Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58376 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbbAaOOK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Jan 2015 09:14:10 -0500
Message-ID: <54CCE32C.1010205@kernel.org>
Date: Sat, 31 Jan 2015 14:14:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second round of new IIO drivers, features and cleanups for
 the 3.20 cycle
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 3ec698816ab3a7aca39dd3389115840a48d5266d:

  staging: nvec: specify a platform-device base id (2015-01-21 10:31:09 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.20b

for you to fetch changes up to 67460e8c9a5c59f66e1d476fd9341086cd792e5a:

  iio:common:ssp_sensors fix warnings due to 32 bit instead of 64 bit passed to do_div (2015-01-31 09:41:14 +0000)

----------------------------------------------------------------
Second round of IIO new drivers, functionality and cleanups for the 3.20 cycle.

New drivers and device support:
* Capella cm3232 ambient light sensor driver.
* Freescale MMA9553 pedometer and activity monitor. Note this involved a
  refactor of the mma9551 driver to pull out shared elements.
* Samsung sensor hub (as used in the galaxy gear 2 watch) Core support
  and initial drivers (gyro and accelerometer) more to follow.
  An additional fix was applied on top of this for a build issue
  thrown up by the autobuilders on some platforms.
* Cosmic Circuits 10001 ADC driver
* Qualcomm SPMI PMIC voltage ADC driver (current adc merged a while back).
* Add binding for AK8963 (in capitals) as unfortunately there are bios'
  out there not using lower case.

New functionality
* Add newe operating mode to the core to allow for non triggered software
  buffers.  This is mostly semantics as previously drivers just claimed they
  had a hardware buffer (when they didn't).
* Add distance channel type.
* Add energy channel type.
* Add velocity channel type and IIO_MOD_ROOT_SUM_SQUARED (i.e. speed when
  our channel type is velocity).
* Add _debounce_count and _debounce_time filter attributes.  Only really
  make sense for counting types of measurements.  First use is for avoiding
  miss detection of steps prior to walking.
* Add change event type.   This replaces the briefly present INSTANCE type
  (which hadn't gained any users).  It is more generic as it allows for
  events say every 10 steps rather than every step.
* Add _calibweight attributes to the ABI (and core support).  Used by
  activity monitors to estimate energy use.  Can imagine there will be
  other uses for this one.

Driver new functionality
* mma9551 gains runtime pm support.
* hid-sensors gain PM support.

Cleanup
* Change calibheight unit to m from cm.  As there are no prior users
  and this was inconsistent with other distance units, it makes sense
  to fix it before hte mma9553 driver which uses it.
* mpu6050 cleanups and devm_ use.
* as3935 switch over to PM ops.
* Fix a few format strings for signed vs unsigned.
* Fix tcs3414 missindentation
* Typo in industrialio-event
* Stop requiring IIO_TRIGGER for IIO_KFIFO_BUF as we have drivers that don't
  need it. No one is quite sure why that dependency was there and it
  seems to not matter.

----------------------------------------------------------------
Asaf Vertz (3):
      staging: iio: tsl2583: fix format string warnings
      staging: iio: ad5933: fix format string warnings
      staging: iio: tsl2x7x_core: fix format string warnings

Ezequiel Garcia (1):
      DT: Add a vendor prefix for Cosmic Circuits

Irina Tirdea (11):
      iio: core: Introduce ENERGY channel type
      iio: core: Introduce DISTANCE channel type
      iio: core: Introduce IIO_VELOCITY and IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z
      iio: core: Introduce IIO_CHAN_INFO_CALIBWEIGHT
      iio: core: Introduce CHANGE event type
      iio: core: Remove IIO_EV_TYPE_INSTANCE
      iio: accel: mma9551: Add runtime pm support
      iio: accel: mma9551: split driver to expose mma955x api
      iio: core: Introduce IIO_CHAN_INFO_DEBOUNCE_COUNT and _TIME
      iio: Documentation: Fix calibheight unit
      iio: add driver for Freescale MMA9553

Jonathan Cameron (1):
      iio:common:ssp_sensors fix warnings due to 32 bit instead of 64 bit passed to do_div

Karol Wrona (7):
      iio: Deselect IIO_TRIGGER for IIO_KFIFO_BUF
      iio: Add new operating mode for non triggered sw buffers
      iio: common: ssp_sensors: Add sensorhub driver
      iio: sensorhub: Add sensorhub bindings
      iio: common: ssp_sensors: Add sensorhub iio commons
      iio: common: ssp_sensors: Add sensorhub accelerometer sensor
      iio: common: ssp_sensors: Add sensorhub gyroscope sensor

Kevin Tsai (1):
      iio: Added Capella cm3232 ambient light sensor driver.

Lars-Peter Clausen (1):
      iio: as3935: Switch to PM ops

Phani Movva (2):
      DT: iio: adc: Add CC_10001 binding documentation
      iio: adc: Cosmic Circuits 10001 ADC driver

Roberta Dobrescu (3):
      iio: industrialio-event: Fix typo 's/dynically/dynamically/'
      iio: light: tcs3414: Fix misindented lines
      iio: light: cm32181: Fix typo 's/claibscale/calibscale/'

Srinivas Pandruvada (9):
      iio: hid_sensor_hub: Common PM functions
      iio: hid-sensor-accel-3d: Introduce PM
      iio: hid-sensor-gyro-3d: Introduce PM
      iio: hid-sensor-als: Introduce PM
      iio: hid-sensor-prox: Introduce PM
      iio: hid-sensor-magn-3d: Introduce PM
      iio: hid-sensor-incl-3d: Introduce PM
      iio: hid-sensor-press: Introduce PM
      iio: magnetometer: ak8975: Add AK8963

Stanimir Varbanov (2):
      DT: iio: vadc: document dt binding
      iio: vadc: Qualcomm SPMI PMIC voltage ADC driver

Varka Bhadram (3):
      imu: inv_mpu6050: use devm_iio_trigger_alloc
      imu: inv_mpu6050: use devm_request_irq
      imu: inv_mpu6050: cleanup on error check

 Documentation/ABI/testing/sysfs-bus-iio            |  123 +-
 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../devicetree/bindings/iio/adc/cc10001_adc.txt    |   22 +
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  129 ++
 .../devicetree/bindings/iio/sensorhub.txt          |   25 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    6 +
 drivers/iio/Kconfig                                |    1 -
 drivers/iio/accel/Kconfig                          |   15 +
 drivers/iio/accel/Makefile                         |    7 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |    8 +-
 drivers/iio/accel/mma9551.c                        |  489 ++-----
 drivers/iio/accel/mma9551_core.c                   |  798 ++++++++++++
 drivers/iio/accel/mma9551_core.h                   |   81 ++
 drivers/iio/accel/mma9553.c                        | 1334 ++++++++++++++++++++
 drivers/iio/accel/ssp_accel_sensor.c               |  169 +++
 drivers/iio/adc/Kconfig                            |   25 +
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/cc10001_adc.c                      |  423 +++++++
 drivers/iio/adc/qcom-spmi-vadc.c                   | 1016 +++++++++++++++
 drivers/iio/common/Kconfig                         |    1 +
 drivers/iio/common/Makefile                        |    1 +
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   75 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |    5 +
 drivers/iio/common/ssp_sensors/Kconfig             |   26 +
 drivers/iio/common/ssp_sensors/Makefile            |    8 +
 drivers/iio/common/ssp_sensors/ssp.h               |  257 ++++
 drivers/iio/common/ssp_sensors/ssp_dev.c           |  712 +++++++++++
 drivers/iio/common/ssp_sensors/ssp_iio.c           |  107 ++
 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h    |   71 ++
 drivers/iio/common/ssp_sensors/ssp_spi.c           |  608 +++++++++
 drivers/iio/gyro/Makefile                          |    2 +
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    8 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |  168 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   39 +-
 drivers/iio/industrialio-buffer.c                  |    2 +
 drivers/iio/industrialio-core.c                    |    7 +
 drivers/iio/industrialio-event.c                   |    4 +-
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/cm32181.c                        |    2 +-
 drivers/iio/light/cm3232.c                         |  403 ++++++
 drivers/iio/light/hid-sensor-als.c                 |    9 +-
 drivers/iio/light/hid-sensor-prox.c                |   10 +-
 drivers/iio/light/tcs3414.c                        |    4 +-
 drivers/iio/magnetometer/ak8975.c                  |    1 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    9 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |    9 +-
 drivers/iio/pressure/hid-sensor-press.c            |    9 +-
 drivers/iio/proximity/as3935.c                     |   18 +-
 .../staging/iio/Documentation/iio_event_monitor.c  |    4 +-
 drivers/staging/iio/iio_simple_dummy.c             |    2 +-
 drivers/staging/iio/iio_simple_dummy_events.c      |    4 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    4 +-
 drivers/staging/iio/light/tsl2583.c                |    2 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |    2 +-
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  119 ++
 include/linux/iio/common/ssp_sensors.h             |   82 ++
 include/linux/iio/iio.h                            |    9 +-
 include/linux/iio/types.h                          |    6 +-
 60 files changed, 6977 insertions(+), 519 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/sensorhub.txt
 create mode 100644 drivers/iio/accel/mma9551_core.c
 create mode 100644 drivers/iio/accel/mma9551_core.h
 create mode 100644 drivers/iio/accel/mma9553.c
 create mode 100644 drivers/iio/accel/ssp_accel_sensor.c
 create mode 100644 drivers/iio/adc/cc10001_adc.c
 create mode 100644 drivers/iio/adc/qcom-spmi-vadc.c
 create mode 100644 drivers/iio/common/ssp_sensors/Kconfig
 create mode 100644 drivers/iio/common/ssp_sensors/Makefile
 create mode 100644 drivers/iio/common/ssp_sensors/ssp.h
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_dev.c
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio.c
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
 create mode 100644 drivers/iio/common/ssp_sensors/ssp_spi.c
 create mode 100644 drivers/iio/gyro/ssp_gyro_sensor.c
 create mode 100644 drivers/iio/light/cm3232.c
 create mode 100644 include/dt-bindings/iio/qcom,spmi-vadc.h
 create mode 100644 include/linux/iio/common/ssp_sensors.h
