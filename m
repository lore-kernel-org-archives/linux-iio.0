Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57220 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbbHLKNs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:48 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 05/20] regmap: Restructure writes in _regmap_raw_write()
Date: Wed, 12 Aug 2015 12:12:30 +0200
Message-Id: <1439374365-20623-6-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently we try to write the data without copying directly using
bus->write() or bus->gather_write() if it exists. If one of the previous
tries to write reported -ENOTSUPP or none of them were usable, we copy
the data into a buffer and use bus->write().

However it does not make sense to try bus->write() a second time with a
copied buffer if it didn't work the first time.

This patch restructures this if/else block to make it clear that this is
not intended for the case where bus->write() returns -ENOTSUPP.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 86e94be3c749..f6bd3517a472 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1340,30 +1340,34 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	 * send the work_buf directly, otherwise try to do a gather
 	 * write.
 	 */
-	if (val == work_val)
+	if (val == work_val) {
 		ret = map->bus->write(map->bus_context, map->work_buf,
 				      map->format.reg_bytes +
 				      map->format.pad_bytes +
 				      val_len);
-	else if (map->bus->gather_write)
-		ret = map->bus->gather_write(map->bus_context, map->work_buf,
-					     map->format.reg_bytes +
-					     map->format.pad_bytes,
-					     val, val_len);
-
-	/* If that didn't work fall back on linearising by hand. */
-	if (ret == -ENOTSUPP) {
-		len = map->format.reg_bytes + map->format.pad_bytes + val_len;
-		buf = kzalloc(len, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
+	} else {
+		if (map->bus->gather_write)
+			ret = map->bus->gather_write(map->bus_context,
+						     map->work_buf,
+						     map->format.reg_bytes +
+						     map->format.pad_bytes,
+						     val, val_len);
+
+		/* If that didn't work fall back on linearising by hand. */
+		if (ret == -ENOTSUPP) {
+			len = map->format.reg_bytes + map->format.pad_bytes +
+				val_len;
+			buf = kzalloc(len, GFP_KERNEL);
+			if (!buf)
+				return -ENOMEM;
 
-		memcpy(buf, map->work_buf, map->format.reg_bytes);
-		memcpy(buf + map->format.reg_bytes + map->format.pad_bytes,
-		       val, val_len);
-		ret = map->bus->write(map->bus_context, buf, len);
+			memcpy(buf, map->work_buf, map->format.reg_bytes);
+			memcpy(buf + map->format.reg_bytes +
+			       map->format.pad_bytes, val, val_len);
+			ret = map->bus->write(map->bus_context, buf, len);
 
-		kfree(buf);
+			kfree(buf);
+		}
 	}
 
 	trace_regmap_hw_write_done(map, reg, val_len / map->format.val_bytes);
-- 
2.4.6

