Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41632 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948AbcGELzt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:49 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 6/9] staging: iio: isl29028: Prefix #defines
Date: Tue,  5 Jul 2016 13:55:41 +0200
Message-Id: <1467719744-19450-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

and drop unused PROX_DRIVE

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29028.c |   62 +++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 2e3b1d6..79f41ee 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -27,29 +27,27 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define CONVERSION_TIME_MS		100
+#define ISL29028_CONV_TIME_MS		100
 
 #define ISL29028_REG_CONFIGURE		0x01
 
-#define CONFIGURE_ALS_IR_MODE_ALS	0
-#define CONFIGURE_ALS_IR_MODE_IR	BIT(0)
-#define CONFIGURE_ALS_IR_MODE_MASK	BIT(0)
+#define ISL29028_CONF_ALS_IR_MODE_ALS	0
+#define ISL29028_CONF_ALS_IR_MODE_IR	BIT(0)
+#define ISL29028_CONF_ALS_IR_MODE_MASK	BIT(0)
 
-#define CONFIGURE_ALS_RANGE_LOW_LUX	0
-#define CONFIGURE_ALS_RANGE_HIGH_LUX	BIT(1)
-#define CONFIGURE_ALS_RANGE_MASK	BIT(1)
+#define ISL29028_CONF_ALS_RANGE_LOW_LUX	0
+#define ISL29028_CONF_ALS_RANGE_HIGH_LUX	BIT(1)
+#define ISL29028_CONF_ALS_RANGE_MASK	BIT(1)
 
-#define CONFIGURE_ALS_DIS		0
-#define CONFIGURE_ALS_EN		BIT(2)
-#define CONFIGURE_ALS_EN_MASK		BIT(2)
+#define ISL29028_CONF_ALS_DIS		0
+#define ISL29028_CONF_ALS_EN		BIT(2)
+#define ISL29028_CONF_ALS_EN_MASK	BIT(2)
 
-#define CONFIGURE_PROX_DRIVE		BIT(3)
+#define ISL29028_CONF_PROX_SLP_SH	4
+#define ISL29028_CONF_PROX_SLP_MASK	(7 << ISL29028_CONF_PROX_SLP_SH)
 
-#define CONFIGURE_PROX_SLP_SH		4
-#define CONFIGURE_PROX_SLP_MASK		(7 << CONFIGURE_PROX_SLP_SH)
-
-#define CONFIGURE_PROX_EN		BIT(7)
-#define CONFIGURE_PROX_EN_MASK		BIT(7)
+#define ISL29028_CONF_PROX_EN		BIT(7)
+#define ISL29028_CONF_PROX_EN_MASK	BIT(7)
 
 #define ISL29028_REG_INTERRUPT		0x02
 
@@ -91,7 +89,8 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
 			break;
 	}
 	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-			CONFIGURE_PROX_SLP_MASK, sel << CONFIGURE_PROX_SLP_SH);
+				  ISL29028_CONF_PROX_SLP_MASK,
+				  sel << ISL29028_CONF_PROX_SLP_SH);
 }
 
 static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
@@ -100,9 +99,9 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
 	int val = 0;
 
 	if (enable)
-		val = CONFIGURE_PROX_EN;
+		val = ISL29028_CONF_PROX_EN;
 	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-				 CONFIGURE_PROX_EN_MASK, val);
+				 ISL29028_CONF_PROX_EN_MASK, val);
 	if (ret < 0)
 		return ret;
 
@@ -113,11 +112,11 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
 
 static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
 {
-	int val = (lux_scale == 2000) ? CONFIGURE_ALS_RANGE_HIGH_LUX :
-					CONFIGURE_ALS_RANGE_LOW_LUX;
+	int val = (lux_scale == 2000) ? ISL29028_CONF_ALS_RANGE_HIGH_LUX :
+					ISL29028_CONF_ALS_RANGE_LOW_LUX;
 
 	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-		CONFIGURE_ALS_RANGE_MASK, val);
+		ISL29028_CONF_ALS_RANGE_MASK, val);
 }
 
 static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
@@ -128,25 +127,25 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 	switch (mode) {
 	case MODE_ALS:
 		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-					 CONFIGURE_ALS_IR_MODE_MASK,
-					 CONFIGURE_ALS_IR_MODE_ALS);
+					 ISL29028_CONF_ALS_IR_MODE_MASK,
+					 ISL29028_CONF_ALS_IR_MODE_ALS);
 		if (ret < 0)
 			return ret;
 
 		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-					 CONFIGURE_ALS_RANGE_MASK,
-					 CONFIGURE_ALS_RANGE_HIGH_LUX);
+					 ISL29028_CONF_ALS_RANGE_MASK,
+					 ISL29028_CONF_ALS_RANGE_HIGH_LUX);
 		break;
 
 	case MODE_IR:
 		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-					 CONFIGURE_ALS_IR_MODE_MASK,
-					 CONFIGURE_ALS_IR_MODE_IR);
+					 ISL29028_CONF_ALS_IR_MODE_MASK,
+					 ISL29028_CONF_ALS_IR_MODE_IR);
 		break;
 
 	case MODE_NONE:
 		return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-			CONFIGURE_ALS_EN_MASK, CONFIGURE_ALS_DIS);
+			ISL29028_CONF_ALS_EN_MASK, ISL29028_CONF_ALS_DIS);
 	}
 
 	if (ret < 0)
@@ -154,12 +153,13 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 
 	/* Enable the ALS/IR */
 	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-				 CONFIGURE_ALS_EN_MASK, CONFIGURE_ALS_EN);
+				 ISL29028_CONF_ALS_EN_MASK,
+				 ISL29028_CONF_ALS_EN);
 	if (ret < 0)
 		return ret;
 
 	/* Need to wait for conversion time if ALS/IR mode enabled */
-	mdelay(CONVERSION_TIME_MS);
+	mdelay(ISL29028_CONV_TIME_MS);
 	return 0;
 }
 
-- 
1.7.10.4

