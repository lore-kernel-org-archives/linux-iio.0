Return-Path: <SRS0=rlOl=FJ=opensource.cirrus.com=ckeepax@kernel.org>
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 3/5] regmap: Use _regmap_read in regmap_bulk_read
Date: Thu, 15 Feb 2018 17:52:18 +0000
Message-ID: <20180215175220.2691-3-ckeepax@opensource.cirrus.com>
In-Reply-To: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Bulk reads may potentially read a lot of registers and regmap_read will
take and release the regmap lock for each register. Avoid bouncing
the lock so frequently by holding the lock locally and calling
_regmap_read instead. This also has the nice side-effect that all the
reads will be done atomically so no other threads can sneak a write in
during the regmap_bulk_read.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 93d4218c5569..872be065e3fe 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2674,6 +2674,8 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 
 	if (!IS_ALIGNED(reg, map->reg_stride))
 		return -EINVAL;
+	if (val_count == 0)
+		return -EINVAL;
 
 	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
 		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
@@ -2690,13 +2692,15 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		u16 *u16 = val;
 		u8 *u8 = val;
 
+		map->lock(map->lock_arg);
+
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
 
-			ret = regmap_read(map, reg + regmap_get_offset(map, i),
-					  &ival);
+			ret = _regmap_read(map, reg + regmap_get_offset(map, i),
+					   &ival);
 			if (ret != 0)
-				return ret;
+				goto out;
 
 			switch (map->format.val_bytes) {
 #ifdef CONFIG_64BIT
@@ -2714,12 +2718,16 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 				u8[i] = ival;
 				break;
 			default:
-				return -EINVAL;
+				ret = -EINVAL;
+				goto out;
 			}
 		}
+
+out:
+		map->unlock(map->lock_arg);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(regmap_bulk_read);
 
-- 
2.11.0
