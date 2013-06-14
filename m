Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1059 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751176Ab3FNP6g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2013 11:58:36 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] staging:iio:ad7291: Use i2c_smbus_{read,write}_word_swapped instead of open-coding it
Date: Fri, 14 Jun 2013 17:58:26 +0200
Message-Id: <1371225508-32190-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-1-git-send-email-lars@metafoo.de>
References: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

No need to swap the upper and lower byte by hand if there is a helper function
which already does this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index bf8d689..2a7e6a7 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -87,20 +87,20 @@ static int ad7291_i2c_read(struct ad7291_chip_info *chip, u8 reg, u16 *data)
 	struct i2c_client *client = chip->client;
 	int ret = 0;
 
-	ret = i2c_smbus_read_word_data(client, reg);
+	ret = i2c_smbus_read_word_swapped(client, reg);
 	if (ret < 0) {
 		dev_err(&client->dev, "I2C read error\n");
 		return ret;
 	}
 
-	*data = swab16((u16)ret);
+	*data = ret;
 
 	return 0;
 }
 
 static int ad7291_i2c_write(struct ad7291_chip_info *chip, u8 reg, u16 data)
 {
-	return i2c_smbus_write_word_data(chip->client, reg, swab16(data));
+	return i2c_smbus_write_word_swapped(chip->client, reg, data);
 }
 
 static irqreturn_t ad7291_event_handler(int irq, void *private)
@@ -418,35 +418,33 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 				return ret;
 			}
 			/* Read voltage */
-			ret = i2c_smbus_read_word_data(chip->client,
+			ret = i2c_smbus_read_word_swapped(chip->client,
 						       AD7291_VOLTAGE);
 			if (ret < 0) {
 				mutex_unlock(&chip->state_lock);
 				return ret;
 			}
-			*val = swab16((u16)ret) & AD7291_VALUE_MASK;
+			*val = ret & AD7291_VALUE_MASK;
 			mutex_unlock(&chip->state_lock);
 			return IIO_VAL_INT;
 		case IIO_TEMP:
 			/* Assumes tsense bit of command register always set */
-			ret = i2c_smbus_read_word_data(chip->client,
+			ret = i2c_smbus_read_word_swapped(chip->client,
 						       AD7291_T_SENSE);
 			if (ret < 0)
 				return ret;
-			signval = (s16)((swab16((u16)ret) &
-				AD7291_VALUE_MASK) << 4) >> 4;
+			signval = (s16)((ret & AD7291_VALUE_MASK) << 4) >> 4;
 			*val = signval;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_AVERAGE_RAW:
-		ret = i2c_smbus_read_word_data(chip->client,
+		ret = i2c_smbus_read_word_swapped(chip->client,
 					       AD7291_T_AVERAGE);
 			if (ret < 0)
 				return ret;
-			signval = (s16)((swab16((u16)ret) &
-				AD7291_VALUE_MASK) << 4) >> 4;
+			signval = (s16)((ret & AD7291_VALUE_MASK) << 4) >> 4;
 			*val = signval;
 			return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
1.8.0

