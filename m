Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43638 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbHLKN4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:56 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 13/20] regmap: regmap max_raw_io getter function
Date: Wed, 12 Aug 2015 12:12:38 +0200
Message-Id: <1439374365-20623-14-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 22 ++++++++++++++++++++++
 include/linux/regmap.h       |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6ad4ca849055..8c2be516a100 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1393,6 +1393,28 @@ bool regmap_can_raw_write(struct regmap *map)
 }
 EXPORT_SYMBOL_GPL(regmap_can_raw_write);
 
+/**
+ * regmap_get_raw_io_max - Get the maximum size we can read/write
+ *
+ * @map: Map to check.
+ */
+size_t regmap_get_raw_io_max(struct regmap *map)
+{
+	return map->max_raw_io;
+}
+EXPORT_SYMBOL_GPL(regmap_get_raw_io_max);
+
+/**
+ * regmap_get_raw_read_max - Get the maximum size we can read
+ *
+ * @map: Map to check.
+ */
+size_t regmap_get_raw_read_max(struct regmap *map)
+{
+	return map->max_raw_io;
+}
+EXPORT_SYMBOL_GPL(regmap_get_raw_read_max);
+
 static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 				       unsigned int val)
 {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 2cb62d141761..b236f884f642 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -441,6 +441,8 @@ int regmap_get_max_register(struct regmap *map);
 int regmap_get_reg_stride(struct regmap *map);
 int regmap_async_complete(struct regmap *map);
 bool regmap_can_raw_write(struct regmap *map);
+size_t regmap_get_raw_write_max(struct regmap *map);
+size_t regmap_get_raw_io_max(struct regmap *map);
 
 int regcache_sync(struct regmap *map);
 int regcache_sync_region(struct regmap *map, unsigned int min,
-- 
2.4.6

