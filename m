Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54056 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbHLKNs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:48 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>,
	Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 06/20] regmap: Fix regmap_bulk_write for bus writes
Date: Wed, 12 Aug 2015 12:12:31 +0200
Message-Id: <1439374365-20623-7-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The regmap config does not prohibit val_bytes that are not powers of
two. But the current code of regmap_bulk_write for use_single_rw does
limit the possible val_bytes to 1, 2 and 4.

This patch fixes the behaviour to allow bus writes with non-standard
val_bytes sizes.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f6bd3517a472..f98bd5bf5c62 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1680,6 +1680,9 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	 * them we have a series of single write operations.
 	 */
 	if (!map->bus || map->use_single_rw) {
+		if (val_bytes != 1 && val_bytes != 2 && val_bytes != 4)
+			return -EINVAL;
+
 		map->lock(map->lock_arg);
 		for (i = 0; i < val_count; i++) {
 			unsigned int ival;
@@ -1706,6 +1709,21 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 		}
 out:
 		map->unlock(map->lock_arg);
+	} else if (map->use_single_rw) {
+		/*
+		 * We need to handle bus writes separate to support val_bytes
+		 * that are not powers of 2.
+		 */
+		map->lock(map->lock_arg);
+		for (i = 0; i < val_count; i++) {
+			ret = _regmap_raw_write(map,
+						reg + (i * map->reg_stride),
+						val + (i * val_bytes),
+						val_bytes);
+			if (ret)
+				break;
+		}
+		map->unlock(map->lock_arg);
 	} else {
 		void *wval;
 
-- 
2.4.6

