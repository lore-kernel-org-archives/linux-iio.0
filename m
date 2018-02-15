Return-Path: <SRS0=rlOl=FJ=opensource.cirrus.com=ckeepax@kernel.org>
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/5] regmap: Tidy up regmap_raw_read chunking code
Date: Thu, 15 Feb 2018 17:52:17 +0000
Message-ID: <20180215175220.2691-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Raw reads may need to be split into small chunks if max_raw_read is
set.  Tidy up the code implementing this, the new code is slightly
clearer, slightly shorter and slightly more efficient.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f78ddaa9a1e8..93d4218c5569 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2542,44 +2542,38 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
 	    map->cache_type == REGCACHE_NONE) {
-		int chunk_stride = map->reg_stride;
-		size_t chunk_size = val_bytes;
-		size_t chunk_count = val_count;
+		size_t chunk_count, chunk_bytes;
+		size_t chunk_regs = val_count;
 
 		if (!map->bus->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
 
-		if (!map->use_single_read) {
-			if (map->max_raw_read)
-				chunk_size = map->max_raw_read;
-			else
-				chunk_size = val_len;
-			if (chunk_size % val_bytes)
-				chunk_size -= chunk_size % val_bytes;
-			chunk_count = val_len / chunk_size;
-			chunk_stride *= chunk_size / val_bytes;
-		}
+		if (map->use_single_read)
+			chunk_regs = 1;
+		else if (map->max_raw_read && val_len > map->max_raw_read)
+			chunk_regs = map->max_raw_read / val_bytes;
 
-		/* Read bytes that fit into a multiple of chunk_size */
+		chunk_count = val_count / chunk_regs;
+		chunk_bytes = chunk_regs * val_bytes;
+
+		/* Read bytes that fit into whole chunks */
 		for (i = 0; i < chunk_count; i++) {
-			ret = _regmap_raw_read(map,
-					       reg + (i * chunk_stride),
-					       val + (i * chunk_size),
-					       chunk_size);
+			ret = _regmap_raw_read(map, reg, val, chunk_bytes);
 			if (ret != 0)
-				return ret;
+				goto out;
+
+			reg += regmap_get_offset(map, chunk_regs);
+			val += chunk_bytes;
+			val_len -= chunk_bytes;
 		}
 
 		/* Read remaining bytes */
-		if (chunk_size * i < val_len) {
-			ret = _regmap_raw_read(map,
-					       reg + (i * chunk_stride),
-					       val + (i * chunk_size),
-					       val_len - i * chunk_size);
+		if (val_len) {
+			ret = _regmap_raw_read(map, reg, val, val_len);
 			if (ret != 0)
-				return ret;
+				goto out;
 		}
 	} else {
 		/* Otherwise go word by word for the cache; should be low
-- 
2.11.0
