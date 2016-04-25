Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43233 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbcDYU7l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 16:59:41 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of new drivers, features and cleanups for IIO in
 the 4.7 cycle
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b6cab6bb-240d-5db1-0a38-1758ebfc8a21@kernel.org>
Date: Mon, 25 Apr 2016 21:59:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 148e45dc87cb76ba89e80da264bc692cc91a5149:

  staging: vme: fix bare use of 'unsigned' (2016-04-04 12:41:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.7b

for you to fetch changes up to fbced0e9465152d628ece5fd0d11de4e7a1f5ce5:

  iio: inv_mpu6050: Add explicit support for MPU9150 (2016-04-25 20:19:38 +0100)

----------------------------------------------------------------
2nd set of new device support, features and cleanup for IIO in the 4.7 cycle.

Bit of a bumper set for new drivers but plenty of other stuff here as well!

New device support
* ad5592R ADC/DAC
  - new driver supporting ad5592r and ad5593r combined ADC/DAC and gpio chips.
* Aosong am2315 relative humidity
  - new driver with triggered buffer support in follow up patch.
* bmi160 imu
  - new driver
* bmp280
  - bmp180 support - note there is support in the misc/bmp085 driver. Intent
    is to remove that driver long term.
* invensense mpu6050
  - cleanup leading to explicit support of mpu9150 with a good few cleanups
    along the way.
* Hope RF hp03 pressure and temperature sensor.
  - new driver
* maxim DS1803 potentiometer
  - new driver
* maxim max44000 light and proximity sensor
  - new driver built in a series of steps to support pretty much everything.
* ROHM BH1780 light sensor
  - new driver. There is an existing driver in misc that this is pretty much
    intended to replace.  The discussion on whether to support the non standard
    interface of that driver is some way is continuing.
* st-gyro
  - lsm9ds0-gyro.  The accel/magn side of this will take a while longer as
    extensions to the st library are needed for cases where two types of sensor
    share a single i2c address.
* ti-adc081c
  - support the adc101c and adc121c
* Vishay VEML6070 UV sensor
  - new driver.

New features
* core
  - devm_ APIs for channel_get and channel_get_all.  The first user of these
    is the generic ADC based thermal driver.  As it is going through the
    thermal tree these will be picked up as a patch to that next cycle as that
    is how the author preferred to do it.
  - mounting matrix support.  This new core support allows devices to provide
    to userspace (typically from the device tree) allowing compensation for how
    the sensor is mounted on the device.  First examples are on UAVs but it
    has a more mundane use on typical phone where the chip may be on the front
    or the back of the circuit board and soldered at any angle. Includes
    support for this ABI in ak8975 (which has an older interface, now
    deprecated) and mpu6050.
* tools
  - add a -a option to enable all available channels in generic_buffer sample.
    Makes it somewhat easier to use.
* adis library and drivers
  - support manual self test flag clearing.  This has technically been broken
    for a very long time - result is an offset on readings as the applied field
    is on all the time.
* ak8975
  - triggered buffer support
* bmc150
  - spi support (including splitting the driver into core and i2c parts)
* bmp280
  - oversampling support.
* dht11
  - improved logging - useful to debug timing issues on this quirky device.
* st-sensors
  - read each channel invidivually as not all support the optimization of
  reading in bulk.  This is technically a fix, but will need to be backported
  if desired.
  - support open drain and shared interrupts.
* ti-adc081c
  - triggered buffer support.

Cleanups
* inkern
  - white space fix.
* ad7606
  - use the iio_device_claim_direct_mode call rather than open coding equiv.
* ad799x
  - white space fix.
* ad9523
  - unsigned -> unsigned int
* apds9660
  - brace location tidying up.
  - silence an uninitialized variable warning.
* ak8975
  - else and brace on same line fix.
* at91_adc
  - white space fixes.
* bmc150
  - use regmap stored copy of the device pointer rather than having an
    additional copy.
* bmg160
  - use regmap stored copy of the device pointer rather than having an
    additional copy.
* hid-sensors
  - white space fixes.
* mcp3422
  - white space fix.
* mma7455
  - use regmap to retrieve the device struct rather than carrying another copy
    in the private data.
* ms_sensors
  - white space fix.
* mxs-lradc
  - move current bindings out of staging - some will be shortly deprecated but
    the reality is that we have device trees out there using them so they will
    need to be supported for some time.  They accidentally got left behind
    when the driver graduated from staging.
  - white space cleanup.
  - set INPUT_PROP_DIRECT.
  - move ts config into a better function.
  - move the STMP reset out of the ADC init.
* vf610_adc
  - case label indenting fix.

----------------------------------------------------------------
Akinobu Mita (2):
      iio: pressure: bmp280: add support for BMP180
      iio: pressure: bmp280: add ability to control oversampling rate

Alison Schofield (4):
      iio: accel: mma7455: use regmap to retrieve struct device
      staging: iio: ad7606: use iio_device_{claim|release}_direct_mode()
      iio: accel: bmc150: use regmap to retrieve struct device
      iio: gyro: bmg160: use regmap to retrieve struct device

Crestez Dan Leonard (13):
      ti-adc081c: Add support for adc101c and adc121c
      ti-adc081c: Initial triggered buffer support
      iio: st_gyro: Add lsm9ds0-gyro support
      max44000: Initial support
      max44000: Initial support for proximity reading
      max44000: Support controlling LED current output
      max44000: Expose ambient sensor scaling
      max44000: Initial triggered buffer support
      iio: inv_mpu6050: Cleanup hw_info mapping
      iio: inv_mpu6050: Remove inv_mpu6050_hw.num_reg
      iio: inv_mpu6050: Check WHO_AM_I register on probe
      iio: inv_mpu6050: Add spi_device_id for INV_MPU6500
      iio: inv_mpu6050: Add explicit support for MPU9150

Dan Carpenter (1):
      iio: light: apds9960: silence uninitialized variable warning

Daniel Baluta (3):
      iio: imu: Add initial support for Bosch BMI160
      iio: magn: Split bmc150 driver in common/i2c parts
      iio: magn: bmc150: Introduce SPI support

Gregor Boirie (4):
      iio:magnetometer:ak8975: triggered buffer support
      iio:core: mounting matrix support
      iio:ak8975: add mounting matrix support
      iio:imu:mpu6050: enhance mounting matrix support

Harald Geyer (2):
      iio: mxs-lradc: Move binding document out of staging as well
      iio: dht11: Improve logging

Jonathan Cameron (1):
      iio: pressure: ms5611: use tab for indention

Ksenija Stanojevic (2):
      iio: adc: Indent if statement
      iio: adc: set INPUT_PROP_DIRECT

Lars-Peter Clausen (5):
      iio:adis: Add support for manual self-test flag clear
      staging:iio:adis16201: Set self_test_no_autoclear flag
      staging:iio:adis16203: Set self_test_no_autoclear flag
      staging:iio:adis16209: Set self_test_no_autoclear flag
      staging:iio:adis16240: Set self_test_no_autoclear flag

Laxman Dewangan (3):
      iio: core: Add devm_ APIs for iio_channel_{get,release}
      iio: core: Add devm_ APIs for iio_channel_{get,release}_all
      iio: Add resource managed APIs devm_iio_channel_{get,release) in devres

Linus Walleij (5):
      iio: light: new driver for the ROHM BH1780
      iio: st_sensors: read each channel individually
      iio: st_sensors: verify interrupt event to status
      iio: st_sensors: support open drain mode
      iio: tools: generic_buffer: auto-enable channels

Marek Vasut (1):
      iio: pressure: hp03: Add Hope RF HP03 sensor support

Paul Cercueil (1):
      iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs

Peter Meerwald-Stadler (1):
      iio: Add Vishay VEML6070 UV A light sensor driver

Slawomir Stepien (11):
      iio: potentiometer: add driver for Maxim Integrated DS1803
      iio: light apds9960: fix wrong use of brace
      iio: inkern: add a missing space before if
      iio: adc: vf610_adc: fix case label indent
      iio: adc: mcp3422: remove spaces before comma
      iio: adc: at91_adc: fix errors reported by checkpatch.pl
      iio: adc: ad799x: remove space before comma
      iio: common: ms_sensors: use tab for indention
      iio: common: hid-sensors: use tab for indention
      iio: magnetometer: ak8975: put else and brace at the same line
      iio: frequency: ad9523: use unsigned int rather then bare unsigned

Stefan Wahren (2):
      iio: mxs-lradc: move TS config into suitable function
      iio: mxs-lradc: move STMP reset out of ADC init

Tiberiu Breana (2):
      iio: humidity: Add support for AM2315
      iio: humidity: Add triggered buffer support for AM2315

 Documentation/ABI/testing/sysfs-bus-iio            |  53 ++
 .../bindings/{staging => }/iio/adc/mxs-lradc.txt   |   0
 .../devicetree/bindings/iio/dac/ad5592r.txt        | 155 +++++
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  13 +
 .../bindings/iio/magnetometer/ak8975.txt           |  10 +
 .../bindings/iio/potentiometer/ds1803.txt          |  21 +
 .../devicetree/bindings/iio/pressure/hp03.txt      |  17 +
 .../devicetree/bindings/iio/st-sensors.txt         |   5 +
 Documentation/driver-model/devres.txt              |   4 +
 drivers/iio/accel/bmc150-accel-core.c              |  99 +--
 drivers/iio/accel/mma7455_core.c                   |   5 +-
 drivers/iio/accel/st_accel_core.c                  |  13 +
 drivers/iio/adc/Kconfig                            |   6 +-
 drivers/iio/adc/ad799x.c                           |   2 +-
 drivers/iio/adc/at91_adc.c                         |   8 +-
 drivers/iio/adc/mcp3422.c                          |   6 +-
 drivers/iio/adc/mxs-lradc.c                        |  37 +-
 drivers/iio/adc/ti-adc081c.c                       | 118 +++-
 drivers/iio/adc/vf610_adc.c                        |  24 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   2 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |  83 +--
 drivers/iio/common/st_sensors/st_sensors_core.c    |  20 +
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  13 +
 drivers/iio/dac/Kconfig                            |  27 +
 drivers/iio/dac/Makefile                           |   3 +
 drivers/iio/dac/ad5592r-base.c                     | 691 +++++++++++++++++++++
 drivers/iio/dac/ad5592r-base.h                     |  76 +++
 drivers/iio/dac/ad5592r.c                          | 164 +++++
 drivers/iio/dac/ad5593r.c                          | 131 ++++
 drivers/iio/frequency/ad9523.c                     |  19 +-
 drivers/iio/gyro/Kconfig                           |   2 +-
 drivers/iio/gyro/bmg160_core.c                     |  86 +--
 drivers/iio/gyro/st_gyro.h                         |   1 +
 drivers/iio/gyro/st_gyro_core.c                    |   4 +
 drivers/iio/gyro/st_gyro_i2c.c                     |   5 +
 drivers/iio/gyro/st_gyro_spi.c                     |   1 +
 drivers/iio/humidity/Kconfig                       |  10 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/am2315.c                      | 303 +++++++++
 drivers/iio/humidity/dht11.c                       |  40 +-
 drivers/iio/imu/Kconfig                            |   2 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/adis.c                             |   7 +-
 drivers/iio/imu/bmi160/Kconfig                     |  32 +
 drivers/iio/imu/bmi160/Makefile                    |   6 +
 drivers/iio/imu/bmi160/bmi160.h                    |  10 +
 drivers/iio/imu/bmi160/bmi160_core.c               | 596 ++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160_i2c.c                |  72 +++
 drivers/iio/imu/bmi160/bmi160_spi.c                |  63 ++
 drivers/iio/imu/inv_mpu6050/Kconfig                |  10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  73 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  16 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  20 +-
 drivers/iio/industrialio-core.c                    |  82 +++
 drivers/iio/inkern.c                               |  86 ++-
 drivers/iio/light/Kconfig                          |  32 +
 drivers/iio/light/Makefile                         |   3 +
 drivers/iio/light/apds9960.c                       |  13 +-
 drivers/iio/light/bh1780.c                         | 297 +++++++++
 drivers/iio/light/max44000.c                       | 639 +++++++++++++++++++
 drivers/iio/light/veml6070.c                       | 218 +++++++
 drivers/iio/magnetometer/Kconfig                   |  33 +-
 drivers/iio/magnetometer/Makefile                  |   3 +
 drivers/iio/magnetometer/ak8975.c                  | 168 ++++-
 drivers/iio/magnetometer/bmc150_magn.c             | 155 ++---
 drivers/iio/magnetometer/bmc150_magn.h             |  11 +
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |  77 +++
 drivers/iio/magnetometer/bmc150_magn_spi.c         |  68 ++
 drivers/iio/magnetometer/st_magn_core.c            |   1 +
 drivers/iio/potentiometer/Kconfig                  |  10 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/ds1803.c                 | 173 ++++++
 drivers/iio/pressure/Kconfig                       |  18 +-
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/bmp280.c                      | 564 ++++++++++++++++-
 drivers/iio/pressure/hp03.c                        | 312 ++++++++++
 drivers/iio/pressure/ms5611_core.c                 |   2 +-
 drivers/iio/pressure/ms5611_spi.c                  |   2 +-
 drivers/iio/pressure/st_pressure_core.c            |  10 +
 drivers/staging/iio/accel/adis16201_core.c         |   1 +
 drivers/staging/iio/accel/adis16203_core.c         |   1 +
 drivers/staging/iio/accel/adis16209_core.c         |   1 +
 drivers/staging/iio/accel/adis16240_core.c         |   1 +
 drivers/staging/iio/adc/ad7606_core.c              |  12 +-
 include/dt-bindings/iio/adi,ad5592r.h              |  16 +
 include/linux/iio/common/st_sensors.h              |   9 +
 include/linux/iio/consumer.h                       |  53 ++
 include/linux/iio/iio.h                            |  31 +
 include/linux/iio/imu/adis.h                       |   1 +
 include/linux/iio/magnetometer/ak8975.h            |  16 +
 include/linux/platform_data/invensense_mpu6050.h   |   5 +-
 include/linux/platform_data/st_sensors_pdata.h     |   2 +
 tools/iio/generic_buffer.c                         | 102 ++-
 tools/iio/iio_utils.h                              |   7 +
 96 files changed, 6016 insertions(+), 412 deletions(-)
 rename Documentation/devicetree/bindings/{staging => }/iio/adc/mxs-lradc.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/hp03.txt
 create mode 100644 drivers/iio/dac/ad5592r-base.c
 create mode 100644 drivers/iio/dac/ad5592r-base.h
 create mode 100644 drivers/iio/dac/ad5592r.c
 create mode 100644 drivers/iio/dac/ad5593r.c
 create mode 100644 drivers/iio/humidity/am2315.c
 create mode 100644 drivers/iio/imu/bmi160/Kconfig
 create mode 100644 drivers/iio/imu/bmi160/Makefile
 create mode 100644 drivers/iio/imu/bmi160/bmi160.h
 create mode 100644 drivers/iio/imu/bmi160/bmi160_core.c
 create mode 100644 drivers/iio/imu/bmi160/bmi160_i2c.c
 create mode 100644 drivers/iio/imu/bmi160/bmi160_spi.c
 create mode 100644 drivers/iio/light/bh1780.c
 create mode 100644 drivers/iio/light/max44000.c
 create mode 100644 drivers/iio/light/veml6070.c
 create mode 100644 drivers/iio/magnetometer/bmc150_magn.h
 create mode 100644 drivers/iio/magnetometer/bmc150_magn_i2c.c
 create mode 100644 drivers/iio/magnetometer/bmc150_magn_spi.c
 create mode 100644 drivers/iio/potentiometer/ds1803.c
 create mode 100644 drivers/iio/pressure/hp03.c
 create mode 100644 include/dt-bindings/iio/adi,ad5592r.h
 create mode 100644 include/linux/iio/magnetometer/ak8975.h
