Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42810 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbcGEUpA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2016 16:45:00 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] Third round of new device support, features and cleanups for
 IIO in the 4.8 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8666260f-a196-7e16-a318-6678bc24fad0@kernel.org>
Date: Tue, 5 Jul 2016 21:44:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 3c9a6793bde1feb368cd6ef113c08a40a37f7517:

  Merge tag 'iio-for-4.8b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2016-06-29 15:35:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.8c

for you to fetch changes up to 0ddfd857130d16b1fb1e45c5ab2321a65738d70b:

  drivers:iio:accel:mma8452: removed unwanted return statements (2016-07-05 21:05:01 +0100)

----------------------------------------------------------------
Third set of IIO new device support, features and cleanups for the 4.8 cycle.

New core features
- Selection of the clock source for IIO timestamps.  This is done per device
  as it makes little sense to have events in one timebase and data timestamped
  on another.  Biggest reason for this is that we currently use a clock
  source which is non monotonic which can result in 'interesting' data sets.
  (Includes export for get_monotonic_corse64 which Thomas Gleixner didn't mind
   in an earlier version.)
- MAINTAINERS add the git tree to the list for IIO.

New device support + a kind of indirect staging graduation.
* Broadcom iproc-static-adc
  - new driver
* mcp4531
  - support for MCP454x, MCP456x, MCP464x and MCP466x potentiometers
* mpu6050
  - support the IC20608 6 axis motion tracking device
* st-sensors
  - support the lis3l02dq + drop the lis3l02dq driver from staging.
  The general purpose driver is missing event support, but good to get
  rid of this driver which was rather long in the tooth.

New driver features
* ak8975
  - Add vid regulator support and refactor handling in general.
  - Allow a delay after enabling regulators.
  - Runtime and system PM.
* bmg160
  - filter frequency control support.
* bmp280
  - SPI device support.
  - EOC interrupt support for the BMP085
  - power management support.
  - supply regulator support.
  - reset gpio support
  - dt bindings for reset gpio and regulators.
  - of table to support device tree registration
* max1363
  - Device tree bindings.
* mcp4531
  - Device tree bindings.
* st-pressure
  - temperature channels as part of triggered buffer (previously not due
  probably to alignment issues - see below).
  - lps22hb open drain interrupt support.
  - lps22hb temperature channel support

Cleanups and reworkings.
* numerous ADC drivers
  - ensure the iio_dev->dev.of_node is set to the parent dev.of_node so
  as to allow client bindings to find the device.
* ak8975
  - Fix incorrect handling of missing regulator
  - make sure power is down and remove.
* bmp280
  - read the calibration data only once as it doesn't change.
* isl29125
  - Use a few macros to make code a touch more readable.
* mma8452
  - fix a memory leak on error.
  - drop an unecessary bit of return value handling.
* potentiometer kconfig
  - typo fix.
* st-pressure
  - drop some uninformative default assignments of elements of the channel
  array structure (aids readability).
* st-sensors
  - Harden interrupt handling considerably.  These are actually all using
  level interrupts, but at least two known boards have them wired to
  edge only interrupt chips.  Hence a slightly interesting bit of handling
  is needed in which we first allow for the easy option (level triggered) and
  secondly check the status registers before reenabling edge interrupts and
  fall back to a tight loop in the thread until we successfully clear the
  interrupt.  No harm is done if we never succeed in doing so.  It's an odd
  patch that has been through a lot of revisions to reach a consensus on how
  to handle what is basically broken hardware (which the previous defaults
  allowed to kind of work).
  - Fix alignment to defined storagebytes boundaries.
  - Ensure alignment of power of 2 byte boundaries.  This has always in theory
  been part of the ABI of IIO, but we missed a few that snuck in that need
  fixing.  The effect was minor as they were only followed by timestamp
  channels which were correctly aligned,
  - Add some docs to explain the gain calculations.

----------------------------------------------------------------
Bijosh Thykkoottathil (3):
      drivers:iio:light:isl29125: added macros for sensing range
      drivers:iio:accel:mma8452: added cleanup provision in case of failure.
      drivers:iio:accel:mma8452: removed unwanted return statements

Florian Vaussard (6):
      iio: adc: max1363: Add device tree binding documentation
      iio: adc: max1363: Add device tree binding
      iio: potentiometer: mcp4531: Add support for MCP454x, MCP456x, MCP464x and MCP466x
      iio: potentiometer: mcp4531: Add device tree binding documentation
      iio: potentiometer: mcp4531: Add device tree binding
      iio: potentiometer: Fix typo in Kconfig

