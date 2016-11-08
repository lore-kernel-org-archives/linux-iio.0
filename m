Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47000 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933277AbcKHKRE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:17:04 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 09/23] staging: iio: tsl2583: cleaned up logging
Date: Tue,  8 Nov 2016 05:16:34 -0500
Message-Id: <1478600208-21153-10-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are several places in the code where the function name is
hardcoded in the log message. Use the __func__ constant string to build
the log message. This also clarifies some of the error messages to match
the code and ensures that the correct priority is used since the message
is already being changed.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 51 ++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index a03f845..c797ab0 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -170,13 +170,15 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 
 	ret = i2c_smbus_read_byte_data(chip->client, TSL258X_CMD_REG);
 	if (ret < 0) {
-		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
+		dev_err(&chip->client->dev, "%s failed to read CMD_REG register\n",
+			__func__);
 		goto done;
 	}
 
 	/* is data new & valid */
 	if (!(ret & TSL258X_STA_ADC_INTR)) {
-		dev_err(&chip->client->dev, "taos_get_lux data not valid\n");
+		dev_err(&chip->client->dev, "%s: data not valid; returning last value\n",
+			__func__);
 		ret = chip->als_cur_info.lux; /* return LAST VALUE */
 		goto done;
 	}
@@ -186,9 +188,8 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 
 		ret = i2c_smbus_read_byte_data(chip->client, reg);
 		if (ret < 0) {
-			dev_err(&chip->client->dev,
-				"taos_get_lux failed to read register %x\n",
-				reg);
+			dev_err(&chip->client->dev, "%s failed to read register %x\n",
+				__func__, reg);
 			goto done;
 		}
 		buf[i] = ret;
@@ -203,9 +204,8 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 				    TSL258X_CMD_ALS_INT_CLR));
 
 	if (ret < 0) {
-		dev_err(&chip->client->dev,
-			"taos_i2c_write_command failed in taos_get_lux, err = %d\n",
-			ret);
+		dev_err(&chip->client->dev, "%s failed to clear the interrupt bit\n",
+			__func__);
 		goto done; /* have no data, so return failure */
 	}
 
@@ -246,7 +246,8 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 
 	/* note: lux is 31 bit max at this point */
 	if (ch1lux > ch0lux) {
-		dev_dbg(&chip->client->dev, "No Data - Return last value\n");
+		dev_dbg(&chip->client->dev, "%s: No Data - Returning 0\n",
+			__func__);
 		ret = 0;
 		chip->als_cur_info.lux = 0;
 		goto done;
@@ -309,16 +310,17 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 	if ((ret & (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON))
 			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
 		dev_err(&chip->client->dev,
-			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
+			"%s failed: device not powered on with ADC enabled\n",
+			__func__);
 		return -EINVAL;
 	} else if ((ret & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
 		dev_err(&chip->client->dev,
-			"taos_als_calibrate failed: STATUS - ADC not valid.\n");
+			"%s failed: STATUS - ADC not valid.\n", __func__);
 		return -ENODATA;
 	}
 	lux_val = taos_get_lux(indio_dev);
 	if (lux_val < 0) {
-		dev_err(&chip->client->dev, "taos_als_calibrate failed to get lux\n");
+		dev_err(&chip->client->dev, "%s failed to get lux\n", __func__);
 		return lux_val;
 	}
 	gain_trim_val = (unsigned int)(((chip->taos_settings.als_cal_target)
@@ -326,8 +328,8 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 
 	if ((gain_trim_val < 250) || (gain_trim_val > 4000)) {
 		dev_err(&chip->client->dev,
-			"taos_als_calibrate failed: trim_val of %d is out of range\n",
-			gain_trim_val);
+			"%s failed: trim_val of %d is not within the range [250, 4000]\n",
+			__func__, gain_trim_val);
 		return -ENODATA;
 	}
 	chip->taos_settings.als_gain_trim = (int)gain_trim_val;
@@ -526,6 +528,8 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 	return offset;
 }
 
+#define TSL2583_MAX_LUX_INTS ((ARRAY_SIZE(taos_device_lux) - 1) * 3)
+
 static ssize_t in_illuminance_lux_table_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t len)
@@ -545,12 +549,15 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 	 * and the last table entry is all 0.
 	 */
 	n = value[0];
-	if ((n % 3) || n < 6 || n > ((ARRAY_SIZE(taos_device_lux) - 1) * 3)) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
+	if ((n % 3) || n < 6 || n > TSL2583_MAX_LUX_INTS) {
+		dev_err(dev,
+			"%s: The number of entries in the lux table must be a multiple of 3 and within the range [6, %zu]",
+			__func__, TSL2583_MAX_LUX_INTS);
 		goto done;
 	}
 	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
+		dev_err(dev, "%s: The last 3 entries in the lux table must be zeros.\n",
+			__func__);
 		goto done;
 	}
 
@@ -756,7 +763,8 @@ static int taos_probe(struct i2c_client *clientp,
 
 	if (!i2c_check_functionality(clientp->adapter,
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&clientp->dev, "taos_probe() - i2c smbus byte data func unsupported\n");
+		dev_err(&clientp->dev, "%s: i2c smbus byte data functionality is unsupported\n",
+			__func__);
 		return -EOPNOTSUPP;
 	}
 
@@ -779,8 +787,8 @@ static int taos_probe(struct i2c_client *clientp,
 	}
 
 	if ((ret & TSL2583_CHIP_ID_MASK) != TSL2583_CHIP_ID) {
-		dev_info(&clientp->dev, "%s received an unknown chip ID %x\n",
-			 __func__, ret);
+		dev_err(&clientp->dev, "%s received an unknown chip ID %x\n",
+			__func__, ret);
 		return -EINVAL;
 	}
 
@@ -792,7 +800,8 @@ static int taos_probe(struct i2c_client *clientp,
 	indio_dev->name = chip->client->name;
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret) {
-		dev_err(&clientp->dev, "iio registration failed\n");
+		dev_err(&clientp->dev, "%s: iio registration failed\n",
+			__func__);
 		return ret;
 	}
 
-- 
2.7.4

