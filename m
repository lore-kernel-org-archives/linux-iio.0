Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44514 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076AbcDGQWj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Apr 2016 12:22:39 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 2/5] max44000: Initial support for proximity reading
Date: Thu,  7 Apr 2016 19:21:51 +0300
Message-Id: <807fa69227e6745e73c207ca0b2af59255893bdb.1460045763.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460045763.git.leonard.crestez@intel.com>
References: <cover.1460045763.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460045763.git.leonard.crestez@intel.com>
References: <cover.1460045763.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The proximity sensor relies on sending pulses to an external IR led and
it is disabled by default on powerup. The driver will enable it with a
default power setting.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/light/max44000.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 7c12153..10a0fe8 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -41,6 +41,23 @@
 #define MAX44000_REG_TRIM_GAIN_GREEN	0x0f
 #define MAX44000_REG_TRIM_GAIN_IR	0x10
 
+/* REG_CFG bits */
+#define MAX44000_CFG_ALSINTE		0x01
+#define MAX44000_CFG_PRXINTE		0x02
+#define MAX44000_CFG_MASK		0x1c
+#define MAX44000_CFG_MODE_SHUTDOWN	0x00
+#define MAX44000_CFG_MODE_ALS_GIR	0x04
+#define MAX44000_CFG_MODE_ALS_G		0x08
+#define MAX44000_CFG_MODE_ALS_IR	0x0c
+#define MAX44000_CFG_MODE_ALS_PRX	0x10
+#define MAX44000_CFG_MODE_PRX		0x14
+#define MAX44000_CFG_TRIM		0x20
+
+/* REG_TX bits */
+#define MAX44000_LED_CURRENT_MASK	0xf
+#define MAX44000_LED_CURRENT_MAX	11
+#define MAX44000_LED_CURRENT_DEFAULT	6
+
 #define MAX44000_ALSDATA_OVERFLOW	0x4000
 
 #define MAX44000_REGMASK_READABLE	0x419fff
@@ -60,6 +77,12 @@ static const struct iio_chan_spec max44000_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
@@ -90,11 +113,23 @@ static inline int max44000_read_alsval(struct max44000_data *data)
 	return regval;
 }
 
+static inline int max44000_write_led_current_raw(struct max44000_data *data, int val)
+{
+	/* Maybe we should clamp the value instead? */
+	if (val < 0 || val > MAX44000_LED_CURRENT_MAX)
+		return -ERANGE;
+	if (val >= 8)
+		val += 4;
+	return regmap_write_bits(data->regmap, MAX44000_REG_CFG_TX,
+				 MAX44000_LED_CURRENT_MASK, val);
+}
+
 static int max44000_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
 {
 	struct max44000_data *data = iio_priv(indio_dev);
+	unsigned int regval;
 	int ret;
 
 	switch (mask) {
@@ -109,6 +144,15 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
 			*val = ret;
 			return IIO_VAL_INT;
 
+		case IIO_PROXIMITY:
+			mutex_lock(&data->lock);
+			ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			*val = regval;
+			return IIO_VAL_INT;
+
 		default:
 			return -EINVAL;
 		}
@@ -244,6 +288,23 @@ static int max44000_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* By default the LED pulse used for the proximity sensor is disabled.
+	 * Set a middle value so that we get some sort of valid data by default.
+	 */
+	ret = max44000_write_led_current_raw(data, MAX44000_LED_CURRENT_DEFAULT);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "failed to write init config: %d\n", ret);
+		return ret;
+	}
+
+	/* By default set in ALS_PRX mode which allows easy reading of both values. */
+	reg = MAX44000_CFG_TRIM | MAX44000_CFG_MODE_ALS_PRX;
+	ret = regmap_write(data->regmap, MAX44000_REG_CFG_MAIN, reg);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "failed to write init config: %d\n", ret);
+		return ret;
+	}
+
 	return iio_device_register(indio_dev);
 }
 
-- 
2.8.0.rc3

