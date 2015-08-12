Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58948 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbbHLKO2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:14:28 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 00/20] Regmap max_raw_io and bmc150 SPI support
Date: Wed, 12 Aug 2015 12:12:25 +0200
Message-Id: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

this series was created to add SPI support to the bmc150 accelerometer driver.
To not add any regressions, I had to add some infrastructure that allows to use
regmap with busses that do limit the size of transfers (block smbus). I hope
this is sufficient to not break anything.

The series has several different parts for regmap and the iio driver:

Patches 1-4 fix some minor things in the regmap core code.

Patches 5-11 fix some issues with regmap busses that do not have an
implementation of read() or write(). Currently a lot of the regmap API
functions simply fail for those busses.

Patches 12-14 introduce 'max_raw_io' for busses which defines the max number of
bytes that may be send or received by this bus. This includes handling in
regmap_bulk_read/write and reporting an error for raw_read/writes that are
above this limit (E2BIG).

Patch 15 makes use of max_raw_io by adding smbus i2c block bus driver. This
patch is created to avoid regressions in the bmc150 driver.

Patches 16-20 move bmc150 to use regmap and add SPI support.


As I don't have a bmc150 connected via smbus I am not able to test Patch 14 and
the resulting I2C part of the bmc150 driver. It would be great if someone with
the hardware could test it. Also it would be great to have some test coverage
for all other regmap setups.

Best Regards,

Markus



Markus Pargmann (20):
  regmap: Add missing comments about struct regmap_bus
  regmap: Remove regmap_bulk_write 64bit support
  regmap: Fix integertypes for register address and value
  regmap: Do not skip format initialization
  regmap: Restructure writes in _regmap_raw_write()
  regmap: Fix regmap_bulk_write for bus writes
  regmap: Without bus read() or write(), force use_single_rw
  regmap: Fix regmap_can_raw_write check
  regmap: _regmap_raw_write fix for busses without write()
  regmap: _regmap_raw_multi_reg_write: Add reg_write() support
  regmap: _regmap_raw_read: Add handling of busses without bus->read()
  regmap: Introduce max_raw_io for regmap_bulk_read/write
  regmap: regmap max_raw_io getter function
  regmap: Add raw_write/read checks for max_raw_write/read sizes
  regmap-i2c: Add smbus i2c block support
  iio: bmc150: Fix irq checks
  iio: bmc150: Use i2c regmap
  iio: bcm150: Remove i2c_client from private data
  iio: bmc150: Split the driver into core and i2c
  iio: bmc150: Add SPI driver

 drivers/base/regmap/internal.h                     |   3 +
 drivers/base/regmap/regmap-i2c.c                   |  46 +++
 drivers/base/regmap/regmap.c                       | 221 ++++++++---
 drivers/iio/accel/Kconfig                          |  32 +-
 drivers/iio/accel/Makefile                         |   4 +-
 .../accel/{bmc150-accel.c => bmc150-accel-core.c}  | 404 ++++++++-------------
 drivers/iio/accel/bmc150-accel-i2c.c               | 101 ++++++
 drivers/iio/accel/bmc150-accel-spi.c               |  86 +++++
 drivers/iio/accel/bmc150-accel.h                   |  21 ++
 include/linux/regmap.h                             |   8 +-
 10 files changed, 622 insertions(+), 304 deletions(-)
 rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c} (82%)
 create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
 create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
 create mode 100644 drivers/iio/accel/bmc150-accel.h

-- 
2.4.6

