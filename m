Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38688 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbbHLKNs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:48 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 07/20] regmap: Without bus read() or write(), force use_single_rw
Date: Wed, 12 Aug 2015 12:12:32 +0200
Message-Id: <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The implementation of regmap bus read() and write() methods are
optional. Therefore we have to handle busses which do not have these
functions. If raw read() and write() is not supported we have to use
reg_read and reg_write always.

This patch sets use_single_rw if read() or write() is not set.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f98bd5bf5c62..35ad3783da70 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -573,7 +573,7 @@ struct regmap *regmap_init(struct device *dev,
 		map->reg_stride = config->reg_stride;
 	else
 		map->reg_stride = 1;
-	map->use_single_rw = config->use_single_rw;
+	map->use_single_rw = config->use_single_rw || !bus->read || !bus->write;
 	map->can_multi_write = config->can_multi_write;
 	map->dev = dev;
 	map->bus = bus;
-- 
2.4.6

