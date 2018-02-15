Return-Path: <SRS0=rlOl=FJ=opensource.cirrus.com=ckeepax@kernel.org>
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/5] regmap: Move the handling for max_raw_read into regmap_raw_read
Date: Thu, 15 Feb 2018 17:52:16 +0000
Message-ID: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Currently regmap_bulk_read will split a read into chunks before
calling regmap_raw_read if max_raw_read is set. It is more logical for
this handling to be inside regmap_raw_read itself, as this removes the
need to keep re-implementing the chunking code, which would be the
same for all users of regmap_raw_read.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 90 +++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6342eaefc218..f78ddaa9a1e8 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2542,18 +2542,45 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
 	    map->cache_type == REGCACHE_NONE) {
+		int chunk_stride = map->reg_stride;
+		size_t chunk_size = val_bytes;
+		size_t chunk_count = val_count;
+
 		if (!map->bus->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
-		if (map->max_raw_read && map->max_raw_read < val_len) {
-			ret = -E2BIG;
-			goto out;
+
+		if (!map->use_single_read) {
+			if (map->max_raw_read)
+				chunk_size = map->max_raw_read;
+			else
+				chunk_size = val_len;
+			if (chunk_size % val_bytes)
+				chunk_size -= chunk_size % val_bytes;
+			chunk_count = val_len / chunk_size;
+			chunk_stride *= chunk_size / val_bytes;
 		}
 
-		/* Physical block read if there's no cache involved */
-		ret = _regmap_raw_read(map, reg, val, val_len);
+		/* Read bytes that fit into a multiple of chunk_size */
+		for (i = 0; i < chunk_count; i++) {
+			ret = _regmap_raw_read(map,
+					       reg + (i * chunk_stride),
+					       val + (i * chunk_size),
+					       chunk_size);
+			if (ret != 0)
+				return ret;
+		}
 
+		/* Read remaining bytes */
+		if (chunk_size * i < val_len) {
+			ret = _regmap_raw_read(map,
+					       reg + (i * chunk_stride),
+					       val + (i * chunk_size),
+					       val_len - i * chunk_size);
+			if (ret != 0)
+				return ret;
+		}
 	} else {
 		/* Otherwise go word by word for the cache; should be low
 		 * cost as we expect to hit the cache.
@@ -2655,56 +2682,9 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		return -EINVAL;
 
 	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
-		/*
-		 * Some devices does not support bulk read, for
-		 * them we have a series of single read operations.
-		 */
-		size_t total_size = val_bytes * val_count;
-
-		if (!map->use_single_read &&
-		    (!map->max_raw_read || map->max_raw_read > total_size)) {
-			ret = regmap_raw_read(map, reg, val,
-					      val_bytes * val_count);
-			if (ret != 0)
-				return ret;
-		} else {
-			/*
-			 * Some devices do not support bulk read or do not
-			 * support large bulk reads, for them we have a series
-			 * of read operations.
-			 */
-			int chunk_stride = map->reg_stride;
-			size_t chunk_size = val_bytes;
-			size_t chunk_count = val_count;
-
-			if (!map->use_single_read) {
-				chunk_size = map->max_raw_read;
-				if (chunk_size % val_bytes)
-					chunk_size -= chunk_size % val_bytes;
-				chunk_count = total_size / chunk_size;
-				chunk_stride *= chunk_size / val_bytes;
-			}
-
-			/* Read bytes that fit into a multiple of chunk_size */
-			for (i = 0; i < chunk_count; i++) {
-				ret = regmap_raw_read(map,
-						      reg + (i * chunk_stride),
-						      val + (i * chunk_size),
-						      chunk_size);
-				if (ret != 0)
-					return ret;
-			}
-
-			/* Read remaining bytes */
-			if (chunk_size * i < total_size) {
-				ret = regmap_raw_read(map,
-						      reg + (i * chunk_stride),
-						      val + (i * chunk_size),
-						      total_size - i * chunk_size);
-				if (ret != 0)
-					return ret;
-			}
-		}
+		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
+		if (ret != 0)
+			return ret;
 
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
-- 
2.11.0
