Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49002 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbdAQJZP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:15 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 02/15] staging: iio: isl29028: fix alignment of function arguments
Date: Tue, 17 Jan 2017 04:24:49 -0500
Message-Id: <20170117092502.6951-3-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
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
index 4cce663..74eb736 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -116,7 +116,7 @@ static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
 					ISL29028_CONF_ALS_RANGE_LOW_LUX;
 
 	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-		ISL29028_CONF_ALS_RANGE_MASK, val);
+				  ISL29028_CONF_ALS_RANGE_MASK, val);
 }
 
 static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
@@ -148,7 +148,8 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 
 	case ISL29028_MODE_NONE:
 		return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-			ISL29028_CONF_ALS_EN_MASK, ISL29028_CONF_ALS_DIS);
+					  ISL29028_CONF_ALS_EN_MASK,
+					  ISL29028_CONF_ALS_DIS);
 	}
 
 	if (ret < 0)
-- 
2.9.3

