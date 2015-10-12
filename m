Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50133 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbbJLRvR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2015 13:51:17 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] 2nd set of IIO new drivers, functionality and cleanups for the
 4.4 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561BF311.9090201@kernel.org>
Date: Mon, 12 Oct 2015 18:51:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit d0a76bbfe920e056e761bfcb77f3b95bd3bce98f:

  staging: iio: iio_dummy_evgen: handle_simple_irq() build fix (2015-09-30 03:46:43 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.4b

for you to fetch changes up to 801ab33596f3e2a70a3b3599618d966736299014:

  iio:light:apds9960 Fix sparse endian warnings. (2015-10-12 18:21:38 +0100)

----------------------------------------------------------------
Second set of new drivers, functionality and cleanups for IIO in the 4.4 cycle.

Core stuff
* adjust resistance documentation to allow for output devices.

New device support:
* bmc150
 - split the i2c driver up into a core and i2c_regmap part including regmap
   conversion.
 - add spi support.
* mcp4531 digitial potentiometer driver.
* Measurement Specialties set of drivers with a core library module providing
  common functionality.  Note that the htu21 has a driver in hwmon, but the
  view from that side was that, given the range of devices the same silicon
  turns up in are not all typical hwmon material, that driver would be
  deprecated in favour of this new support.
 - ms8607 temperature, pressure and humidty sensor
 - ms5637 temperature and pressure sensor
 - htu21 temperature and humidity sensor
 - tsys02d temperature sensor
 - tsys01 temperature sensor

Cleanups
* tree wide.
 - squish cases where irq 0 is still considered valid.
* apds9960
 - sparse endian warning cleanups by making endianness explicit.
* ad5504
 - leave group naming to the core.
* ad7746
 - cleanup comment style.
 - drop an unnecessary bit of dev_info
 - add some appropriate uses of the BIT macro.
* ad799x
 - leave group naming to the core.
* hdc100x - introduced this cycle,.
 - fix a wrong offset value.
* lidar
 - add missing MODULE_DEVICE_TABLE for dt.
* max1363
 - leave sysfs group naming to the core.
* m62332 got the Harmut treatment and as ever he found a 'few' bits the
  rest of us had missed!
 - Share scale and offset attributes across channels.
 - Shutdown the device on driver remove
 - Use ARRAY_SIZE rather than a hard coded count for channels.
 - Return more directly in the write_raw callback dropping a local variable
   along the way.
 - a few style issues
 - move to reading the regulator voltage for each use allowing for dynamic
   regulators.  This is a common feature across drivers so we might end
   up with more fixes throughout the tree for this.
* mlx96014 - introduced this cycle.
 - fixed up a spot of error handling.
* vz89x - introduced this cycle.
 - work around a hardware quirk.

----------------------------------------------------------------
Crt Mori (1):
      iio: mlx96014: Error checking from positive to negative

Hartmut Knaack (6):
      iio:dac:m62332: share scale and offset
      iio:dac:m62332: shutdown on remove
      iio:dac:m62332: use ARRAY_SIZE
      iio:dac:m62332: drop unrequired variable
      iio:dac:m62332: address some style issues
      iio:dac:m62332: use dynamic scale

Hugo Camboulive (1):
      staging: iio: adc: fix comment block coding style issue

Jonathan Cameron (2):
      iio:measurement specialties core: Fix endian sparse warnings.
      iio:light:apds9960 Fix sparse endian warnings.

Ludovic Tancerel (6):
      Add meas-spec sensors common part
      Add tsys01 meas-spec driver support
      Add tsys02d meas-spec driver support
      Add htu21 meas-spec driver support
      Add ms5637 meas-spec driver support
      Add ms8607 meas-spec driver support

Markus Pargmann (4):
      iio: bmc150: Use i2c regmap
      iio: bcm150: Remove i2c_client from private data
      iio: bmc150: Split the driver into core and i2c
      iio: bmc150: Add SPI driver

Martin Kepplinger (3):
      iio: adc: ad799x: leave sysfs naming to the core
      iio: adc: max1363: leave sysfs naming to the core
      iio: dac: ad5504: leave sysfs naming to the core

Matt Ranostay (3):
      iio: chemical: vz89x hardware i2c workaround
      iio: lidar: add missing MODULE_DEVICE_TABLE for dt
      iio: hdc100x: correct IIO_CHAN_INFO_OFFSET value

Octavian Purdila (2):
      iio: fix drivers that use 0 as a valid IRQ in client->irq (part 2)
      iio: remove gpio interrupt probing from drivers that use a single interrupt

Peter Rosin (2):
      iio: resistance: Document that resistance can be output
      iio: mcp4531: Driver for Microchip digital potentiometers

Shraddha Barke (2):
      Staging: iio: cdc: Prefer using the BIT macro
      Staging: iio: cdc: Remove unnecessary dev_info

 Documentation/ABI/testing/sysfs-bus-iio            |  12 +
 Documentation/ABI/testing/sysfs-bus-iio-meas-spec  |   8 +
 MAINTAINERS                                        |   6 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/Kconfig                          |  14 +-
 drivers/iio/accel/Makefile                         |   4 +-
 .../accel/{bmc150-accel.c => bmc150-accel-core.c}  | 407 +++++--------
 drivers/iio/accel/bmc150-accel-i2c.c               | 102 ++++
 drivers/iio/accel/bmc150-accel-spi.c               |  91 +++
 drivers/iio/accel/bmc150-accel.h                   |  20 +
 drivers/iio/accel/kxcjk-1013.c                     |  34 +-
 drivers/iio/accel/mma9553.c                        |  29 -
 drivers/iio/accel/stk8312.c                        |  30 +-
 drivers/iio/accel/stk8ba50.c                       |  30 +-
 drivers/iio/adc/ad799x.c                           |   1 -
 drivers/iio/adc/max1363.c                          |   1 -
 drivers/iio/chemical/vz89x.c                       |  23 +-
 drivers/iio/common/Kconfig                         |   1 +
 drivers/iio/common/Makefile                        |   1 +
 drivers/iio/common/ms_sensors/Kconfig              |   6 +
 drivers/iio/common/ms_sensors/Makefile             |   5 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     | 652 +++++++++++++++++++++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h     |  66 +++
 drivers/iio/dac/ad5504.c                           |   1 -
 drivers/iio/dac/m62332.c                           |  63 +-
 drivers/iio/humidity/Kconfig                       |  13 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc100x.c                     |   5 +-
 drivers/iio/humidity/htu21.c                       | 253 ++++++++
 drivers/iio/imu/kmx61.c                            |  28 -
 drivers/iio/light/apds9960.c                       |   6 +-
 drivers/iio/light/stk3310.c                        |  35 +-
 drivers/iio/magnetometer/bmc150_magn.c             |  29 -
 drivers/iio/potentiometer/Kconfig                  |  20 +
 drivers/iio/potentiometer/Makefile                 |   6 +
 drivers/iio/potentiometer/mcp4531.c                | 231 ++++++++
 drivers/iio/pressure/Kconfig                       |  13 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/ms5637.c                      | 190 ++++++
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   1 +
 drivers/iio/proximity/sx9500.c                     |   9 -
 drivers/iio/temperature/Kconfig                    |  22 +
 drivers/iio/temperature/Makefile                   |   2 +
 drivers/iio/temperature/mlx90614.c                 |  14 +-
 drivers/iio/temperature/tsys01.c                   | 230 ++++++++
 drivers/iio/temperature/tsys02d.c                  | 191 ++++++
 drivers/staging/iio/cdc/ad7746.c                   |  22 +-
 48 files changed, 2390 insertions(+), 541 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-meas-spec
 rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c} (81%)
 create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
 create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
 create mode 100644 drivers/iio/accel/bmc150-accel.h
 create mode 100644 drivers/iio/common/ms_sensors/Kconfig
 create mode 100644 drivers/iio/common/ms_sensors/Makefile
 create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.c
 create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.h
 create mode 100644 drivers/iio/humidity/htu21.c
 create mode 100644 drivers/iio/potentiometer/Kconfig
 create mode 100644 drivers/iio/potentiometer/Makefile
 create mode 100644 drivers/iio/potentiometer/mcp4531.c
 create mode 100644 drivers/iio/pressure/ms5637.c
 create mode 100644 drivers/iio/temperature/tsys01.c
 create mode 100644 drivers/iio/temperature/tsys02d.c
