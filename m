Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56468 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbHLKOF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:14:05 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 12/20] regmap: Introduce max_raw_io for regmap_bulk_read/write
Date: Wed, 12 Aug 2015 12:12:37 +0200
Message-Id: <1439374365-20623-13-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are some busses which have a limit on the maximum number of bytes
that can be send/received. An example for this is
I2C_FUNC_SMBUS_I2C_BLOCK which does not support any reads/writes of more
than 32 bytes. The regmap_bulk operations should still be able to
utilize the full 32 bytes.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 82 ++++++++++++++++++++++++++++++++----------
 include/linux/regmap.h         |  2 ++
 3 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index b2b2849fc6d3..f94041658397 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -144,6 +144,9 @@ struct regmap {
 	/* if set, the device supports multi write mode */
 	bool can_multi_write;
 
+	/* if set, raw reads/writes are limited to this size */
+	size_t max_raw_io;
+
 	struct rb_root range_tree;
 	void *selector_work_buf;	/* Scratch buffer used for selector */
 };
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3b663350c573..6ad4ca849055 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -574,6 +574,7 @@ struct regmap *regmap_init(struct device *dev,
 	else
 		map->reg_stride = 1;
 	map->use_single_rw = config->use_single_rw || !bus->read || !bus->write;
+	map->max_raw_io = bus->max_raw_io;
 	map->can_multi_write = config->can_multi_write;
 	map->dev = dev;
 	map->bus = bus;
@@ -1675,6 +1676,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 {
 	int ret = 0, i;
 	size_t val_bytes = map->format.val_bytes;
+	size_t total_bytes = val_bytes * val_count;
 
 	if (map->bus && !map->format.parse_inplace)
 		return -EINVAL;
@@ -1715,20 +1717,39 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
-	} else if (map->use_single_rw) {
+	} else if (map->use_single_rw ||
+		   (map->max_raw_io && map->max_raw_io < total_bytes)) {
 		/*
 		 * We need to handle bus writes separate to support val_bytes
 		 * that are not powers of 2.
 		 */
+		int reg_stride = map->reg_stride;
+		size_t write_bytes = val_bytes;
+		size_t write_count = val_count;
+
+		if (!map->use_single_rw) {
+			write_count = total_bytes / map->max_raw_io;
+			write_bytes = map->max_raw_io;
+			reg_stride *= write_bytes / val_bytes;
+		}
+
 		map->lock(map->lock_arg);
+		/* Write as many bytes as possible with maximum write size */
 		for (i = 0; i < val_count; i++) {
 			ret = _regmap_raw_write(map,
-						reg + (i * map->reg_stride),
-						val + (i * val_bytes),
-						val_bytes);
+						reg + (i * reg_stride),
+						val + (i * write_bytes),
+						write_bytes);
 			if (ret)
 				break;
 		}
+
+		/* Write remaining bytes */
+		if (!ret && write_bytes * i < total_bytes) {
+			ret = _regmap_raw_write(map, reg + (i * reg_stride),
+						val + (i * write_bytes),
+						total_bytes - i * write_bytes);
+		}
 		map->unlock(map->lock_arg);
 	} else {
 		void *wval;
@@ -2336,24 +2357,49 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		return -EINVAL;
 
 	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
-		/*
-		 * Some devices does not support bulk read, for
-		 * them we have a series of single read operations.
-		 */
-		if (map->use_single_rw) {
-			for (i = 0; i < val_count; i++) {
-				ret = regmap_raw_read(map,
-						reg + (i * map->reg_stride),
-						val + (i * val_bytes),
-						val_bytes);
-				if (ret != 0)
-					return ret;
-			}
-		} else {
+		size_t total_size = val_bytes * val_count;
+
+		if (!map->use_single_rw &&
+		    (!map->max_raw_io || map->max_raw_io > total_size)) {
 			ret = regmap_raw_read(map, reg, val,
 					      val_bytes * val_count);
 			if (ret != 0)
 				return ret;
+		} else {
+			/*
+			 * Some devices do not support bulk read or do not
+			 * support large bulk reads, for them we have a series
+			 * of read operations.
+			 */
+			int reg_stride = map->reg_stride;
+			size_t read_bytes = val_bytes;
+			size_t read_count = val_count;
+
+			if (!map->use_single_rw) {
+				read_count = total_size / map->max_raw_io;
+				read_bytes = map->max_raw_io;
+				reg_stride *= read_bytes / val_bytes;
+			}
+
+			/* Read bytes that fit into the max_raw_io size */
+			for (i = 0; i < read_count; i++) {
+				ret = regmap_raw_read(map,
+						      reg + (i * reg_stride),
+						      val + (i * read_bytes),
+						      read_bytes);
+				if (ret != 0)
+					return ret;
+			}
+
+			/* Read remaining bytes */
+			if (read_bytes * i < total_size) {
+				ret = regmap_raw_read(map,
+						      reg + (i * reg_stride),
+						      val + (i * read_bytes),
+						      total_size - i * read_bytes);
+				if (ret != 0)
+					return ret;
+			}
 		}
 
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 6ff83c9ddb45..2cb62d141761 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -310,6 +310,7 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @val_format_endian_default: Default endianness for formatted register
  *     values. Used when the regmap_config specifies DEFAULT. If this is
  *     DEFAULT, BIG is assumed.
+ * @max_raw_io: Max raw read/write size that can be used on the bus.
  */
 struct regmap_bus {
 	bool fast_io;
@@ -324,6 +325,7 @@ struct regmap_bus {
 	u8 read_flag_mask;
 	enum regmap_endian reg_format_endian_default;
 	enum regmap_endian val_format_endian_default;
+	size_t max_raw_io;
 };
 
 struct regmap *regmap_init(struct device *dev,
-- 
2.4.6

