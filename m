Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35984 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbbHSMM5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2015 08:12:57 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 0/2] iio: bmg160: Add SPI connection
Date: Wed, 19 Aug 2015 14:12:44 +0200
Message-Id: <1439986366-25291-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

These are the remaining two patches for the bmg160 driver. These split core
driver from the I2C part and add the SPI regmap setup as separate driver.

Changes in v4:
- Fixed include of bmg160 header
- Changed Kconfig/Makefile setup to automatically select I2C and SPI drivers
  dependending on the configurations state of the subsystems. The core driver
  is compiled once and can be a module now.

Best regards,

Markus


Markus Pargmann (2):
  iio: bmg160: Separate i2c and core driver
  iio: bmg160: Add SPI driver

 drivers/iio/gyro/Kconfig                     | 20 +++++--
 drivers/iio/gyro/Makefile                    |  4 +-
 drivers/iio/gyro/bmg160.h                    | 10 ++++
 drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 79 +++++-----------------------
 drivers/iio/gyro/bmg160_i2c.c                | 71 +++++++++++++++++++++++++
 drivers/iio/gyro/bmg160_spi.c                | 57 ++++++++++++++++++++
 6 files changed, 170 insertions(+), 71 deletions(-)
 create mode 100644 drivers/iio/gyro/bmg160.h
 rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (94%)
 create mode 100644 drivers/iio/gyro/bmg160_i2c.c
 create mode 100644 drivers/iio/gyro/bmg160_spi.c

-- 
2.4.6

