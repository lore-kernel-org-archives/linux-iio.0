Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33990 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbKYLuT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2015 06:50:19 -0500
Received: by wmww144 with SMTP id w144so11022753wmw.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2015 03:50:18 -0800 (PST)
To: Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH 0/5] iio: ADC driver for EP93xx SoC
Message-ID: <5655A078.5090201@gmail.com>
Date: Wed, 25 Nov 2015 12:50:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series prepares the necessary infrastructure for ADC platform device on
Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
IIO subsystem.

Alexander Sverdlin (5):
  clk: ep93xx: Implement clk_get_parent()
  clk: ep93xx: Add ADC clock
  ep93xx: Add ADC platform device support to core
  edb93xx: Add ADC platform device
  iio: adc: New driver for Cirrus Logic EP93xx ADC

 arch/arm/mach-ep93xx/clock.c                 |  14 ++
 arch/arm/mach-ep93xx/core.c                  |  24 +++
 arch/arm/mach-ep93xx/edb93xx.c               |   1 +
 arch/arm/mach-ep93xx/include/mach/platform.h |   1 +
 arch/arm/mach-ep93xx/soc.h                   |   1 +
 drivers/iio/adc/Kconfig                      |  11 ++
 drivers/iio/adc/Makefile                     |   1 +
 drivers/iio/adc/ep93xx_adc.c                 | 253 +++++++++++++++++++++++++++
 8 files changed, 306 insertions(+)
 create mode 100644 drivers/iio/adc/ep93xx_adc.c
