Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34465 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbdEQROF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 May 2017 13:14:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so5057331wmf.1
        for <linux-iio@vger.kernel.org>; Wed, 17 May 2017 10:14:04 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v4 0/5] iio: ADC driver for EP93xx SoC
Date: Wed, 17 May 2017 19:13:47 +0200
Message-Id: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series prepares the necessary infrastructure for ADC platform device on
Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
IIO subsystem.

Changelog
v4:
  Spelling improvements
  sign_extend32() usage
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
 drivers/iio/adc/ep93xx_adc.c                 | 255 +++++++++++++++++++++++++++
 9 files changed, 337 insertions(+)
 create mode 100644 Documentation/iio/ep93xx_adc.txt
 create mode 100644 drivers/iio/adc/ep93xx_adc.c

-- 
2.12.2

