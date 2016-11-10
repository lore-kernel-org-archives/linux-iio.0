Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50364 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754883AbcKJJ0L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:11 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 02/28] staging: iio: tsl2583: fix issue with changes to calibscale and int_time not being set on the chip
Date: Thu, 10 Nov 2016 04:25:38 -0500
Message-Id: <1478769964-7065-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When updating the in_illuminance_calibscale and
in_illuminance_integration_time sysfs attributes, these values were not
actually written to the chip. The chip would continue to use the old
parameters. Extracted out tsl2583_set_als_gain() and
tsl2583_set_als_time() functions that are now called when these sysfs
attributes are updated. The chip initialization also calls these these
new functions.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 85 +++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index c196a42..1a7be12 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -352,6 +352,51 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 	return (int)gain_trim_val;
 }
 
+static int tsl2583_set_als_time(struct tsl2583_chip *chip)
+{
+	int als_count, als_time, ret;
+	u8 val;
+
+	/* determine als integration register */
+	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
+	if (!als_count)
+		als_count = 1; /* ensure at least one cycle */
+
+	/* convert back to time (encompasses overrides) */
+	als_time = (als_count * 27 + 5) / 10;
+
+	val = 256 - als_count;
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_ALS_TIME,
+					val);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "%s failed to set the als time to %d\n",
+			__func__, val);
+		return ret;
+	}
+
+	/* set chip struct re scaling and saturation */
+	chip->als_saturation = als_count * 922; /* 90% of full scale */
+	chip->als_time_scale = (als_time + 25) / 50;
+
+	return ret;
+}
+
+static int tsl2583_set_als_gain(struct tsl2583_chip *chip)
+{
+	int ret;
+
+	/* Set the gain based on taos_settings struct */
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL258X_CMD_REG | TSL258X_GAIN,
+					chip->taos_settings.als_gain);
+	if (ret < 0)
+		dev_err(&chip->client->dev, "%s failed to set the gain to %d\n",
+			__func__, chip->taos_settings.als_gain);
+
+	return ret;
+}
+
 static int tsl2583_set_power_state(struct tsl2583_chip *chip, u8 state)
 {
 	int ret;
@@ -371,10 +416,8 @@ static int tsl2583_set_power_state(struct tsl2583_chip *chip, u8 state)
  */
 static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 {
-	int ret, val;
-	int als_count;
-	int als_time;
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
+	int ret;
 
 	/* and make sure we're not already on */
 	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
@@ -397,37 +440,13 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	/* determine als integration register */
-	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
-	if (!als_count)
-		als_count = 1; /* ensure at least one cycle */
-
-	/* convert back to time (encompasses overrides) */
-	als_time = (als_count * 27 + 5) / 10;
-
-	val = 256 - als_count;
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_ALS_TIME,
-					val);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "%s failed to set the als time to %d\n",
-			__func__, val);
+	ret = tsl2583_set_als_time(chip);
+	if (ret < 0)
 		return ret;
-	}
 
-	/* Set the gain based on taos_settings struct */
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL258X_CMD_REG | TSL258X_GAIN,
-					chip->taos_settings.als_gain);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "%s failed to set the gain to %d\n",
-			__func__, chip->taos_settings.als_gain);
+	ret = tsl2583_set_als_gain(chip);
+	if (ret < 0)
 		return ret;
-	}
-
-	/* set chip struct re scaling and saturation */
-	chip->als_saturation = als_count * 922; /* 90% of full scale */
-	chip->als_time_scale = (als_time + 25) / 50;
 
 	usleep_range(3000, 3500);
 
@@ -707,7 +726,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 			for (i = 0; i < ARRAY_SIZE(gainadj); i++) {
 				if (gainadj[i].mean == val) {
 					chip->taos_settings.als_gain = i;
-					ret = 0;
+					ret = tsl2583_set_als_gain(chip);
 					break;
 				}
 			}
@@ -717,7 +736,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 		if (chan->type == IIO_LIGHT && !val && val2 >= 50 &&
 		    val2 <= 650 && !(val2 % 50)) {
 			chip->taos_settings.als_time = val2;
-			ret = 0;
+			ret = tsl2583_set_als_time(chip);
 		}
 		break;
 	default:
-- 
2.7.4

