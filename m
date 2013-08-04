Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47750 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab3HDQAd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 12:00:33 -0400
Message-ID: <51FE88B7.5000506@kernel.org>
Date: Sun, 04 Aug 2013 18:00:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new stuff and staging graduations (IIO set 1
 for the 3.12 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 36e607a16b8def1b184d48a4489b716d6dbe3379:

  staging: lustre: remove ll_crypto_alloc_blkcipher (2013-08-03 14:44:31 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.12a

for you to fetch changes up to cd6fe06588423ff4cca85c85c4402027b04dccf1:

  staging:iio:hmc5843: Use i2c_smbus_read_word_swapped() (2013-08-04 11:22:55 +0100)

----------------------------------------------------------------
First round of new IIO drivers, features and cleanups for the 3.12 cycle.

There has been a lot of good work going into IIO recently, some of which
missed this pull request purely because I haven't caught up with all my
emails.

Core changes

1) Introduction of devm_iio_device_alloc/free and conversions of lots of
   drivers (37 + patches so far mostly from Sachin)
2) A Kconfig option to enabled some debug logging subsystem wide.

New drivers

1) Nuvoton NAU7802 adc driver
2) Avago APDS9300 ambient light sensor driver.

Staging graduations
1) ADIS16260 gyroscope (after a lot fo cleaning up from Lars-Peter)

New driver features

1) ST-sensors gain control of which pin is used for dataready.
2) mcp4725 gains eeprom saving (a later fix deals with a wrong return type
   bug in that patch)
3) A number of drivers have gained module alias' to aid autoloading.

Cleanups and minor bug fixes.

1) A number of typos in Kconfig comments
2) Drop remaining mentions of ring buffers (now just buffers)
3) Overrestrictive i2c function checking in the invensense mpu6050 driver
4) Some help text clarifications.
5) store_eeprom is now used in several drivers so move to generic abi docs.
6) Update dac power down options.
7) Add some error handlign to mxs-lradc on stmp_reset_block call.
8) Lars fixed the alphabetical order in various files and added comments
   to try and prevent them getting messed up again.
9) Dropped some remaining 'reset' attributes for drivers.  We have never
   seen a reason why these should be available.  Finally the macro
   used to define many of these has gone.
10) lps331ap gets an easier to check temperature scale implementation.
11) Various cleanups for the hmc5843 from Peter with a view to getting
    it ready for a staging graduation.

Quite a few other little typo fixes etc.

----------------------------------------------------------------
Alexander Holler (4):
      iio: hid-sensor-accel-3d: add module alias for autoload
      iio: hid-sensor-gyro-3d: add module alias for autoload
      iio: hid-sensor-als: add module alias for autoload
      iio: hid-sensor-magn-3d: add module alias for autoload

Alexandre Belloni (1):
      iio: Add Nuvoton NAU7802 ADC driver

Denis CIOCCA (1):
      iio: Added ST-sensors platform data to select the DRDY interrupt pin

Fabio Estevam (1):
      iio: mxs-lradc: Check the return value from stmp_reset_block()

Grygorii Strashko (1):
      iio: core: implement devm_iio_device_alloc/devm_iio_device_free

Jacek Anaszewski (1):
      iio: lps331ap: Modify in_temp_scale calculation way

Jonathan Cameron (1):
      iio:dac:mcp4725 wrong return type of attribute _show function