Gregor Boirie (10):
      timekeeping: export get_monotonic_coarse64 symbol
      iio:core: timestamping clock selection support
      iio:imu:mpu6050: icm20608 initial support
      iio:st_sensors: align on storagebits boundaries
      iio:st_pressure: align storagebits on power of 2
      iio:st_pressure: document sampling gains
      iio:st_pressure: temperature triggered buffering
      iio:st_pressure:lps22hb: open drain support
      iio:st_pressure:lps22hb: temperature support
      iio:st_pressure: clean useless static channel initializers

Jonathan Cameron (3):
      iio: accel: st_accel: Add lis3l02dq support
      staging:iio:lis3l02dq drop separate driver
      iio: Add iio.git tree to MAINTAINERS

Linus Walleij (17):
      iio: pressure: bmp280: augment DT bindings
      iio: pressure: bmp280: support device tree initialization
      iio: pressure: bmp280: add reset GPIO line handling
      iio: magn: ak8975: fix regulator usage
      iio: magn: ak8975: add Vid regulator
      iio: magn: ak8975: refactor regulator handlers
      iio: magn: ak8975: allow a delay after enabling regulators
      iio: magn: ak8975: make sure to power down at remove()
      iio: magn: ak8975: deploy runtime and system PM
      iio: st_sensors: harden interrupt handling
      iio: pressure: bmp280: support supply regulators
      iio: pressure: bmp280: split driver in logical parts
      iio: pressure: bmp280: split off an I2C Kconfig entry
      iio: pressure: bmp280: add SPI interface driver
      iio: pressure: bmp280: add support for BMP085 EOC interrupt
      iio: pressure: bmp280: add power management
      iio: pressure: bmp280: read calibration data once

Matt Ranostay (2):
      iio: adc: ti-ads1015: add indio_dev->dev.of_node reference
      iio: adc: add missing of_node references to iio_dev

Raveendra Padasalagi (2):
      Documentation: DT: Add iproc-static-adc binding
      iio: Add driver for Broadcom iproc-static-adc

