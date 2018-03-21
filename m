Return-Path: <SRS0=Ao9w=GL=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 06/11] staging: iio: tsl2x7x: make logging consistent and correct newlines
Date: Wed, 21 Mar 2018 06:29:07 -0400
Message-Id: <20180321102912.5130-7-masneyb@onstation.org>
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This patch updates all of the logging commands so that they are
consistent with the other messages, includes __func__ in the message,
and all of the messages include newlines. This patch also removes some
debug log messages.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Remove some debug messages and every log message doesn't have to have
  the function name.
- Earlier patches in this current series dropped some of the debug
  messages that were in v1.

 drivers/staging/iio/light/tsl2x7x.c | 42 ++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index f7e7fcc17059..07ce3076a05d 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -374,7 +374,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		ret = i2c_smbus_read_byte_data(chip->client, reg);
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
-				"failed to read. err=%x\n", ret);
+				"%s: failed to read from register %x: %d\n",
+				__func__, reg, ret);
 			goto out_unlock;
 		}
 
@@ -416,7 +417,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 
 	/* note: lux is 31 bit max at this point */
 	if (ch1lux > ch0lux) {
-		dev_dbg(&chip->client->dev, "ch1lux > ch0lux-return last value\n");
+		dev_dbg(&chip->client->dev,
+			"%s: ch1lux > ch0lux; returning last value\n",
+			__func__);
 		ret = chip->als_cur_info.lux;
 		goto out_unlock;
 	}
@@ -591,8 +594,6 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 		return -ERANGE;
 
 	chip->settings.als_gain_trim = ret;
-	dev_info(&chip->client->dev,
-		 "%s als_calibrate completed\n", chip->client->name);
 
 	return ret;
 }
@@ -674,12 +675,14 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	 */
 	for (i = 0, dev_reg = chip->tsl2x7x_config;
 			i < TSL2X7X_MAX_CONFIG_REG; i++) {
-		ret = i2c_smbus_write_byte_data(chip->client,
-						TSL2X7X_CMD_REG + i,
+		int reg = TSL2X7X_CMD_REG + i;
+
+		ret = i2c_smbus_write_byte_data(chip->client, reg,
 						*dev_reg++);
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
-				"failed on write to reg %d.\n", i);
+				"%s: failed to write to register %x: %d\n",
+				__func__, reg, ret);
 			return ret;
 		}
 	}
@@ -907,15 +910,11 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 	 */
 	n = value[0];
 	if ((n % 3) || n < 6 ||
-	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3)) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
+	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3))
 		return -EINVAL;
-	}
 
-	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
+	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0)
 		return -EINVAL;
-	}
 
 	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
 		ret = tsl2x7x_chip_off(indio_dev);
@@ -1048,15 +1047,10 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 			chip->settings.persistence &= 0xF0;
 			chip->settings.persistence |=
 				(filter_delay & 0x0F);
-			dev_info(&chip->client->dev, "%s: ALS persistence = %d",
-				 __func__, filter_delay);
 		} else {
 			chip->settings.persistence &= 0x0F;
 			chip->settings.persistence |=
 				((filter_delay << 4) & 0xF0);
-			dev_info(&chip->client->dev,
-				 "%s: Proximity persistence = %d",
-				 __func__, filter_delay);
 		}
 		ret = 0;
 		break;
@@ -1269,9 +1263,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		chip->settings.als_time =
 			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
-
-		dev_info(&chip->client->dev, "%s: als time = %d",
-			 __func__, chip->settings.als_time);
 		break;
 	default:
 		return -EINVAL;
@@ -1633,8 +1624,9 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 
 	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
 	if (ret < 0) {
-		dev_err(&clientp->dev, "write to cmd reg failed. err = %d\n",
-			ret);
+		dev_err(&clientp->dev,
+			"%s: Failed to write to CMD register: %d\n",
+			__func__, ret);
 		return ret;
 	}
 
@@ -1664,7 +1656,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 						indio_dev);
 		if (ret) {
 			dev_err(&clientp->dev,
-				"%s: irq request failed", __func__);
+				"%s: irq request failed\n", __func__);
 			return ret;
 		}
 	}
@@ -1681,8 +1673,6 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 		return ret;
 	}
 
-	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
-
 	return 0;
 }
 
-- 
2.14.3
