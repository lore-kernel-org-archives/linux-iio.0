Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46798 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759450AbcB1RGd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2016 12:06:33 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: [PULL] Third set of IIO new device support, features and cleanups for
 the 4.6 cycle.
Message-ID: <56D32917.5020509@kernel.org>
Date: Sun, 28 Feb 2016 17:06:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 1d427da1d7f9f81c4f5439c9610683d3cb9c1921:

  Platform: goldfish: goldfish_pipe.c: Add DMA support using managed version (2016-02-14 17:43:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.6c

for you to fetch changes up to ac65ca682e84cff77e36ad0d71862b33b4be5f9e:

  iio: adc: palmas: Drop IRQF_EARLY_RESUME flag (2016-02-27 17:20:52 +0000)

----------------------------------------------------------------
Third set of IIO new device support, features and cleanups for the 4.6 cycle.

Good to see several new contributors in this set - and more generally a
number of new 'faces' over this whole cycle.

Staging movements
* hmc5843
  - out of staging.
* periodic RTC trigger
  - driver dropped.  This is an ancient driver (brings back some memories ;)
  that was always somewhat of a bodge. Originally there was a driver that
  never went into mainline that supported large numbers of periodict timers
  on the PXA270 via this route. Discussions to have a generic periodic
  timer subsystem never went anywhere.  At the time RTC periodic
  interrupts were real - now they are emulated using high resolution
  timers so with the HRT driver this has become pointless.

New device support
* mpu6050 driver
  - Add support for the mpu6500.
* TI tpl0102 potentiometer
  - new driver.
* Vybrid SoC DAC
  - new driver.  The ADC on this SoC has been supported for a while, this
    adds a separate driver for the DAC.

New Features
* hmc5844
  - Attributes to configure the bias current (typically part of a self test)
    This could be done before via a somewhat obscure custom interface.
    This at least makes it easy to tell what is going on.
  - Document all custom attributes.
* mpu6050
  - Add support for calibration offset control and readback.
* ms5611
  - power regulator support.  This is always one that gets added the
    first time someone has a board that needs it.  Here it was needed,
    hence it was added.

Cleanups / minor fixes
* tree wide
  - clean up all the myriad different return values in response to a
    failure of i2c_check_functionality.  After discussions everyone seemed
    happy wiht -EOPNOTSUPP which seems to describe the situation well.
    I encouraged a tree wide cleanup to set a good example in future for
    this.
* core
  - Typos in the iio_event_spec documentation in iio.h
* afe4403
  - select REGMAP_SPI to avoid dependency issues
  - mark suspend/resume as __maybe_unused to avoid warnings
* afe4404
  - mark suspend/resume as __maybe_unused to avoid warnings
* atlas-ph-sensor
  - switch the regmap cache type from linear to rbtree to gain reading of
    registers on initial startup.  It's not immediately obvious, but
    regmap flat is meant for high performances cases so doesn't read these
    registers.
  - use regmap_bulk_read in one case where it was using
    i2c_smbus_read_i2c_block_data directly (unlike everything else that was
    through regmap).
* ina2xx
  - stype cleanups (lots of them!)
* isl29018
  - Get the struct device back from regmap rather than storing another
    copy of it in the private data.  This cleanup makes sense in a number
    of other drivers so patches may well follow.
* mpu6050
  - style cleanups (lots of them!)
  - improved return value handling
  - use usleep_range to avoid the usual issues with very short msleeps.
  - add some missing documentation.
* ms5611
  - use the probed device name for the device rather than the driver name.
  - select IIO_BUFFER to avoid dependency issues
* palmas
  - drop IRQF_EARLY_RESUME as no longer needed after genirq changes.

----------------------------------------------------------------
Alison Schofield (1):
      staging: iio: isl29018: use regmap to retrieve struct device

Andrew F. Davis (2):
      iio: ina2xx: Fix whitespace and re-order code
      iio: ina2xx: Remove trace_printk debug statments

Arnd Bergmann (4):
      iio: health/afe4403: select REGMAP_SPI
      iio: health/afe4403: mark suspend/resume functions __maybe_unused
      iio: health/afe4404: mark suspend/resume functions __maybe_unused
      iio: pressure: ms5611: select IIO_BUFFER

Cristina Moraru (3):
      iio: hmc5843: Add attributes for measurement config of bias current
      iio: hmc5843: Add ABI documentation file for hmc5843
      iio: hmc5843: Move hmc5843 out of staging

Daniel Baluta (7):
      iio: imu: inv_mpu6050: Fix multiline comments style
      iio: imu: inv_mpu6050: Fix Yoda conditions
      iio: imu: inv_mpu6050: Fix newlines to make code easier to read
      iio: imu: inv_mpu6050: Remove unnecessary parentheses
      iio: imu: inv_mpu6050: Delete space before comma
      iio: imu: inv_mpu6050: Fix code indent for if statement
      iio: imu: inv_mpu6050: Fix alignment with open parenthesis

Gregor Boirie (1):
      iio:pressure:ms5611: fix ms5607 temp compensation

Grygorii Strashko (1):
      iio: adc: palmas: Drop IRQF_EARLY_RESUME flag

Grégor Boirie (2):
      iio:pressure:ms5611: use probed device name
      iio:pressure:ms5611: power regulator support

Lars-Peter Clausen (1):
      staging:iio: Remove periodic RTC trigger driver

Matt Ranostay (10):
      iio: chemical: atlas-ph-sensor: switch regmap cache
      iio: chemical: atlas-ph-sensor: use regmap_bulk_read
      iio: imu: mpu6050: remove trailing whitespaces
      iio: potentiometer: add TI tpl0102 support
      iio: imu: mpu6050: use inv_mpu6050_sensor_show return code
      iio: imu: mpu6050: fix INV_MPU6050_REG_UP_TIME delay
      iio: imu: mpu6050: add missing docstring for int_pin_cfg
      iio: imu: mpu6050: add calibration offset support
      iio: imu: mpu6050: add mpu6500 register settings
      iio: convert to common i2c_check_functionality() return value

Sanchayan Maity (1):
      iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC

William Breathitt Gray (1):
      iio: Fix typos in the struct iio_event_spec documentation comments

 .../ABI/testing/sysfs-bus-iio-magnetometer-hmc5843 |  15 ++
 Documentation/ABI/testing/sysfs-bus-iio-vf610      |   9 +
 .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++
 drivers/iio/adc/ina2xx-adc.c                       | 155 +++++------
 drivers/iio/adc/mcp3422.c                          |   2 +-
 drivers/iio/adc/palmas_gpadc.c                     |   6 +-
 drivers/iio/adc/ti-adc081c.c                       |   2 +-
 drivers/iio/chemical/atlas-ph-sensor.c             |  10 +-
 drivers/iio/chemical/vz89x.c                       |   2 +-
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/vf610_dac.c                        | 298 +++++++++++++++++++++
 drivers/iio/health/Kconfig                         |   1 +
 drivers/iio/health/afe4403.c                       |   4 +-
 drivers/iio/health/afe4404.c                       |   4 +-
 drivers/iio/humidity/hdc100x.c                     |   2 +-
 drivers/iio/humidity/htu21.c                       |   2 +-
 drivers/iio/humidity/si7005.c                      |   2 +-
 drivers/iio/humidity/si7020.c                      |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 197 ++++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  20 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  23 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  22 +-
 drivers/iio/light/bh1750.c                         |   2 +-
 drivers/iio/light/jsa1212.c                        |   2 +-
 drivers/iio/magnetometer/Kconfig                   |  33 +++
 drivers/iio/magnetometer/Makefile                  |   4 +
 drivers/{staging => }/iio/magnetometer/hmc5843.h   |   0
 .../{staging => }/iio/magnetometer/hmc5843_core.c  | 140 ++++++----
 .../{staging => }/iio/magnetometer/hmc5843_i2c.c   |   0
 .../{staging => }/iio/magnetometer/hmc5843_spi.c   |   0
 drivers/iio/potentiometer/Kconfig                  |  12 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/mcp4531.c                |   2 +-
 drivers/iio/potentiometer/tpl0102.c                | 166 ++++++++++++
 drivers/iio/pressure/Kconfig                       |   1 +
 drivers/iio/pressure/mpl115_i2c.c                  |   2 +-
 drivers/iio/pressure/ms5611.h                      |   3 +-
 drivers/iio/pressure/ms5611_core.c                 |  30 ++-
 drivers/iio/pressure/ms5611_i2c.c                  |   4 +-
 drivers/iio/pressure/ms5611_spi.c                  |   4 +-
 drivers/iio/pressure/ms5637.c                      |   2 +-
 drivers/iio/pressure/t5403.c                       |   2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   2 +-
 drivers/iio/temperature/mlx90614.c                 |   2 +-
 drivers/iio/temperature/tmp006.c                   |   2 +-
 drivers/iio/temperature/tsys01.c                   |   2 +-
 drivers/iio/temperature/tsys02d.c                  |   2 +-
 drivers/staging/iio/Kconfig                        |   1 -
 drivers/staging/iio/Makefile                       |   1 -
 drivers/staging/iio/TODO                           |   8 -
 drivers/staging/iio/light/isl29018.c               |  28 +-
 drivers/staging/iio/magnetometer/Kconfig           |  40 ---
 drivers/staging/iio/magnetometer/Makefile          |   7 -
 drivers/staging/iio/trigger/Kconfig                |  10 -
 drivers/staging/iio/trigger/Makefile               |   1 -
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    | 216 ---------------
 include/linux/iio/iio.h                            |   6 +-
 61 files changed, 1000 insertions(+), 566 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843
 create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
 create mode 100644 drivers/iio/dac/vf610_dac.c
 rename drivers/{staging => }/iio/magnetometer/hmc5843.h (100%)
 rename drivers/{staging => }/iio/magnetometer/hmc5843_core.c (86%)
 rename drivers/{staging => }/iio/magnetometer/hmc5843_i2c.c (100%)
 rename drivers/{staging => }/iio/magnetometer/hmc5843_spi.c (100%)
 create mode 100644 drivers/iio/potentiometer/tpl0102.c
 delete mode 100644 drivers/staging/iio/magnetometer/Kconfig
 delete mode 100644 drivers/staging/iio/magnetometer/Makefile
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
