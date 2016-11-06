Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57123 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbcKFRzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 12:55:25 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] Second set of IIO new device support and cleanups for the 4.10
 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <66401fac-d6f6-f62b-e6c2-540aa11d5688@kernel.org>
Date: Sun, 6 Nov 2016 17:55:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 49b9137a6002a06f7e44e59ece9b34fd1e4fca4c:

  staging: greybus: audio: remove redundant slot field (2016-10-24 15:48:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.10b

for you to fetch changes up to c2b0d2cfb0317275cf04257fc3f5dfbdd9ffa274:

  staging: iio: tsl2583: remove redudant i2c call in taos_als_calibrate() (2016-11-06 11:54:32 +0000)

----------------------------------------------------------------
Second round of new device support, cleanups and fixes for IIO in the 4.10 cycle

This includes two branch merges for elements that may also go via MFD.

New device support
* cros_ec
  - new driver to support these Chrome OS contiguous sensors which are behind
    the Chrome OS embedded controller.  Requires a few minor MFD and chrome
    platform changes.  One follow up fix deals with some dependency issues in
    Kconfig.
* mpu-3050
  - new driver and device tree bindings for this venerable device.
* st_accel
  - support for the lng2dm an

Driver features
* ad7192
  - Add DVdd regulator handling
* ad9832
  - Add DVDD regulator handling
* at91
  - Suspend and resume support
* si7020
  - Device tree bindings
* ti-am335x
  - DMA support - uses dma to accelerate short bursts of read back rather
  than full blown DMA buffer support.  Greatly improved performance.
  Includes an MFD addition to give access to the address needed for DMA.
* tsl2583
  - Device tree bindings

Cleanups and minor fixes
* ad7192
  - Fix regulator naming to match datasheet
  - Handle regulator errors correctly (so as to not break deferred probing)
  - Rename reg variable to reflect which regulator it is
* ad5933
  - Fix regulator naming to match datasheet
  - Handle regulator errors correctly (so as to not break deferred probing)
* ad7746
  - Fix a missing return value (fallout from previous patch set)
* ad7780
  - Fix regulator naming to match datasheet
  - Handle regulator errors correctly (so as to not break deferred probing)
* ad9832
  - Fix regulator naming to match datasheet
  - Handle regulator errors correctly (so as to not break deferred probing)
  - Rename reg regulator to reflect which one it is
* ad9834
  - Fix regulator naming to match datasheet
  - Handle regulator errors correctly (so as to not break deferred probing)
* hts221
  - Remove a duplicated include
* maxim thermocouple
  - Handle a wrong storage side in read function.  Prevent any problems that
  might be introduced by additions to this driver in future.
* tsl2583 - big set from Brian Masney to drive this towards a staging
  graduation.
  - Convert to iio_chan_spec and read_raw / write_raw (in a couple of steps)
  - Improved error handling in various functions
  - Drop redundant power_state custom sysfs attribute.
  - Use IIO_*_ATTR* macros for remaining attributes.
  - Return an error code to userspace on invalid parameters being writen to
    sysfs files.
  - Add locking to various attribute accesses to remove possible races.
  - Add defines for various magic numbers.
  - Use smbus_read_byte_data instead of a write_byte followed by read_byte.
  - Query only relevant registers in probe.
  - Tidy up ordering of code comments.
  - Remove a pointless power off sequence in taos_chip_on.
  - Don't bother shutting down the chip when updating the lux table.
  The table is held entirely in the driver and doesn't effect the chip at all.
  - Drop a redundant i2c call in taos_als_calibrate where the same register
  is read twice in a row.

----------------------------------------------------------------
Arnd Bergmann (2):
      staging: iio: cdc/ad7746: fix missing return value
      iio: maxim_thermocouple: detect invalid storage size in read()

Brian Masney (16):
      staging: iio: tsl2583: add of_match table for device tree support
      staging: iio: tsl2583: check for error code from i2c_smbus_read_byte()
      staging: iio: tsl2583: return proper error code instead of -1
      staging: iio: tsl2583: remove redundant power_state sysfs attribute
      staging: iio: tsl2583: check return values from taos_chip_{on,off}
      staging: iio: tsl2583: convert to use iio_chan_spec and {read,write}_raw
      staging: iio: tsl2583: convert illuminance0_calibscale sysfs attr to use iio_chan_spec
      staging: iio: tsl2583: use IIO_*_ATTR* macros to create sysfs entries
      staging: iio: tsl2583: add error code to sysfs store functions
      staging: iio: tsl2583: add locking to sysfs attributes
      staging: iio: tsl2583: i2c_smbus_write_byte() / i2c_smbus_read_byte() migration
      staging: iio: tsl2583: removed unused code from device probing
      staging: iio: tsl2583: fixed ordering of comments
      staging: iio: tsl2583: remove redundant power off sequence in taos_chip_on()
      staging: iio: tsl2583: don't shutdown chip when updating the lux table
      staging: iio: tsl2583: remove redudant i2c call in taos_als_calibrate()

Enric Balletbo i Serra (3):
      iio: cros_ec_sensors_core: Add common functions for the ChromeOS EC Sensor Hub.
      iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver
      platform/chrome: cros_ec_dev - Register cros-ec sensors

Eva Rachel Retuya (7):
      staging: iio: cdc: ad7746: add additional config defines
      staging: iio: set proper supply name to devm_regulator_get()
      staging: iio: rework regulator handling
      staging: iio: ad7192: add DVdd regulator
      staging: iio: ad7192: rename regulator 'reg' to 'avdd'
      staging: iio: ad9832: add DVDD regulator
      staging: iio: ad9832: clean-up regulator 'reg'

Jonathan Cameron (3):
      iio:cros_ec_sensors: Swap from a select to a depends in Kconfig
      Merge branch 'ib-iio-mfd-4.9rc1' into togreg
      Merge branch 'ib-iio-mfd-ti335x_dma' into togreg

Linus Walleij (2):
      iio: gyro: Add MPU-3050 device tree bindings
      iio: gyro: Add driver for the MPU-3050 gyroscope

Lorenzo Bianconi (2):
      iio: accel: st_accel: add support to lng2dm
      Documentation: dt: iio: accel: add lng2dm sensor device binding

Mugunthan V N (2):
      mfd: ti_am335x_tscadc: store physical address
      drivers: iio: ti_am335x_adc: add dma support

Paul Kocialkowski (1):
      iio: si7020: Add devicetree support and trivial bindings

Song Hongyan (1):
      iio: hid-sensor-attributes: Check sample_frequency/hysteresis write data legitimacy

Vincent Palatin (1):
      platform/chrome: Introduce a new function to check EC features.

Wei Yongjun (1):
      iio: humidity: remove duplicated include from hts221_buffer.c

Wenyou Yang (1):
      iio: adc: at91: add suspend and resume callback

 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |   18 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../bindings/iio/gyroscope/invensense,mpu3050.txt  |   46 +
 .../devicetree/bindings/iio/light/tsl2583.txt      |   26 +
 .../devicetree/bindings/iio/st-sensors.txt         |    1 +
 MAINTAINERS                                        |    7 +
 drivers/iio/accel/Kconfig                          |    3 +-
 drivers/iio/accel/st_accel.h                       |    1 +
 drivers/iio/accel/st_accel_core.c                  |   73 ++
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/accel/st_accel_spi.c                   |    1 +
 drivers/iio/adc/at91_adc.c                         |   28 +
 drivers/iio/adc/ti_am335x_adc.c                    |  148 ++-
 drivers/iio/common/Kconfig                         |    1 +
 drivers/iio/common/Makefile                        |    1 +
 drivers/iio/common/cros_ec_sensors/Kconfig         |   22 +
 drivers/iio/common/cros_ec_sensors/Makefile        |    6 +
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  322 +++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  450 +++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.h  |  175 +++
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    5 +-
 drivers/iio/gyro/Kconfig                           |   17 +
 drivers/iio/gyro/Makefile                          |    5 +
 drivers/iio/gyro/mpu3050-core.c                    | 1307 ++++++++++++++++++++
 drivers/iio/gyro/mpu3050-i2c.c                     |  124 ++
 drivers/iio/gyro/mpu3050.h                         |   96 ++
 drivers/iio/humidity/hts221_buffer.c               |    1 -
 drivers/iio/humidity/si7020.c                      |   11 +-
 drivers/iio/temperature/maxim_thermocouple.c       |    2 +
 drivers/mfd/ti_am335x_tscadc.c                     |    1 +
 drivers/platform/chrome/cros_ec_dev.c              |  159 +++
 drivers/staging/iio/adc/ad7192.c                   |   43 +-
 drivers/staging/iio/adc/ad7780.c                   |   22 +-
 drivers/staging/iio/cdc/ad7746.c                   |   39 +-
 drivers/staging/iio/frequency/ad9832.c             |   56 +-
 drivers/staging/iio/frequency/ad9832.h             |    6 +-
 drivers/staging/iio/frequency/ad9834.c             |   19 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   21 +-
 drivers/staging/iio/light/tsl2583.c                |  611 ++++-----
 include/linux/mfd/cros_ec.h                        |   10 +
 include/linux/mfd/cros_ec_commands.h               |  183 ++-
 include/linux/mfd/ti_am335x_tscadc.h               |    8 +
 42 files changed, 3646 insertions(+), 435 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cros-ec
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2583.txt
 create mode 100644 drivers/iio/common/cros_ec_sensors/Kconfig
 create mode 100644 drivers/iio/common/cros_ec_sensors/Makefile
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
 create mode 100644 drivers/iio/gyro/mpu3050-core.c
 create mode 100644 drivers/iio/gyro/mpu3050-i2c.c
 create mode 100644 drivers/iio/gyro/mpu3050.h