Lars-Peter Clausen (20):
      iio: Add a comment to about alphabetical order to Kconfigs and Makefiles
      staging:iio:ad2s1210: Don't expose the chip reset to userspace
      staging:iio:adt7316: Don't expose the chip reset to userspace
      staging:iio:ade7xxx: Don't expose the chip reset to userspace
      iio: Remove IIO_DEV_ATTR_RESET macro
      staging:iio:adis16260: Fix reading calibscale
      staging:iio:adis16260: Drop unused 'negate' property
      staging:iio:adis16260: Remove support for orientation mapping
      staging:iio:adis16260: Don't set default scan mask
      staging:iio:adis16260: Remove separate header
      staging:iio:adis16260: Add value range check for calibscale/-bias
      staging:iio:adis16260: Use sign_extend32() instead of open-coding it
      staging:iio:adis16260: Simplify calibscale and caliboffset reading
      staging:iio:adis16260: Fix minor style issue
      staging:iio:adis16260: Remove 'SPS' suffix from samplerate attribute
      staging:iio:adis16260: Add scale for the inclination channel
      staging:iio:adis16260: Remove unused includes
      staging:iio:adis16260: Add proper range checks to write_frequency()
      staging:iio:adis16260: Remove sampling_frequency_available attribute
      staging:iio:adis16260: Move out of staging

Oleksandr Kravchenko (4):
      of: Add Avago Technologies vendor prefix
      iio: add APDS9300 ambilent light sensor driver
      Documentation: devres: add IIO device alloc/free functions to list
      iio: core: Avoid double minus in sysfs output

Otavio Salvador (1):
      iio: add configuration option for debug support

Peter Meerwald (24):
      iio: fix typos in dac Kconfig
      iio: use I2C_FUNC_SMBUS_I2C_BLOCK macro
      iio: fix Kconfig typos
      iio: remove mention of ring buffer from CONFIG_IIO_KFIFO_BUF, CONFIG_IIO_TRIGGER description
      iio: reword help text of several IIO_ST drivers
      iio: add store_eeprom to mcp4725 dac driver
      iio: add powerdown to mcp4725 dac drive
      iio: add DAC 500kohm_to_gnd to possible powerdown_modes
      iio: move ABI specification for store_eeprom; is used by ad9523, mcp4725 and ds1077 devices
      iio: staging: fix device.txt documentation
      iio: fix typo, Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
      iio: staging: fix typo in ade758_ring.c
      iio: fix semicolon in io_core_trigger.h
      iio:adjd_s311: Use devm_iio_device_alloc
      iio:vcnl4000: Use devm_iio_device_alloc
      iio:mcp4725: Use devm_iio_device_alloc
      iio: Fix documentation of devm_iio_device_free()
      staging:iio:hmc5843: Drop I2C detection code
      staging:iio:hmc5843: Remove id register #defines, not used anymore
      staging:iio:hmc5843: Implement timeout in read function
      staging:iio:hmc5843: 'add' is a poor abbreviation for address
      staging:iio:hmc5843: Device has 3 channels, no need to store separately
      staging:iio:hmc5843: Drop unneeded #includes
      staging:iio:hmc5843: Use i2c_smbus_read_word_swapped()

