Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46918 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbcLDCUU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:20 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 03/19] staging: iio: isl29028: remove chip test and defaults from isl29028_chip_init()
Date: Sat,  3 Dec 2016 21:19:27 -0500
Message-Id: <1480817983-32359-4-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

isl29028_chip_init() contains the device driver defaults and
two I2C calls that detect the presence of the chip. This patch
moves these into isl29028_probe() so that this function can
be used by the power management runtinme in a followup patch. This
patch also renames isl29028_chip_init() to
isl29028_chip_init_and_power_on().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 42 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index c8e234d..4f819a8 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -416,29 +416,11 @@ static const struct iio_info isl29028_info = {
 	.write_raw = isl29028_write_raw,
 };
 
-static int isl29028_chip_init(struct isl29028_chip *chip)
+static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
 {
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	chip->enable_prox  = false;
-	chip->prox_sampling = 20;
-	chip->lux_scale = 2000;
-	chip->als_ir_mode = ISL29028_MODE_NONE;
-
-	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
-	if (ret < 0) {
-		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
-			__func__, ISL29028_REG_TEST1_MODE, ret);
-		return ret;
-	}
-	ret = regmap_write(chip->regmap, ISL29028_REG_TEST2_MODE, 0x0);
-	if (ret < 0) {
-		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
-			__func__, ISL29028_REG_TEST2_MODE, ret);
-		return ret;
-	}
-
 	ret = regmap_write(chip->regmap, ISL29028_REG_CONFIGURE, 0x0);
 	if (ret < 0) {
 		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
@@ -506,7 +488,27 @@ static int isl29028_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = isl29028_chip_init(chip);
+	chip->enable_prox  = false;
+	chip->prox_sampling = 20;
+	chip->lux_scale = 2000;
+	chip->als_ir_mode = ISL29028_MODE_NONE;
+
+	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s(): write to reg %d failed, err = %d\n", __func__,
+			ISL29028_REG_TEST1_MODE, ret);
+		return ret;
+	}
+	ret = regmap_write(chip->regmap, ISL29028_REG_TEST2_MODE, 0x0);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s(): write to reg %d failed, err = %d\n", __func__,
+			ISL29028_REG_TEST2_MODE, ret);
+		return ret;
+	}
+
+	ret = isl29028_chip_init_and_power_on(chip);
 	if (ret < 0) {
 		dev_err(&client->dev, "chip initialization failed: %d\n", ret);
 		return ret;
-- 
2.7.4

