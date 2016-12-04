Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46882 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbcLDCUU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:20 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 01/19] staging: iio: isl29028: remove nested if statements
Date: Sat,  3 Dec 2016 21:19:25 -0500
Message-Id: <1480817983-32359-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are two callers to the function isl29028_set_als_ir_mode() and
both instances use a nested if statement to only change the chip state
if it is not in the proper mode. This patch moves this check into the
isl29028_set_als_ir_mode() function to remove the nested if
statements.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index aa413e5..4e35d00 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -124,6 +124,9 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 {
 	int ret = 0;
 
+	if (chip->als_ir_mode == mode)
+		return 0;
+
 	switch (mode) {
 	case ISL29028_MODE_ALS:
 		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
@@ -160,6 +163,9 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 
 	/* Need to wait for conversion time if ALS/IR mode enabled */
 	mdelay(ISL29028_CONV_TIME_MS);
+
+	chip->als_ir_mode = mode;
+
 	return 0;
 }
 
@@ -223,14 +229,10 @@ static int isl29028_als_get(struct isl29028_chip *chip, int *als_data)
 	int ret;
 	int als_ir_data;
 
-	if (chip->als_ir_mode != ISL29028_MODE_ALS) {
-		ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_ALS);
-		if (ret < 0) {
-			dev_err(dev,
-				"Error in enabling ALS mode err %d\n", ret);
-			return ret;
-		}
-		chip->als_ir_mode = ISL29028_MODE_ALS;
+	ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_ALS);
+	if (ret < 0) {
+		dev_err(dev, "Error in enabling ALS mode err %d\n", ret);
+		return ret;
 	}
 
 	ret = isl29028_read_als_ir(chip, &als_ir_data);
@@ -256,14 +258,10 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	if (chip->als_ir_mode != ISL29028_MODE_IR) {
-		ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_IR);
-		if (ret < 0) {
-			dev_err(dev,
-				"Error in enabling IR mode err %d\n", ret);
-			return ret;
-		}
-		chip->als_ir_mode = ISL29028_MODE_IR;
+	ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_IR);
+	if (ret < 0) {
+		dev_err(dev, "Error in enabling IR mode err %d\n", ret);
+		return ret;
 	}
 	return isl29028_read_als_ir(chip, ir_data);
 }
-- 
2.7.4

