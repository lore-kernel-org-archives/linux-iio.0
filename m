Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47168 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbcLDCUV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:21 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 08/19] staging: iio: isl29028: combine isl29028_proxim_get() and isl29028_read_proxim()
Date: Sat,  3 Dec 2016 21:19:32 -0500
Message-Id: <1480817983-32359-9-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

isl29028_proxim_get() checks to see if the promixity needs to be
enabled on the chip and then calls isl29028_read_proxim(). There
are no other callers of isl29028_read_proxim(). The naming between
these two functions can be confusing so this patch combines the
two to avoid the confusion.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 38027ee..fa2b283 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -200,6 +200,13 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
 	unsigned int data;
 	int ret;
 
+	if (!chip->enable_prox) {
+		ret = isl29028_enable_proximity(chip);
+		if (ret < 0)
+			return ret;
+		chip->enable_prox = true;
+	}
+
 	ret = regmap_read(chip->regmap, ISL29028_REG_PROX_DATA, &data);
 	if (ret < 0) {
 		dev_err(dev, "Error in reading register %d, error %d\n",
@@ -210,19 +217,6 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
 	return 0;
 }
 
-static int isl29028_proxim_get(struct isl29028_chip *chip, int *prox_data)
-{
-	int ret;
-
-	if (!chip->enable_prox) {
-		ret = isl29028_enable_proximity(chip);
-		if (ret < 0)
-			return ret;
-		chip->enable_prox = true;
-	}
-	return isl29028_read_proxim(chip, prox_data);
-}
-
 static int isl29028_als_get(struct isl29028_chip *chip, int *als_data)
 {
 	struct device *dev = regmap_get_device(chip->regmap);
@@ -362,7 +356,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 			ret = isl29028_ir_get(chip, val);
 			break;
 		case IIO_PROXIMITY:
-			ret = isl29028_proxim_get(chip, val);
+			ret = isl29028_read_proxim(chip, val);
 			break;
 		default:
 			break;
-- 
2.7.4

