Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47506 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbHLKOE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:14:04 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 04/20] regmap: Do not skip format initialization
Date: Wed, 12 Aug 2015 12:12:29 +0200
Message-Id: <1439374365-20623-5-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is not obvious why format initialization is skipped here. format
functions are used for example in regmap_bulk_read even if bus is not
set. So they are used even if skipped here which leads to null pointer
errors.

This patch adds format initialization for !bus and !bus->read/write.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4fe5f63edb54..86e94be3c749 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -607,13 +607,11 @@ struct regmap *regmap_init(struct device *dev,
 		map->reg_write = config->reg_write;
 
 		map->defer_caching = false;
-		goto skip_format_initialization;
 	} else if (!bus->read || !bus->write) {
 		map->reg_read = _regmap_bus_reg_read;
 		map->reg_write = _regmap_bus_reg_write;
 
 		map->defer_caching = false;
-		goto skip_format_initialization;
 	} else {
 		map->reg_read  = _regmap_bus_read;
 	}
@@ -784,8 +782,6 @@ struct regmap *regmap_init(struct device *dev,
 		map->reg_write = _regmap_bus_raw_write;
 	}
 
-skip_format_initialization:
-
 	map->range_tree = RB_ROOT;
 	for (i = 0; i < config->num_ranges; i++) {
 		const struct regmap_range_cfg *range_cfg = &config->ranges[i];
-- 
2.4.6

