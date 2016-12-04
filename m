Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47180 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752456AbcLDCUX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:23 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 13/19] staging: iio: isl29028: move failure logging into isl29028_set_proxim_sampling()
Date: Sat,  3 Dec 2016 21:19:37 -0500
Message-Id: <1480817983-32359-14-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When isl29028_set_proxim_sampling() fails, it was up to both callers to
log the failure message. This patch moves the logging into
isl29028_set_proxim_sampling() to reduce the overall amount of code in
the driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 23a4db8..0c8a878 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -79,18 +79,28 @@ struct isl29028_chip {
 static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
 					unsigned int sampling)
 {
+	struct device *dev = regmap_get_device(chip->regmap);
 	static unsigned int prox_period[] = {800, 400, 200, 100, 75, 50, 12, 0};
 	unsigned int sel;
 	unsigned int period = DIV_ROUND_UP(1000, sampling);
+	int ret;
 
 	for (sel = 0; sel < ARRAY_SIZE(prox_period); ++sel) {
 		if (period >= prox_period[sel])
 			break;
 	}
 
-	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-				  ISL29028_CONF_PROX_SLP_MASK,
-				  sel << ISL29028_CONF_PROX_SLP_SH);
+	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
+				 ISL29028_CONF_PROX_SLP_MASK,
+				 sel << ISL29028_CONF_PROX_SLP_SH);
+	if (ret < 0)
+		dev_err(dev,
+			"%s(): Error %d setting the proximity sampling\n",
+			__func__, ret);
+	else
+		chip->prox_sampling = sampling;
+
+	return ret;
 }
 
 static int isl29028_enable_proximity(struct isl29028_chip *chip)
@@ -296,14 +306,6 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 		}
 
 		ret = isl29028_set_proxim_sampling(chip, val);
-		if (ret < 0) {
-			dev_err(dev,
-				"Setting proximity samp_freq fail, err %d\n",
-				ret);
-			break;
-		}
-
-		chip->prox_sampling = val;
 		break;
 	case IIO_LIGHT:
 		if (mask != IIO_CHAN_INFO_SCALE) {
@@ -452,10 +454,8 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
 	}
 
 	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
-	if (ret < 0) {
-		dev_err(dev, "setting the proximity, err = %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = isl29028_set_als_scale(chip, chip->lux_scale);
 	if (ret < 0)
-- 
2.7.4