Steffen Trumtrar (1):
      iio: bmg160: add callbacks for the filter frequency

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 Documentation/DocBook/iio.tmpl                     |   2 +-
 .../devicetree/bindings/i2c/trivial-devices.txt    |  64 ++
 .../bindings/iio/adc/brcm,iproc-static-adc.txt     |  41 ++
 .../devicetree/bindings/iio/adc/max1363.txt        |  63 ++
 .../devicetree/bindings/iio/pressure/bmp085.txt    |  15 +-
 MAINTAINERS                                        |   1 +
 drivers/iio/accel/bma180.c                         |   2 +-
 drivers/iio/accel/bmc150-accel-core.c              |   4 +-
 drivers/iio/accel/kxcjk-1013.c                     |   2 +-
 drivers/iio/accel/mma7455_core.c                   |   3 +-
 drivers/iio/accel/mma8452.c                        |  14 +-
 drivers/iio/accel/mma9551.c                        |   2 +-
 drivers/iio/accel/mma9553.c                        |   2 +-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |  64 ++
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   1 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7266.c                           |   1 +
 drivers/iio/adc/ad7291.c                           |   3 +-
 drivers/iio/adc/ad7298.c                           |   3 +-
 drivers/iio/adc/ad7476.c                           |   3 +-
 drivers/iio/adc/ad7791.c                           |   1 +
 drivers/iio/adc/ad7793.c                           |   1 +
 drivers/iio/adc/ad7887.c                           |   3 +-
 drivers/iio/adc/ad7923.c                           |   3 +-
 drivers/iio/adc/ad799x.c                           |   5 +-
 drivers/iio/adc/bcm_iproc_adc.c                    | 644 ++++++++++++++++
 drivers/iio/adc/cc10001_adc.c                      |   2 +-
 drivers/iio/adc/hi8435.c                           |   3 +-
 drivers/iio/adc/ina2xx-adc.c                       |   7 +-
 drivers/iio/adc/max1027.c                          |   1 +
 drivers/iio/adc/max1363.c                          |  67 +-
 drivers/iio/adc/mcp320x.c                          |   1 +
 drivers/iio/adc/mcp3422.c                          |   1 +
 drivers/iio/adc/nau7802.c                          |   1 +
 drivers/iio/adc/ti-adc081c.c                       |   4 +-
 drivers/iio/adc/ti-adc0832.c                       |   1 +
 drivers/iio/adc/ti-adc128s052.c                    |   1 +
 drivers/iio/adc/ti-ads1015.c                       |   4 +-
 drivers/iio/adc/ti-ads8688.c                       |   1 +
 drivers/iio/adc/vf610_adc.c                        |   3 +-
 drivers/iio/adc/xilinx-xadc-events.c               |   4 +-
 drivers/iio/chemical/atlas-ph-sensor.c             |   2 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |  46 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  28 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 156 ++--
 drivers/iio/dac/ad5421.c                           |   6 +-
 drivers/iio/dac/ad5504.c                           |   2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |   3 +-
 drivers/iio/dummy/iio_simple_dummy_events.c        |   2 +-
 drivers/iio/gyro/bmg160_core.c                     | 138 +++-
 drivers/iio/iio_core.h                             |   3 +
 drivers/iio/imu/bmi160/bmi160_core.c               |   3 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |   8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   1 +
 drivers/iio/industrialio-core.c                    | 179 ++++-
 drivers/iio/industrialio-event.c                   |  19 +-
 drivers/iio/industrialio-trigger.c                 |   2 +-
 drivers/iio/light/acpi-als.c                       |   2 +-
 drivers/iio/light/adjd_s311.c                      |   2 +-
 drivers/iio/light/apds9300.c                       |   2 +-
 drivers/iio/light/apds9960.c                       |   4 +-
 drivers/iio/light/cm36651.c                        |   2 +-
 drivers/iio/light/gp2ap020a00f.c                   |   8 +-
 drivers/iio/light/isl29125.c                       |  13 +-
 drivers/iio/light/lm3533-als.c                     |   2 +-
 drivers/iio/light/ltr501.c                         |   7 +-
 drivers/iio/light/max44000.c                       |   3 +-
 drivers/iio/light/opt3001.c                        |   4 +-
 drivers/iio/light/stk3310.c                        |   2 +-
 drivers/iio/light/tcs3414.c                        |   2 +-
 drivers/iio/light/tcs3472.c                        |   2 +-
 drivers/iio/light/tsl2563.c                        |   2 +-
 drivers/iio/light/us5182d.c                        |   2 +-
 drivers/iio/magnetometer/ak8975.c                  | 134 +++-
 drivers/iio/magnetometer/hmc5843_core.c            |   2 +-
 drivers/iio/magnetometer/mag3110.c                 |   2 +-
 drivers/iio/potentiometer/Kconfig                  |  12 +-
 drivers/iio/potentiometer/mcp4531.c                | 159 +++-
 drivers/iio/pressure/Kconfig                       |  28 +-
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/{bmp280.c => bmp280-core.c}   | 573 ++++++++-------
 drivers/iio/pressure/bmp280-i2c.c                  |  91 +++
 drivers/iio/pressure/bmp280-regmap.c               |  84 +++
 drivers/iio/pressure/bmp280-spi.c                  | 125 ++++
 drivers/iio/pressure/bmp280.h                      | 112 +++
 drivers/iio/pressure/mpl3115.c                     |   2 +-
 drivers/iio/pressure/ms5611_core.c                 |   3 +-
 drivers/iio/pressure/st_pressure_core.c            | 155 +++-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   2 +-
 drivers/iio/proximity/sx9500.c                     |   4 +-
 drivers/staging/iio/accel/Kconfig                  |  14 -
 drivers/staging/iio/accel/Makefile                 |   4 -
 drivers/staging/iio/accel/lis3l02dq.h              | 217 ------
 drivers/staging/iio/accel/lis3l02dq_core.c         | 814 ---------------------
 drivers/staging/iio/accel/lis3l02dq_ring.c         | 428 -----------
 drivers/staging/iio/accel/sca3000_core.c           |   2 +-
 drivers/staging/iio/adc/ad7280a.c                  |   8 +-
 drivers/staging/iio/adc/ad7606_ring.c              |   3 +-
 drivers/staging/iio/adc/ad7816.c                   |   3 +-
 drivers/staging/iio/addac/adt7316.c                |   4 +-
 drivers/staging/iio/cdc/ad7150.c                   |   2 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |   2 +-
 include/linux/iio/common/st_sensors.h              |   2 +
 include/linux/iio/iio.h                            |  22 +-
 kernel/time/timekeeping.c                          |   1 +
 113 files changed, 2714 insertions(+), 2045 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt
 create mode 100644 drivers/iio/adc/bcm_iproc_adc.c
 rename drivers/iio/pressure/{bmp280.c => bmp280-core.c} (73%)
 create mode 100644 drivers/iio/pressure/bmp280-i2c.c
 create mode 100644 drivers/iio/pressure/bmp280-regmap.c
 create mode 100644 drivers/iio/pressure/bmp280-spi.c
 create mode 100644 drivers/iio/pressure/bmp280.h
 delete mode 100644 drivers/staging/iio/accel/lis3l02dq.h
 delete mode 100644 drivers/staging/iio/accel/lis3l02dq_core.c
 delete mode 100644 drivers/staging/iio/accel/lis3l02dq_ring.c
