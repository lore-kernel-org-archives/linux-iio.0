Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47166 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbcLDCUV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:21 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 07/19] staging: iio: isl29028: fix alignment of function arguments
Date: Sat,  3 Dec 2016 21:19:31 -0500
Message-Id: <1480817983-32359-8-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Two separate calls to regmap_update_bits() in isl29028_set_als_scale()
and isl29028_set_als_ir_mode() did not have their function arguments
on the next line aligned correctly to the open parenthesis. This patch
corrects the alignment.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index fe8814b..38027ee 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -115,7 +115,7 @@ static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
 					ISL29028_CONF_ALS_RANGE_LOW_LUX;
 
 	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-		ISL29028_CONF_ALS_RANGE_MASK, val);
+				  ISL29028_CONF_ALS_RANGE_MASK, val);
 }
 
 static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
@@ -147,7 +147,8 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 
 	case ISL29028_MODE_NONE:
 		return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-			ISL29028_CONF_ALS_EN_MASK, ISL29028_CONF_ALS_DIS);
+					  ISL29028_CONF_ALS_EN_MASK,
+					  ISL29028_CONF_ALS_DIS);
 	}
 
 	if (ret < 0)
-- 
2.7.4

