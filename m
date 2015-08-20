Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47337 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbHTMuO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 08:50:14 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 0/4] iio: bmc150 regmap and SPI
Date: Thu, 20 Aug 2015 14:49:42 +0200
Message-Id: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

this series converts the bmc150 driver to use regmap and adds an SPI interface.

In v1 this was part of the series "Regmap max_raw_io and bmc150 SPI support".
It now depends on "regmap: i2c block support".

Changes in v2:
- Removed default values for regmap_config fields.
- Redesigned the fifo_transfer function to avoid running in errors first.
- Dropped irq checks patch as it is already mainline
- Core can now be built as module with autoselection of i2c and spi parts

As my hardware is missing an interrupt line from the SPI connected bmc150 I am
not able to test the iio buffer code path and the i2c code path. Tests would be
appreciated.

Best regards,

Markus


Markus Pargmann (4):
  iio: bmc150: Use i2c regmap
  iio: bcm150: Remove i2c_client from private data
  iio: bmc150: Split the driver into core and i2c
  iio: bmc150: Add SPI driver

 drivers/iio/accel/Kconfig                          |  14 +-
 drivers/iio/accel/Makefile                         |   4 +-
 .../accel/{bmc150-accel.c => bmc150-accel-core.c}  | 398 ++++++++-------------
 drivers/iio/accel/bmc150-accel-i2c.c               |  99 +++++
 drivers/iio/accel/bmc150-accel-spi.c               |  83 +++++
 drivers/iio/accel/bmc150-accel.h                   |  21 ++
 6 files changed, 367 insertions(+), 252 deletions(-)
 rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c} (81%)
 create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
 create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
 create mode 100644 drivers/iio/accel/bmc150-accel.h

-- 
2.4.6

