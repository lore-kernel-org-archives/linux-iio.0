Return-Path: <SRS0=2QgY=4U=gmail.com=alexander.sverdlin@kernel.org>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 0/5] iio: ADC driver for EP93xx SoC
Date: Sun, 14 May 2017 11:29:49 +0200
Message-Id: <20170514092954.12790-1-alexander.sverdlin@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This series prepares the necessary infrastructure for ADC platform device on
Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
IIO subsystem.

Changelog
v3:
  Rebased to the current master
  sizeof(struct foo) -> sizeof(*bar)
v2:
  Added Documentation/iio/ep93xx_adc.txt
  Removed extend_name
  Added timeout to the status polling loop
  Used iio_device_register() instead of devm_iio_device_register()

Alexander Sverdlin (5):
  clk: ep93xx: Implement clk_get_parent()
  clk: ep93xx: Add ADC clock
  ep93xx: Add ADC platform device support to core
  edb93xx: Add ADC platform device
  iio: adc: New driver for Cirrus Logic EP93xx ADC

 Documentation/iio/ep93xx_adc.txt             |  29 +++
 arch/arm/mach-ep93xx/clock.c                 |  14 ++
 arch/arm/mach-ep93xx/core.c                  |  24 +++
 arch/arm/mach-ep93xx/edb93xx.c               |   1 +
 arch/arm/mach-ep93xx/include/mach/platform.h |   1 +
 arch/arm/mach-ep93xx/soc.h                   |   1 +
 drivers/iio/adc/Kconfig                      |  11 ++
 drivers/iio/adc/Makefile                     |   1 +
 drivers/iio/adc/ep93xx_adc.c                 | 260 +++++++++++++++++++++++++++
 9 files changed, 342 insertions(+)
 create mode 100644 Documentation/iio/ep93xx_adc.txt
 create mode 100644 drivers/iio/adc/ep93xx_adc.c

-- 
2.12.2