Sachin Kamat (36):
      iio: adc: ad7266: Use devm_* APIs
      iio: adc: ad7298: Use devm_* APIs
      iio: adc: ad7476: Use devm_* APIs
      iio: adc: ad7791: Use devm_* APIs
      iio: adc: ad7793: Use devm_* APIs
      iio: adc: ad7887: Use devm_* APIs
      iio: adc: ad7923: Use devm_* APIs
      iio: adc: lp8788_adc: Use devm_* APIs
      iio: adc: mcp320x: Use devm_* APIs
      iio: adc: nau7802: Use devm_iio_device_alloc
      iio: adc: ti-adc081c: Use devm_* APIs
      iio: adc: viperboard_adc: Use devm_iio_device_alloc
      iio: at91: Use devm_iio_device_alloc
      iio: exynos_adc: Use devm_iio_device_alloc
      iio: max1363: Use devm_iio_device_alloc
      iio: frequency: adf4350: Use devm_* APIs
      staging: iio: mxs-lradc: Use devm_iio_device_alloc
      staging: iio: spear_adc: Use devm_iio_device_alloc
      staging: iio: light: isl29018: Use devm_iio_device_alloc
      staging: iio: light: isl29028: Use devm_iio_device_alloc
      iio: hid-sensor-accel-3d: Use devm_iio_device_alloc
      iio: accel: kxsd9: Use devm_iio_device_alloc
      iio: accel: st_accel: Use devm_iio_device_alloc
      iio: adc: ti_am335x_adc: Use devm_iio_device_alloc
      iio: adc: Update ti_am335x_adc Kconfig entry
      iio: magnetometer: hid-sensor-magn-3d: Use devm_iio_device_alloc
      iio: magnetometer: st_magn: Use devm_iio_device_alloc
      iio: imu: adis16400: Use devm_iio_device_alloc
      iio: imu: adis16480: Use devm_iio_device_alloc
      iio: imu: inv_mpu6050: Use devm_iio_device_alloc
      iio: light: hid-sensor-als: Use devm_iio_device_alloc
      iio: light: lm3533-als: Use devm_iio_device_alloc
      iio: light: tsl2563: Use devm_* APIs
      iio: amplifiers: ad8366: Use devm_* APIs
      iio: frequency: ad9523: Use devm_* APIs
      iio: pressure: st_pressure: Use devm_iio_device_alloc

 Documentation/ABI/testing/sysfs-bus-iio            |   9 +
 .../ABI/testing/sysfs-bus-iio-frequency-ad9523     |   8 -
 .../ABI/testing/sysfs-bus-iio-frequency-adf4350    |   2 +-
 .../bindings/iio/adc/nuvoton-nau7802.txt           |  18 +
 .../devicetree/bindings/iio/light/apds9300.txt     |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/driver-model/devres.txt              |   4 +
 drivers/iio/Kconfig                                |  14 +-
 drivers/iio/Makefile                               |   2 +
 drivers/iio/accel/Kconfig                          |  20 +-
 drivers/iio/accel/Makefile                         |   4 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |  35 +-
 drivers/iio/accel/kxsd9.c                          |  17 +-
 drivers/iio/accel/st_accel.h                       |  11 +-
 drivers/iio/accel/st_accel_core.c                  |  28 +-
 drivers/iio/accel/st_accel_i2c.c                   |  17 +-
 drivers/iio/accel/st_accel_spi.c                   |  17 +-
 drivers/iio/adc/Kconfig                            |  47 +-
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/ad7266.c                           |  16 +-
 drivers/iio/adc/ad7298.c                           |  24 +-
 drivers/iio/adc/ad7476.c                           |  26 +-
 drivers/iio/adc/ad7791.c                           |  19 +-
 drivers/iio/adc/ad7793.c                           |  23 +-
 drivers/iio/adc/ad7887.c                           |  23 +-
 drivers/iio/adc/ad7923.c                           |  20 +-
 drivers/iio/adc/at91_adc.c                         |  23 +-
 drivers/iio/adc/exynos_adc.c                       |  23 +-
 drivers/iio/adc/lp8788_adc.c                       |   7 +-
 drivers/iio/adc/max1363.c                          |  15 +-
 drivers/iio/adc/mcp320x.c                          |  18 +-
 drivers/iio/adc/nau7802.c                          | 581 +++++++++++++++++++++
 drivers/iio/adc/ti-adc081c.c                       |  18 +-
 drivers/iio/adc/ti_am335x_adc.c                    |  13 +-
 drivers/iio/adc/viperboard_adc.c                   |   9 +-
 drivers/iio/amplifiers/Kconfig                     |   2 +
 drivers/iio/amplifiers/Makefile                    |   1 +
 drivers/iio/amplifiers/ad8366.c                    |  13 +-
 drivers/iio/common/Makefile                        |   1 +
 drivers/iio/common/st_sensors/st_sensors_core.c    |  41 +-
 drivers/iio/dac/Kconfig                            |  44 +-
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/mcp4725.c                          | 177 ++++++-
 drivers/iio/frequency/Kconfig                      |   1 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/ad9523.c                     |  17 +-
 drivers/iio/frequency/adf4350.c                    |  31 +-
 drivers/iio/gyro/Kconfig                           |  18 +-
 drivers/iio/gyro/Makefile                          |   2 +
 .../gyro/adis16260_core.c => iio/gyro/adis16260.c} | 305 +++++------
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  16 +-
 drivers/iio/gyro/st_gyro.h                         |  11 +-
 drivers/iio/gyro/st_gyro_core.c                    |  13 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   3 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   3 +-
 drivers/iio/iio_core_trigger.h                     |   7 +-
 drivers/iio/imu/Kconfig                            |   2 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/adis16400_core.c                   |  10 +-
 drivers/iio/imu/adis16480.c                        |  10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  29 +-
 drivers/iio/industrialio-core.c                    |  51 +-
 drivers/iio/light/Kconfig                          |  34 +-
 drivers/iio/light/Makefile                         |   4 +-
 drivers/iio/light/adjd_s311.c                      |  15 +-
 drivers/iio/light/apds9300.c                       | 512 ++++++++++++++++++
 drivers/iio/light/hid-sensor-als.c                 |  33 +-
 drivers/iio/light/lm3533-als.c                     |   7 +-
 drivers/iio/light/tsl2563.c                        |  25 +-
 drivers/iio/light/vcnl4000.c                       |  16 +-
 drivers/iio/magnetometer/Kconfig                   |   6 +-
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  35 +-
 drivers/iio/magnetometer/st_magn.h                 |   3 +-
 drivers/iio/magnetometer/st_magn_core.c            |   6 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |  17 +-
 drivers/iio/magnetometer/st_magn_spi.c             |  17 +-
 drivers/iio/pressure/Kconfig                       |  14 +-
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/st_pressure.h                 |  11 +-
 drivers/iio/pressure/st_pressure_core.c            |  21 +-
 drivers/iio/pressure/st_pressure_i2c.c             |  17 +-
 drivers/iio/pressure/st_pressure_spi.c             |  17 +-
 drivers/iio/trigger/Kconfig                        |   4 +-
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/staging/iio/Documentation/device.txt       |   4 +-
 drivers/staging/iio/adc/mxs-lradc.c                |  33 +-
 drivers/staging/iio/adc/spear_adc.c                |  30 +-
 drivers/staging/iio/addac/adt7316.c                |  27 -
 drivers/staging/iio/gyro/Kconfig                   |  12 -
 drivers/staging/iio/gyro/Makefile                  |   3 -
 drivers/staging/iio/gyro/adis16260.h               |  98 ----
 drivers/staging/iio/gyro/adis16260_platform_data.h |  19 -
 drivers/staging/iio/light/isl29018.c               |  16 +-
 drivers/staging/iio/light/isl29028.c               |  13 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |  71 +--
 drivers/staging/iio/meter/ade7753.c                |  18 -
 drivers/staging/iio/meter/ade7754.c                |  19 -
 drivers/staging/iio/meter/ade7758_core.c           |  18 -
 drivers/staging/iio/meter/ade7758_ring.c           |   2 +-
 drivers/staging/iio/meter/ade7759.c                |  18 -
 drivers/staging/iio/meter/ade7854.c                |  19 -
 drivers/staging/iio/resolver/ad2s1210.c            |  18 -
 include/linux/iio/common/st_sensors.h              |  14 +-
 include/linux/iio/iio.h                            |  25 +
 include/linux/iio/sysfs.h                          |   5 -
 include/linux/platform_data/st_sensors_pdata.h     |  24 +
 107 files changed, 2126 insertions(+), 1144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9300.txt
 create mode 100644 drivers/iio/adc/nau7802.c
 rename drivers/{staging/iio/gyro/adis16260_core.c => iio/gyro/adis16260.c} (53%)
 create mode 100644 drivers/iio/light/apds9300.c
 delete mode 100644 drivers/staging/iio/gyro/adis16260.h
 delete mode 100644 drivers/staging/iio/gyro/adis16260_platform_data.h
 create mode 100644 include/linux/platform_data/st_sensors_pdata.h
