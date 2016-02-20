Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37418 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbcBTR7l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Feb 2016 12:59:41 -0500
Received: by mail-wm0-f48.google.com with SMTP id g62so111550114wme.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Feb 2016 09:59:40 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH v2 0/5] iio: ADC driver for EP93xx SoC
To: Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Message-ID: <56C8A989.9030801@gmail.com>
Date: Sat, 20 Feb 2016 18:59:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series prepares the necessary infrastructure for ADC platform device on
Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
IIO subsystem.

Changelog
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
 drivers/iio/adc/ep93xx_adc.c                 | 261 +++++++++++++++++++++++++++
 9 files changed, 343 insertions(+)
 create mode 100644 Documentation/iio/ep93xx_adc.txt
 create mode 100644 drivers/iio/adc/ep93xx_adc.c
