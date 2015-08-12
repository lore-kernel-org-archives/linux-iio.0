Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55982 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbbHLKNs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:48 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 14/20] regmap: Add raw_write/read checks for max_raw_write/read sizes
Date: Wed, 12 Aug 2015 12:12:39 +0200
Message-Id: <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check in regmap_raw_read() and regmap_raw_write() for correct maximum
sizes of the operations. Return -E2BIG if this size is not supported
because it is too big.

Also this patch causes an uninitialized variable warning so it
initializes ret (although not necessary).

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8c2be516a100..6b636e2ee111 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1584,6 +1584,8 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
+	if (map->max_raw_io && map->max_raw_io > val_len)
+		return -E2BIG;
 
 	map->lock(map->lock_arg);
 
@@ -2262,7 +2264,8 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	size_t val_bytes = map->format.val_bytes;
 	size_t val_count = val_len / val_bytes;
 	unsigned int v;
-	int ret, i;
+	int ret = 0;
+	int i;
 
 	if (!map->bus)
 		return -EINVAL;
@@ -2273,8 +2276,14 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	map->lock(map->lock_arg);
 
-	if (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
-	    map->cache_type == REGCACHE_NONE) {
+	if (map->bus->read &&
+	    (regmap_volatile_range(map, reg, val_count) || map->cache_bypass ||
+	     map->cache_type == REGCACHE_NONE)) {
+		if (map->max_raw_io && map->max_raw_io < val_len) {
+			ret = -E2BIG;
+			goto out;
+		}
+
 		/* Physical block read if there's no cache involved */
 		ret = _regmap_raw_read(map, reg, val, val_len);
 
-- 
2.4.6

