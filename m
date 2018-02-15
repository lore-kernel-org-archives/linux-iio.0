Return-Path: <SRS0=rlOl=FJ=opensource.cirrus.com=ckeepax@kernel.org>
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 5/5] regmap: Remove regmap_get_raw_read_max
Date: Thu, 15 Feb 2018 17:52:20 +0000
Message-ID: <20180215175220.2691-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Since the handling for max_raw_read is now inside regmap_raw_read there
should be no need for client drivers to query as max_raw_read.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 11 -----------
 include/linux/regmap.h       |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 872be065e3fe..a7ee885fce89 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1641,17 +1641,6 @@ bool regmap_can_raw_write(struct regmap *map)
 EXPORT_SYMBOL_GPL(regmap_can_raw_write);
 
 /**
- * regmap_get_raw_read_max - Get the maximum size we can read
- *
- * @map: Map to check.
- */
-size_t regmap_get_raw_read_max(struct regmap *map)
-{
-	return map->max_raw_read;
-}
-EXPORT_SYMBOL_GPL(regmap_get_raw_read_max);
-
-/**
  * regmap_get_raw_write_max - Get the maximum size we can read
  *
  * @map: Map to check.
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 6a3aeba40e9e..0382fb787c10 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -936,7 +936,6 @@ int regmap_get_max_register(struct regmap *map);
 int regmap_get_reg_stride(struct regmap *map);
 int regmap_async_complete(struct regmap *map);
 bool regmap_can_raw_write(struct regmap *map);
-size_t regmap_get_raw_read_max(struct regmap *map);
 size_t regmap_get_raw_write_max(struct regmap *map);
 
 int regcache_sync(struct regmap *map);
-- 
2.11.0
