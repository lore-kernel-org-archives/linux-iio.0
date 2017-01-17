Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49066 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdAQJZU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:20 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 07/15] staging: iio: isl29028: move failure logging into isl29028_set_als_scale()
Date: Tue, 17 Jan 2017 04:24:54 -0500
Message-Id: <20170117092502.6951-8-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When isl29028_set_als_scale() fails, it was up to both callers to log
the failure message. This patch moves the logging into
isl29028_set_als_scale() to reduce the overall amount of code in the
driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index bd85ccb..8e7b3db 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -123,11 +123,22 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
 
 static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
 {
+	struct device *dev = regmap_get_device(chip->regmap);
 	int val = (lux_scale == 2000) ? ISL29028_CONF_ALS_RANGE_HIGH_LUX :
 					ISL29028_CONF_ALS_RANGE_LOW_LUX;
+	int ret;
+
+	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
+				 ISL29028_CONF_ALS_RANGE_MASK, val);
+	if (ret < 0) {
+		dev_err(dev, "%s(): Error %d setting the ALS scale\n", __func__,
+			ret);
+		return ret;
+	}
 
-	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-				  ISL29028_CONF_ALS_RANGE_MASK, val);
+	chip->lux_scale = lux_scale;
+
+	return ret;
 }
 
 static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
@@ -318,13 +329,6 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 		}
 
 		ret = isl29028_set_als_scale(chip, val);
-		if (ret < 0) {
-			dev_err(dev,
-				"Setting lux scale fail with error %d\n", ret);
-			break;
-		}
-
-		chip->lux_scale = val;
 		break;
 	default:
 		dev_err(dev, "Unsupported channel type\n");
@@ -443,10 +447,7 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
 	if (ret < 0)
 		return ret;
 
-	ret = isl29028_set_als_scale(chip, chip->lux_scale);
-	if (ret < 0)
-		dev_err(dev, "setting als scale failed, err = %d\n", ret);
-	return ret;
+	return isl29028_set_als_scale(chip, chip->lux_scale);
 }
 
 static bool isl29028_is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.9.3

