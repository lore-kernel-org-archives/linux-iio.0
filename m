Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36778 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbcGUOlz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2016 10:41:55 -0400
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pratik Prajapati <pratik.prajapati12@gmail.com>
Subject: [PATCH 1/2] staging: iio: vcnl4000: Add IR current adjust support
Date: Thu, 21 Jul 2016 20:11:36 +0530
Message-Id: <1469112097-6806-1-git-send-email-pratik.prajapati12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Pratik Prajapati <pratik.prajapati12@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 78 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 360b6e9..1378175 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -11,7 +11,6 @@
  * IIO driver for VCNL4000 (7-bit I2C slave address 0x13)
  *
  * TODO:
- *   allow to adjust IR current
  *   proximity threshold and event handling
  *   periodic ALS/proximity measurement (VCNL4010/20)
  *   interrupts (VCNL4010/20)
@@ -46,6 +45,10 @@
 #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
 #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
 
+/* Bit mask for LED_CURRENT register */
+#define VCNL4000_LED_CURRENT_MASK	0x3F
+#define VCNL4000_LED_CURRENT_MAX	20
+
 struct vcnl4000_data {
 	struct i2c_client *client;
 	struct mutex lock;
@@ -111,9 +114,42 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}
+	}, {
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.extend_name = "led",
+		.output = 1,
+		.scan_index = -1,
+	},
 };
 
+static int vcnl4000_write_led_current_raw(struct vcnl4000_data *data, int val)
+{
+	int ret;
+
+	if (val < 0 || val > VCNL4000_LED_CURRENT_MAX)
+		return -ERANGE;
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_LED_CURRENT,
+			val);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int vcnl4000_read_led_current_raw(struct vcnl4000_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_LED_CURRENT);
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		return ret;
+	ret &= VCNL4000_LED_CURRENT_MASK;
+	return ret;
+}
+
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -138,23 +174,53 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			ret = vcnl4000_read_led_current_raw(data);
+			if (ret < 0)
+				return ret;
+			*val = ret;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
+
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type != IIO_LIGHT)
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*val = 0;
+			*val2 = 250000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_CURRENT:
+			/* Output register is in 10s of milliamps */
+			*val = 10;
+			return IIO_VAL_INT;
+		default:
 			return -EINVAL;
+		}
 
-		*val = 0;
-		*val2 = 250000;
-		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
+	return -EINVAL;
+}
+
+static int vcnl4000_write_raw(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					int val, int val2, long mask)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (mask == IIO_CHAN_INFO_RAW && chan->type == IIO_CURRENT) {
+		ret = vcnl4000_write_led_current_raw(data, val);
+		return ret;
+	}
+	return -EINVAL;
 }
 
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
+	.write_raw = vcnl4000_write_raw,
 	.driver_module = THIS_MODULE,
 };
 
-- 
2.6.2

