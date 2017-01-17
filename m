Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49002 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbdAQJZQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:16 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 03/15] staging: iio: isl29028: combine isl29028_proxim_get() and isl29028_read_proxim()
Date: Tue, 17 Jan 2017 04:24:50 -0500
Message-Id: <20170117092502.6951-4-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
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
index 74eb736..a13c8db 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -201,6 +201,13 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
 	unsigned int data;
 	int ret;
 
+	if (!chip->enable_prox) {
+		ret = isl29028_enable_proximity(chip, true);
+		if (ret < 0)
+			return ret;
+		chip->enable_prox = true;
+	}
+
 	ret = regmap_read(chip->regmap, ISL29028_REG_PROX_DATA, &data);
 	if (ret < 0) {
 		dev_err(dev, "Error in reading register %d, error %d\n",
@@ -211,19 +218,6 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
 	return 0;
 }
 
-static int isl29028_proxim_get(struct isl29028_chip *chip, int *prox_data)
-{
-	int ret;
-
-	if (!chip->enable_prox) {
-		ret = isl29028_enable_proximity(chip, true);
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
@@ -349,7 +343,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 			ret = isl29028_ir_get(chip, val);
 			break;
 		case IIO_PROXIMITY:
-			ret = isl29028_proxim_get(chip, val);
+			ret = isl29028_read_proxim(chip, val);
 			break;
 		default:
 			break;
-- 
2.9.3

