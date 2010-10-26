Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org
Subject: [PATCH 00/36 v2] staging: iio: ADI drivers for staging-next
Date: Tue, 26 Oct 2010 14:17:10 -0400
Message-Id: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

Changes since previous patchset:
	- dropped drives duplicated with hwmon
		- AD7414
		- AD7416
		- ADT7408
	- addressed a bunch of random feedback across most drivers
		- renamed ad774x.c to ad7745.c
		- renamed adis16261* to adis16251*
		- improve Kconfig text to help out `grep`
		- fix up abi in a few places
		- add some error checking
		- disable ring buffer support when missing
		- drop i2c irq_flags for now
	- added Jonathan's Acked-by tag
	- added ADI e-mail info to TODO

Hopefully there shouldn't be any roadblocks now before pushing to GregKH.
I'll do so in a day or two if there aren't any issues.

Barry Song (16):
  staging: iio: new adis16201 driver
  staging: iio: new adis16203 driver
  staging: iio: new adis16204 driver
  staging: iio: adc: new driver for AD7150/1/6 devices
  staging: iio: adc: new driver for AD7152/3 devices
  staging: iio: adc: new driver for AD7745/6/7 devices
  staging: iio: gyro: new driver for ADIS16251 devices
  staging: iio: gyro: new driver for ADIS16060 digital output gyros
  staging: iio: gyro: new driver for ADIS16080 digital output gyros
  staging: iio: gyro: new driver for ADIS16130 digital output gyros
  staging: iio: dac: new driver for AD5624R devices
  staging: iio: meter: new driver for ADE7753/6 devices
  staging: iio: meter: new driver for ADE7754 devices
  staging: iio: meter: new driver for ADE7758 devices
  staging: iio: meter: new driver for ADE7759 devices
  staging: iio: meter: new driver for ADE7854/58/68/78 devices

Cliff Cai (6):
  staging: iio: dds: new driver for AD5930/2 devices
  staging: iio: dds: new driver for AD9832/3/4/5 devices
  staging: iio: dds: new driver for AD9850/1 devices
  staging: iio: dds: new driver for AD9852/4 devices
  staging: iio: dds: new driver for AD9910 devices
  staging: iio: dds: new driver for AD9951 devices

Graf Yang (3):
  staging: iio: resolver: new driver for AD2S90 devices
  staging: iio: resolver: new driver for AD2S1200/1205 devices
  staging: iio: resolver: new driver for AD2S1210 devices

Michael Hennerich (1):
  staging: iio: gyro: make sure grep can find the ADIS16265 support

Mike Frysinger (2):
  staging: iio: adis16350: add missing reference to temp offset
  staging: iio: add ADI info to TODO

