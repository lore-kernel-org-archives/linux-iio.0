Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48551 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbbHLKNm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:42 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 08/20] regmap: Fix regmap_can_raw_write check
Date: Wed, 12 Aug 2015 12:12:33 +0200
Message-Id: <1439374365-20623-9-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This function is missing a check if map->bus->write is implemented. If
it is not implemented arbitrary raw writes are not possible.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 35ad3783da70..510dab052a95 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1382,7 +1382,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
  */
 bool regmap_can_raw_write(struct regmap *map)
 {
-	return map->bus && map->format.format_val && map->format.format_reg;
+	return map->bus && map->bus->write && map->format.format_val &&
+		map->format.format_reg;
 }
 EXPORT_SYMBOL_GPL(regmap_can_raw_write);
 
-- 
2.4.6

