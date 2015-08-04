Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45874 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270AbbHDLDu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 07:03:50 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 0/6] iio: bmg160: Add SPI connection
Date: Tue,  4 Aug 2015 13:02:53 +0200
Message-Id: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

bmg160 and bmi055 can be used via I2C and SPI. This series converts the driver
to regmap and splits core driver and I2C/SPI.

Changes in v2:
 - Added the id->name from the SPI driver to be used as iio device name
 - Fixed Kconfig in patch 2 to add selects for REGMAP_I2C
 - Fixed regmap configs to be static const

Best regards,

Markus


Markus Pargmann (6):
  iio: bmg160: Use i2c regmap instead of direct i2c access
  iio: bmg160: Remove i2c_client from data struct
  iio: bmg160: Use generic dev_drvdata
  iio: bmg160: Remove remaining uses of i2c_client
  iio: bmg160: Separate i2c and core driver
  iio: bmg160: Add SPI driver

 drivers/iio/gyro/Kconfig                     |  29 ++-
 drivers/iio/gyro/Makefile                    |   4 +-
 drivers/iio/gyro/bmg160.h                    |  10 +
 drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 356 +++++++++++----------------
 drivers/iio/gyro/bmg160_i2c.c                |  73 ++++++
 drivers/iio/gyro/bmg160_spi.c                |  60 +++++
 6 files changed, 311 insertions(+), 221 deletions(-)
 create mode 100644 drivers/iio/gyro/bmg160.h
 rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (74%)
 create mode 100644 drivers/iio/gyro/bmg160_i2c.c
 create mode 100644 drivers/iio/gyro/bmg160_spi.c

-- 
2.1.4