Sonic Zhang (8):
  staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver
  staging: iio: adc: new driver for AD7291 devices
  staging: iio: adc: new driver for AD7298 devices
  staging: iio: adc: new driver for AD7314 devices
  staging: iio: adc: new driver for AD7816 devices
  staging: iio: adc: new driver for ADT75 temperature sensors
  staging: iio: adc: new driver for ADT7310 temperature sensors
  staging: iio: adc: new driver for ADT7410 temperature sensors

 drivers/staging/iio/Kconfig                   |    6 +-
 drivers/staging/iio/Makefile                  |    7 +-
 drivers/staging/iio/TODO                      |    4 +
 drivers/staging/iio/accel/Kconfig             |   27 +
 drivers/staging/iio/accel/Makefile            |   12 +
 drivers/staging/iio/accel/accel.h             |   20 +
 drivers/staging/iio/accel/adis16201.h         |  150 ++
 drivers/staging/iio/accel/adis16201_core.c    |  659 +++++++
 drivers/staging/iio/accel/adis16201_ring.c    |  218 +++
 drivers/staging/iio/accel/adis16201_trigger.c |  122 ++
 drivers/staging/iio/accel/adis16203.h         |  143 ++
 drivers/staging/iio/accel/adis16203_core.c    |  568 ++++++
 drivers/staging/iio/accel/adis16203_ring.c    |  211 +++
 drivers/staging/iio/accel/adis16203_trigger.c |  122 ++
 drivers/staging/iio/accel/adis16204.h         |  151 ++
 drivers/staging/iio/accel/adis16204_core.c    |  613 +++++++
 drivers/staging/iio/accel/adis16204_ring.c    |  206 +++
 drivers/staging/iio/accel/adis16204_trigger.c |  122 ++
 drivers/staging/iio/adc/Kconfig               |   77 +-
 drivers/staging/iio/adc/Makefile              |   11 +
 drivers/staging/iio/adc/ad7150.c              |  877 +++++++++
 drivers/staging/iio/adc/ad7152.c              |  610 +++++++
 drivers/staging/iio/adc/ad7291.c              | 1039 +++++++++++
 drivers/staging/iio/adc/ad7298.c              |  501 +++++
 drivers/staging/iio/adc/ad7314.c              |  308 ++++
 drivers/staging/iio/adc/ad7745.c              |  734 ++++++++
 drivers/staging/iio/adc/ad7816.c              |  535 ++++++
 drivers/staging/iio/adc/adt7310.c             |  952 ++++++++++
 drivers/staging/iio/adc/adt7410.c             |  915 ++++++++++
 drivers/staging/iio/adc/adt75.c               |  732 ++++++++
 drivers/staging/iio/addac/Kconfig             |   25 +
 drivers/staging/iio/addac/Makefile            |    7 +
 drivers/staging/iio/addac/adt7316-i2c.c       |  170 ++
 drivers/staging/iio/addac/adt7316-spi.c       |  180 ++
 drivers/staging/iio/addac/adt7316.c           | 2402 +++++++++++++++++++++++++
 drivers/staging/iio/addac/adt7316.h           |   33 +
 drivers/staging/iio/dac/Kconfig               |   11 +
 drivers/staging/iio/dac/Makefile              |    5 +
 drivers/staging/iio/dac/ad5624r.h             |   21 +
 drivers/staging/iio/dac/ad5624r_spi.c         |  313 ++++
 drivers/staging/iio/dac/dac.h                 |    6 +
 drivers/staging/iio/dds/Kconfig               |   46 +
 drivers/staging/iio/dds/Makefile              |   10 +
 drivers/staging/iio/dds/ad5930.c              |  170 ++
 drivers/staging/iio/dds/ad9832.c              |  266 +++
 drivers/staging/iio/dds/ad9850.c              |  156 ++
 drivers/staging/iio/dds/ad9852.c              |  314 ++++
 drivers/staging/iio/dds/ad9910.c              |  454 +++++
 drivers/staging/iio/dds/ad9951.c              |  254 +++
 drivers/staging/iio/gyro/Kconfig              |   38 +-
 drivers/staging/iio/gyro/Makefile             |   12 +
 drivers/staging/iio/gyro/adis16060.h          |  101 +
 drivers/staging/iio/gyro/adis16060_core.c     |  319 ++++
 drivers/staging/iio/gyro/adis16080.h          |  102 ++
 drivers/staging/iio/gyro/adis16080_core.c     |  271 +++
 drivers/staging/iio/gyro/adis16130.h          |  108 ++
 drivers/staging/iio/gyro/adis16130_core.c     |  313 ++++
 drivers/staging/iio/gyro/adis16251.h          |  185 ++
 drivers/staging/iio/gyro/adis16251_core.c     |  777 ++++++++
 drivers/staging/iio/gyro/adis16260_core.c     |    2 +-
 drivers/staging/iio/imu/adis16350_core.c      |    1 +
 drivers/staging/iio/meter/Kconfig             |   61 +
 drivers/staging/iio/meter/Makefile            |   15 +
 drivers/staging/iio/meter/ade7753.c           |  730 ++++++++
 drivers/staging/iio/meter/ade7753.h           |  140 ++
 drivers/staging/iio/meter/ade7754.c           |  756 ++++++++
 drivers/staging/iio/meter/ade7754.h           |  161 ++
 drivers/staging/iio/meter/ade7758.h           |  171 ++
 drivers/staging/iio/meter/ade7758_core.c      |  866 +++++++++
 drivers/staging/iio/meter/ade7758_ring.c      |  212 +++
 drivers/staging/iio/meter/ade7758_trigger.c   |  125 ++
 drivers/staging/iio/meter/ade7759.c           |  670 +++++++
 drivers/staging/iio/meter/ade7759.h           |  122 ++
 drivers/staging/iio/meter/ade7854-i2c.c       |  272 +++
 drivers/staging/iio/meter/ade7854-spi.c       |  360 ++++
 drivers/staging/iio/meter/ade7854.c           |  680 +++++++
 drivers/staging/iio/meter/ade7854.h           |  245 +++
 drivers/staging/iio/meter/meter.h             |  396 ++++
 drivers/staging/iio/resolver/Kconfig          |   54 +
 drivers/staging/iio/resolver/Makefile         |    7 +
 drivers/staging/iio/resolver/ad2s120x.c       |  310 ++++
 drivers/staging/iio/resolver/ad2s1210.c       |  872 +++++++++
 drivers/staging/iio/resolver/ad2s90.c         |  159 ++
 drivers/staging/iio/sysfs.h                   |    6 +
 84 files changed, 25107 insertions(+), 7 deletions(-)
 create mode 100644 drivers/staging/iio/accel/adis16201.h
 create mode 100644 drivers/staging/iio/accel/adis16201_core.c
 create mode 100644 drivers/staging/iio/accel/adis16201_ring.c
 create mode 100644 drivers/staging/iio/accel/adis16201_trigger.c
 create mode 100644 drivers/staging/iio/accel/adis16203.h
 create mode 100644 drivers/staging/iio/accel/adis16203_core.c
 create mode 100644 drivers/staging/iio/accel/adis16203_ring.c
 create mode 100644 drivers/staging/iio/accel/adis16203_trigger.c
 create mode 100644 drivers/staging/iio/accel/adis16204.h
 create mode 100644 drivers/staging/iio/accel/adis16204_core.c
 create mode 100644 drivers/staging/iio/accel/adis16204_ring.c
 create mode 100644 drivers/staging/iio/accel/adis16204_trigger.c
 create mode 100644 drivers/staging/iio/adc/ad7150.c
 create mode 100644 drivers/staging/iio/adc/ad7152.c
 create mode 100644 drivers/staging/iio/adc/ad7291.c
 create mode 100644 drivers/staging/iio/adc/ad7298.c
 create mode 100644 drivers/staging/iio/adc/ad7314.c
 create mode 100644 drivers/staging/iio/adc/ad7745.c
 create mode 100644 drivers/staging/iio/adc/ad7816.c
 create mode 100644 drivers/staging/iio/adc/adt7310.c
 create mode 100644 drivers/staging/iio/adc/adt7410.c
 create mode 100644 drivers/staging/iio/adc/adt75.c
 create mode 100644 drivers/staging/iio/addac/Kconfig
 create mode 100644 drivers/staging/iio/addac/Makefile
 create mode 100644 drivers/staging/iio/addac/adt7316-i2c.c
 create mode 100644 drivers/staging/iio/addac/adt7316-spi.c
 create mode 100644 drivers/staging/iio/addac/adt7316.c
 create mode 100644 drivers/staging/iio/addac/adt7316.h
 create mode 100644 drivers/staging/iio/dac/Kconfig
 create mode 100644 drivers/staging/iio/dac/Makefile
 create mode 100644 drivers/staging/iio/dac/ad5624r.h
 create mode 100644 drivers/staging/iio/dac/ad5624r_spi.c
 create mode 100644 drivers/staging/iio/dac/dac.h
 create mode 100644 drivers/staging/iio/dds/Kconfig
 create mode 100644 drivers/staging/iio/dds/Makefile
 create mode 100644 drivers/staging/iio/dds/ad5930.c
 create mode 100644 drivers/staging/iio/dds/ad9832.c
 create mode 100644 drivers/staging/iio/dds/ad9850.c
 create mode 100644 drivers/staging/iio/dds/ad9852.c
 create mode 100644 drivers/staging/iio/dds/ad9910.c
 create mode 100644 drivers/staging/iio/dds/ad9951.c
 create mode 100644 drivers/staging/iio/gyro/adis16060.h
 create mode 100644 drivers/staging/iio/gyro/adis16060_core.c
 create mode 100644 drivers/staging/iio/gyro/adis16080.h
 create mode 100644 drivers/staging/iio/gyro/adis16080_core.c
 create mode 100644 drivers/staging/iio/gyro/adis16130.h
 create mode 100644 drivers/staging/iio/gyro/adis16130_core.c
 create mode 100644 drivers/staging/iio/gyro/adis16251.h
 create mode 100644 drivers/staging/iio/gyro/adis16251_core.c
 create mode 100644 drivers/staging/iio/meter/Kconfig
 create mode 100644 drivers/staging/iio/meter/Makefile
 create mode 100644 drivers/staging/iio/meter/ade7753.c
 create mode 100644 drivers/staging/iio/meter/ade7753.h
 create mode 100644 drivers/staging/iio/meter/ade7754.c
 create mode 100644 drivers/staging/iio/meter/ade7754.h
 create mode 100644 drivers/staging/iio/meter/ade7758.h
 create mode 100644 drivers/staging/iio/meter/ade7758_core.c
 create mode 100644 drivers/staging/iio/meter/ade7758_ring.c
 create mode 100644 drivers/staging/iio/meter/ade7758_trigger.c
 create mode 100644 drivers/staging/iio/meter/ade7759.c
 create mode 100644 drivers/staging/iio/meter/ade7759.h
 create mode 100644 drivers/staging/iio/meter/ade7854-i2c.c
 create mode 100644 drivers/staging/iio/meter/ade7854-spi.c
 create mode 100644 drivers/staging/iio/meter/ade7854.c
 create mode 100644 drivers/staging/iio/meter/ade7854.h
 create mode 100644 drivers/staging/iio/meter/meter.h
 create mode 100644 drivers/staging/iio/resolver/Kconfig
 create mode 100644 drivers/staging/iio/resolver/Makefile
 create mode 100644 drivers/staging/iio/resolver/ad2s120x.c
 create mode 100644 drivers/staging/iio/resolver/ad2s1210.c
 create mode 100644 drivers/staging/iio/resolver/ad2s90.c

-- 
1.7.3.2
