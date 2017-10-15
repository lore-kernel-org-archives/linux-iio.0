Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbdJOL2P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Oct 2017 07:28:15 -0400
Date: Sun, 15 Oct 2017 12:28:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] Second set of new device support, features and cleanup for
 IIO in the 4.15 cycle.
Message-ID: <20171015122811.7725af15@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 1236d6bb6e19fc72ffc6bbcdeb1bfefe450e54ee:

  Merge 4.14-rc4 into staging-next (2017-10-09 09:02:35 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.15b

for you to fetch changes up to 11b86c7004ef14f9f8c1e2caf66bfaad6f3167a2:

  platform/chrome: Add cros_ec_accel_legacy driver (2017-10-14 20:34:01 +0100)

----------------------------------------------------------------
Second set of IIO new device support, features and cleanup for 4.15

New device support
* cros_ec_accel_legacy
  - New driver for this older chromebook accelerometer.
* ds4422 dac driver
  - New driver and bindings for the Maxim ds4422 and ds4424 I2C DACs.
* kxcjk1013
  - Support the KXTF9 accelerometers.
* mcp320x
  - support mcp3550, mcp3551, mcp3553 21 bit ADCs.
* rfd77402
  - new driver for this laser range finder.
* st-sensors-accel
  - add support for the LIS2DW12 accelerometer with bindings
  - add support for the LIS3DHH accelerometer with bindings

New features
* core
  - Drop a duplicate forward declaration in iio.h
* Docs
  - add a clarification of the meaning of IIO_DISTANCE to reflect
    existing use in various range finding devices.
* st-sensors
  - add a register mask for the status register to correctly support
    2 channel devices.
  - decouple the irq1 and irq2 configuration parameters.
  - do not always write the enable_axis register as some newer devices
    are always on and don't support such configuration.
  - split open-drain control for irq1 and irq2
  - make sampling frequency control optional as non all hardware
    supports it.
* st-sensors-gyro
  - support 3 wire SPI mode
* st-sensors-magn
  - support 3 wire SPI mode
* st-sensors-pressure
  - support 3 wire SPI mode.

Cleanups and fixes
* ad7192
  - expand the buffer lock to cover device state protection rather than
    using core mlock to provide the state protection.
* ade7753
  - expand the buffer lock to cover device state protection as well
    rather than having an additional lock.
* dummy-evgen
  - Use the new irq_sim infrastructure rather than having our
    own local version of the same thing.
* hid-sensor-trigger
  - avoid touching sensors ever if user hasn't requested it.  This
    is a work around for one reported issue where turning a sensor
    off wasn't sufficient to make it actually switch off.  As we
    have only one report from what looks like buggy hardware we
    are sending this upstream the slow way.
* ina2xx
  - Adhere to the published ABI docs and use Ohms instead of
    microohms.  We don't think that anyone will notice this ABI fix
    but are sending it the slow route to reduce fallout if someone
    does!
* kxcjk1013 - refactors to support the KXTF9 being added.
  - Refactor ODR support.
  - Fix INT_CTRL/INT_SRC1 bit names to match the register name.
  - Extract code for reporting motion events as this isn't present
    on some parts to be supported.
  - Make the sysfs sampling_frequency_available stuff not a fixed
    string so as to allow for it to be chip type dependent.
  - Make the sampling frequency_available per type to match
    the sampling_frequency attributes.
* lsm6dsx - rework prior to new device support.
  - express the max fifo depth in 'scans' rather than bytes.
  - split control of the fifo mode fifo output data rate.
  - move decimator registers into the sensor_settings structure
    as this will make it easier to support devices that don't have
    this function.
  - add a fifo ops datastructure to allow for inter-part variations.
* max30100
  - fix i2c chip address in dt example
* max30102
  - use correct binding name for max30102 in example
* mma8452
  - Rename read/write event value callbacks to be more generic
    reflecting what they actually do now.
* rcar-gyroadc
  - pointer case to fix warnings when moving to 64 bit as this IP is
    present on new 64 bit SOCs
  - enable compile-testing to improve build coverage on this driver.
  - use the of_device_get_match_data helper instead of open coding
* sun4i-gpadc-iio
  - Register in the thermal framework after pm. Otherwise the IP is not
    enabled.
  - Don't fail probing if no thermal DT node is present.
* tsl2x7x
  - renaming tsl2x7x_settings to settings to avoid excessive line
    lengths.
  - Use IIO core to generate the integration_time sysfs attributes
    rather than hand rolling.
* vf6180
  - Move the range check on integration time to the setter function.
  - Refactor the code around integration time to be clearer including
    caching current integration time avoiding unnecessary chip reads.
  - cleanup the als_gain lookup avoiding reading registers on chip.
  - use rounded matching rather than precise values for als_gain
    lookup.
  - Correct the ALS  scale when non-default gain or integration time
    is used.

----------------------------------------------------------------
Aastha Gupta (1):
      staging: iio: adc: ad7192: use driver private lock to protect hardware state changes

Bartosz Golaszewski (1):
      iio: dummy: evgen: use irq_sim

Brian Masney (2):
      staging: iio: tsl2x7x: rename tsl2x7x_settings variable to settings
      staging: iio: tsl2x7x: migrate in_illuminance0_integration_time sysfs attribute to iio_chan_spec

Geert Uytterhoeven (3):
      iio: adc: rcar-gyroadc: Cast pointer to uintptr_t to fix warning on 64-bit
      iio: adc: rcar-gyroadc: Enable compile-testing on non-ARM
      iio: adc: rcar-gyroadc: Use of_device_get_match_data() helper

Gwendal Grignou (1):
      platform/chrome: Add cros_ec_accel_legacy driver

Harinath Nampally (1):
      iio: accel: mma8452: Rename read/write event value callbacks to generic function name.

Himanshi Jain (1):
      staging: iio: ade7753: expanding buffer lock to cover both buffer and state protection

Ismail H. Kose (2):
      iio:dac: Add DT binding documentation for ds4424
      iio: dac: ds4422/ds4424 dac driver

Lorenzo Bianconi (16):
      iio: imu: st_lsm6dsx: convert max_fifo_size in FIFO sample size
      iio: imu: st_lsm6dsx: split fifo mode and fifo odr configuration
      iio: imu: st_lsm6dsx: move decimator info in st_lsm6dsx_sensor_settings
      iio: imu: st_lsm6dsx: add FIFO ops data structure
      iio: st_sensors: add register mask for status register
      iio: st_sensors: decouple irq1 configuration parameters from the irq2 ones
      iio: st_sensors: do not always write enable_axis register
      iio: accel: add support to LIS2DW12
      dt-bindings: iio: accel: add LIS2DW12 sensor device binding
      iio: gyro: st_gyro: add SPI-3wire support to st_gyro framework
      iio: magnetometer: st_magn: add SPI-3wire support to LIS3MDL
      iio: pressure: st_pressure: add SPI-3wire support to st_pressure framework
      iio: st_sensors: split open-drain parameters for irq1 and irq2
      iio: common: st_sensors: check odr address value in st_sensors_set_odr()
      iio: accel: add support to LIS3DHH
      dt-bindings: iio: accel: add LIS3DHH device bindings

Lukas Wunner (2):
      iio: adc: mcp320x: Add support for mcp3550/1/3
      iio: Drop duplicate forward declaration

Michał Mirosław (6):
      iio: accel: kxcjk1003: refactor ODR setting
      iio: accel: kxcjk1013: fix INT_CTRL/INT_SRC1 bit names
      iio: accel: kxcjk1013: extract report_motion_event() from interrupt handler
      iio: accel: kxcjk1013: make sysfs/sampling_frequency_avail dynamic
      iio: accel: kxcjk1013: make sampling_frequency_avail per-type
      iio: accel: kxcjk1013: add support for KXTF9

Peter Meerwald-Stadler (4):
      Documentation: iio: Clarify meaning of IIO_DISTANCE channel type
      iio: proximity: Add rfd77402 driver
      dt-bindings: iio: health: Fix max30100 I2C chip address in example
      dt-bindings: iio: health: Use binding name for max30102 in example

Quentin Schulz (2):
      iio: adc: sun4i-gpadc-iio: register in the thermal after registering in pm
      iio: adc: sun4i-gpadc-iio: do not fail probing when no thermal DT node

Srinivas Pandruvada (1):
      iio: hid-sensor-trigger: Don't touch sensors unless user space requests

Stefan Brüns (5):
      iio: light: vl6180: Move range check to integration time setter, cleanup
      iio: light: vl6180: Avoid readback of integration time register
      iio: light: vl6180: Cleanup als_gain lookup, avoid register readback
      iio: light: vl6180: Correct ALS scale for non-default gain/integration time
      iio: adc: ina2xx: Adhere to documented ABI, use Ohm instead of uOhm

 Documentation/ABI/testing/sysfs-bus-iio            |   6 +-
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |  10 +
 .../devicetree/bindings/iio/dac/ds4424.txt         |  20 +
 .../devicetree/bindings/iio/health/max30100.txt    |   4 +-
 .../devicetree/bindings/iio/health/max30102.txt    |   2 +-
 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 drivers/iio/accel/Kconfig                          |  15 +-
 drivers/iio/accel/Makefile                         |   2 +
 drivers/iio/accel/cros_ec_accel_legacy.c           | 423 +++++++++++++++++++++
 drivers/iio/accel/kxcjk-1013.c                     | 354 ++++++++++-------
 drivers/iio/accel/mma8452.c                        |   8 +-
 drivers/iio/accel/st_accel.h                       |   4 +
 drivers/iio/accel/st_accel_core.c                  | 246 ++++++++++--
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |  10 +
 drivers/iio/adc/Kconfig                            |   7 +-
 drivers/iio/adc/ina2xx-adc.c                       |  18 +-
 drivers/iio/adc/mcp320x.c                          | 120 +++++-
 drivers/iio/adc/rcar-gyroadc.c                     |   7 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |  38 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  12 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  59 ++-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  16 +-
 drivers/iio/dac/Kconfig                            |   9 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ds4424.c                           | 341 +++++++++++++++++
 drivers/iio/dummy/Kconfig                          |   2 +-
 drivers/iio/dummy/iio_dummy_evgen.c                |  89 +----
 drivers/iio/gyro/st_gyro_core.c                    |  45 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  32 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  72 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  78 +++-
 drivers/iio/light/vl6180.c                         | 126 +++---
 drivers/iio/magnetometer/st_magn_core.c            |  20 +-
 drivers/iio/pressure/st_pressure_core.c            |  74 +++-
 drivers/iio/proximity/Kconfig                      |  10 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/rfd77402.c                   | 352 +++++++++++++++++
 drivers/staging/iio/adc/ad7192.c                   |   9 +-
 drivers/staging/iio/light/tsl2x7x.c                | 242 +++++-------
 drivers/staging/iio/meter/ade7753.c                |  29 +-
 include/linux/hid-sensor-hub.h                     |   1 +
 include/linux/iio/common/st_sensors.h              |  35 +-
 include/linux/iio/iio.h                            |   1 -
 44 files changed, 2330 insertions(+), 627 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ds4424.txt
 create mode 100644 drivers/iio/accel/cros_ec_accel_legacy.c
 create mode 100644 drivers/iio/dac/ds4424.c
 create mode 100644 drivers/iio/proximity/rfd77402.c
