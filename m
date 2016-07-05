Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41635 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbcGELzz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:55 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 7/9] staging: iio: isl29028: Prefix stuff
Date: Tue,  5 Jul 2016 13:55:42 +0200
Message-Id: <1467719744-19450-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29028.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 79f41ee..a73b632 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -60,10 +60,10 @@
 
 #define ISL29028_NUM_REGS		(ISL29028_REG_TEST2_MODE + 1)
 
-enum als_ir_mode {
-	MODE_NONE = 0,
-	MODE_ALS,
-	MODE_IR
+enum isl29028_als_ir_mode {
+	ISL29028_MODE_NONE = 0,
+	ISL29028_MODE_ALS,
+	ISL29028_MODE_IR,
 };
 
 struct isl29028_chip {
@@ -74,7 +74,7 @@ struct isl29028_chip {
 	bool			enable_prox;
 
 	int			lux_scale;
-	int			als_ir_mode;
+	enum isl29028_als_ir_mode	als_ir_mode;
 };
 
 static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
@@ -120,12 +120,12 @@ static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
 }
 
 static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
-				    enum als_ir_mode mode)
+				    enum isl29028_als_ir_mode mode)
 {
 	int ret = 0;
 
 	switch (mode) {
-	case MODE_ALS:
+	case ISL29028_MODE_ALS:
 		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
 					 ISL29028_CONF_ALS_IR_MODE_MASK,
 					 ISL29028_CONF_ALS_IR_MODE_ALS);
@@ -137,13 +137,13 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 					 ISL29028_CONF_ALS_RANGE_HIGH_LUX);
 		break;
 
-	case MODE_IR:
+	case ISL29028_MODE_IR:
 		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
 					 ISL29028_CONF_ALS_IR_MODE_MASK,
 					 ISL29028_CONF_ALS_IR_MODE_IR);
 		break;
 
-	case MODE_NONE:
+	case ISL29028_MODE_NONE:
 		return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
 			ISL29028_CONF_ALS_EN_MASK, ISL29028_CONF_ALS_DIS);
 	}
@@ -223,14 +223,14 @@ static int isl29028_als_get(struct isl29028_chip *chip, int *als_data)
 	int ret;
 	int als_ir_data;
 
-	if (chip->als_ir_mode != MODE_ALS) {
-		ret = isl29028_set_als_ir_mode(chip, MODE_ALS);
+	if (chip->als_ir_mode != ISL29028_MODE_ALS) {
+		ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_ALS);
 		if (ret < 0) {
 			dev_err(dev,
 				"Error in enabling ALS mode err %d\n", ret);
 			return ret;
 		}
-		chip->als_ir_mode = MODE_ALS;
+		chip->als_ir_mode = ISL29028_MODE_ALS;
 	}
 
 	ret = isl29028_read_als_ir(chip, &als_ir_data);
@@ -256,14 +256,14 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	if (chip->als_ir_mode != MODE_IR) {
-		ret = isl29028_set_als_ir_mode(chip, MODE_IR);
+	if (chip->als_ir_mode != ISL29028_MODE_IR) {
+		ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_IR);
 		if (ret < 0) {
 			dev_err(dev,
 				"Error in enabling IR mode err %d\n", ret);
 			return ret;
 		}
-		chip->als_ir_mode = MODE_IR;
+		chip->als_ir_mode = ISL29028_MODE_IR;
 	}
 	return isl29028_read_als_ir(chip, ir_data);
 }
@@ -428,7 +428,7 @@ static int isl29028_chip_init(struct isl29028_chip *chip)
 	chip->enable_prox  = false;
 	chip->prox_sampling = 20;
 	chip->lux_scale = 2000;
-	chip->als_ir_mode = MODE_NONE;
+	chip->als_ir_mode = ISL29028_MODE_NONE;
 
 	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
 	if (ret < 0) {
-- 
1.7.10.4

