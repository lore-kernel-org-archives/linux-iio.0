Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45967 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbbIUKzm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2015 06:55:42 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 0/4] iio: bmc150 regmap and SPI
Date: Mon, 21 Sep 2015 12:55:12 +0200
Message-Id: <1442832916-30774-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

this series converts the bmc150 driver to use regmap and adds an SPI interface.

Thanks for testing and review so far. I rebased the series onto v4.3-rc2 now
(the togreg branch seems to be on v4.2).
It still works for me but there were some differences regarding the chip id.

Changes in v3:
- Fixed type of variable 'step' which lead to compile warnings. Type is now
  size_t.
- Fixed patch that moved irq variable without reason
- Readded MODULE_* to the core driver
- Reintroduced check id NULL check

Changes in v2:
- Removed default values for regmap_config fields.
- Redesigned the fifo_transfer function to avoid running in errors first.
- Dropped irq checks patch as it is already mainline
- Core can now be built as module with autoselection of i2c and spi parts

As my hardware is missing an interrupt line from the SPI connected bmc150 I am
not able to test the iio buffer code path and the i2c code path. Tests would be
appreciated.

@Srinivas:
As there were some rebase conflicts on the first patch, I removed your
reviewed-by tag again for the moment.

Best regards,

Markus


Markus Pargmann (4):
  iio: bmc150: Use i2c regmap
  iio: bcm150: Remove i2c_client from private data
  iio: bmc150: Split the driver into core and i2c
  iio: bmc150: Add SPI driver

 drivers/iio/accel/Kconfig                          |  14 +-
 drivers/iio/accel/Makefile                         |   4 +-
 .../accel/{bmc150-accel.c => bmc150-accel-core.c}  | 388 ++++++++-------------
 drivers/iio/accel/bmc150-accel-i2c.c               | 102 ++++++
 drivers/iio/accel/bmc150-accel-spi.c               |  80 +++++
 drivers/iio/accel/bmc150-accel.h                   |  20 ++
 6 files changed, 366 insertions(+), 242 deletions(-)
 rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c} (82%)
 create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
 create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
 create mode 100644 drivers/iio/accel/bmc150-accel.h

-- 
2.5.1

