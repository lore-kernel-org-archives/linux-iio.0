Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 2/4] iio: ltr501: Add interrupt support
Date: Wed,  1 Apr 2015 20:51:45 -0700
Message-Id: <47872dd6ba1e9170a9b0676fe62852de7ab7cb29.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds interrupt support for Liteon 501 chip.

Interrupt will be generated whenever ALS or proximity
data exceeds values given in upper and lower threshold
register settings.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 302 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 299 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 883855a..8672962 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -9,7 +9,7 @@
  *
  * 7-bit I2C slave address 0x23
  *
- * TODO: interrupt, threshold, measurement rate, IR LED characteristics
+ * TODO: measurement rate, IR LED characteristics
  */
 
 #include <linux/module.h>
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
@@ -33,6 +34,11 @@
 #define LTR501_ALS_DATA0 0x8a /* 16-bit, little endian */
 #define LTR501_ALS_PS_STATUS 0x8c
 #define LTR501_PS_DATA 0x8d /* 16-bit, little endian */
+#define LTR501_INTR 0x8f /* output mode, polarity, mode */
+#define LTR501_PS_THRESH_UP 0x90 /* 11 bit, ps upper threshold */
+#define LTR501_PS_THRESH_LOW 0x92 /* 11 bit, ps lower threshold */
+#define LTR501_ALS_THRESH_UP 0x97 /* 16 bit, ALS upper threshold */
+#define LTR501_ALS_THRESH_LOW 0x99 /* 16 bit, ALS lower threshold */
 
 #define LTR501_ALS_CONTR_SW_RESET BIT(2)
 #define LTR501_CONTR_PS_GAIN_MASK (BIT(3) | BIT(2))
@@ -40,10 +46,28 @@
 #define LTR501_CONTR_ALS_GAIN_MASK BIT(3)
 #define LTR501_CONTR_ACTIVE BIT(1)
 
+#define LTR501_STATUS_ALS_INTR BIT(3)
 #define LTR501_STATUS_ALS_RDY BIT(2)
+#define LTR501_STATUS_PS_INTR BIT(1)
 #define LTR501_STATUS_PS_RDY BIT(0)
 
+#define LTR501_INTR_OUTPUT_MODE_MASK BIT(3)
+#define LTR501_INTR_OUTPUT_MODE_LATCHED ~BIT(3)
+#define LTR501_INTR_OUTPUT_MODE_DIRECT BIT(3)
+#define LTR501_INTR_POLARITY_MASK BIT(2)
+#define LTR501_INTR_POLARITY_LOGIC_0 ~BIT(2)
+#define LTR501_INTR_POLARITY_LOGIC_1 BIT(2)
+#define LTR501_INTR_MODE_MASK (BIT(1) | BIT(0))
+#define LTR501_INTR_MODE_NONE 0
+#define LTR501_INTR_MODE_PS_MASK BIT(0)
+#define LTR501_INTR_MODE_PS BIT(0)
+#define LTR501_INTR_MODE_ALS_MASK BIT(1)
+#define LTR501_INTR_MODE_ALS BIT(1)
+#define LTR501_INTR_MODE_ALS_PS 3
+
 #define LTR501_PS_DATA_MASK 0x7ff
+#define LTR501_PS_THRESH_MASK 0x7ff
+#define LTR501_ALS_THRESH_MASK 0xffff
 
 struct ltr501_data {
 	struct i2c_client *client;
@@ -70,6 +94,20 @@ static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
 	return -EIO;
 }
 
+static int ltr501_set_intr_reg(struct ltr501_data *data, u8 mask, u8 val)
+{
+	int ret;
+	u8 new_val;
+
+	ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR);
+	if (ret < 0)
+		return ret;
+
+	new_val = (ret & ~mask) | (val & mask);
+
+	return i2c_smbus_write_byte_data(data->client, LTR501_INTR, new_val);
+}
+
 static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
 {
 	int ret = ltr501_drdy(data, LTR501_STATUS_ALS_RDY);
@@ -89,6 +127,43 @@ static int ltr501_read_ps(struct ltr501_data *data)
 	return i2c_smbus_read_word_data(data->client, LTR501_PS_DATA);
 }
 
+static const struct iio_event_spec ltr501_als_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+
+};
+
+static const struct iio_event_spec ltr501_pxs_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 #define LTR501_INTENSITY_CHANNEL(_idx, _addr, _mod, _shared) { \
 	.type = IIO_INTENSITY, \
 	.modified = 1, \
@@ -102,7 +177,9 @@ static int ltr501_read_ps(struct ltr501_data *data)
 		.realbits = 16, \
 		.storagebits = 16, \
 		.endianness = IIO_CPU, \
-	} \
+	}, \
+	.event_spec = ltr501_als_event_spec,\
+	.num_event_specs = ARRAY_SIZE(ltr501_als_event_spec),\
 }
 
 static const struct iio_chan_spec ltr501_channels[] = {
@@ -121,6 +198,8 @@ static const struct iio_chan_spec ltr501_channels[] = {
 			.storagebits = 16,
 			.endianness = IIO_CPU,
 		},
+		.event_spec = ltr501_pxs_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
@@ -238,6 +317,167 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ltr501_read_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int *val, int *val2)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       LTR501_ALS_THRESH_UP);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       LTR501_ALS_THRESH_LOW);
+			break;
+		default:
+			break;
+		}
+		mutex_unlock(&data->lock_als);
+		*val = ret & LTR501_ALS_THRESH_MASK;
+		break;
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       LTR501_PS_THRESH_UP);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_read_word_data(data->client,
+						       LTR501_PS_THRESH_LOW);
+			break;
+		default:
+			break;
+		}
+		mutex_unlock(&data->lock_ps);
+		*val = ret & LTR501_PS_THRESH_MASK;
+		break;
+	default:
+		break;
+	}
+
+	return ret < 0 ? ret : IIO_VAL_INT;
+}
+
+static int ltr501_write_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info, int val,
+		int val2)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	u16 new_val = 0;
+	int ret = -EINVAL;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		new_val = val & LTR501_ALS_THRESH_MASK;
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_write_word_data(data->client,
+							LTR501_ALS_THRESH_UP,
+							new_val);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_write_word_data(data->client,
+							LTR501_ALS_THRESH_LOW,
+							new_val);
+			break;
+		default:
+			break;
+		}
+		mutex_unlock(&data->lock_als);
+		break;
+	case IIO_PROXIMITY:
+		switch (dir) {
+		mutex_lock(&data->lock_ps);
+		new_val = val & LTR501_PS_THRESH_MASK;
+		case IIO_EV_DIR_RISING:
+			ret = i2c_smbus_write_word_data(data->client,
+							LTR501_PS_THRESH_UP,
+							new_val);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = i2c_smbus_write_word_data(data->client,
+							LTR501_PS_THRESH_LOW,
+							new_val);
+			break;
+		default:
+			break;
+		}
+		mutex_unlock(&data->lock_ps);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret < 0 ? ret : IIO_VAL_INT;
+}
+
+static int ltr501_read_event_config(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan,
+		enum iio_event_type type,
+		enum iio_event_direction dir)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR);
+		mutex_unlock(&data->lock_als);
+		return ret < 0 ? ret : ret & LTR501_INTR_MODE_ALS_MASK;
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR);
+		mutex_unlock(&data->lock_ps);
+		return ret < 0 ? ret : ret & LTR501_INTR_MODE_PS_MASK;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int ltr501_write_event_config(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, int state)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		ret = ltr501_set_intr_reg(data, LTR501_INTR_MODE_ALS_MASK,
+					  (state ? LTR501_INTR_MODE_ALS :
+					  LTR501_INTR_MODE_NONE));
+		mutex_unlock(&data->lock_als);
+		break;
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		ret = ltr501_set_intr_reg(data, LTR501_INTR_MODE_PS_MASK,
+					  (state ? LTR501_INTR_MODE_PS :
+					  LTR501_INTR_MODE_NONE));
+		mutex_unlock(&data->lock_ps);
+		break;
+	default:
+		break;
+	}
+
+	return ret < 0 ? ret : IIO_VAL_INT;
+}
+
 static IIO_CONST_ATTR(in_proximity_scale_available, "1 0.25 0.125 0.0625");
 static IIO_CONST_ATTR(in_intensity_scale_available, "1 0.005");
 
@@ -251,10 +491,21 @@ static const struct attribute_group ltr501_attribute_group = {
 	.attrs = ltr501_attributes,
 };
 
+static const struct iio_info ltr501_info_no_irq = {
+	.read_raw = ltr501_read_raw,
+	.write_raw = ltr501_write_raw,
+	.attrs = &ltr501_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static const struct iio_info ltr501_info = {
 	.read_raw = ltr501_read_raw,
 	.write_raw = ltr501_write_raw,
 	.attrs = &ltr501_attribute_group,
+	.read_event_value	= &ltr501_read_thresh,
+	.write_event_value	= &ltr501_write_thresh,
+	.read_event_config	= &ltr501_read_event_config,
+	.write_event_config	= &ltr501_write_event_config,
 	.driver_module = THIS_MODULE,
 };
 
@@ -319,6 +570,36 @@ done:
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t ltr501_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *dev_info = private;
+	struct ltr501_data *data = iio_priv(dev_info);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, LTR501_ALS_PS_STATUS);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"irq read int reg failed\n");
+		return IRQ_HANDLED;
+	}
+
+	if (ret & LTR501_STATUS_ALS_INTR)
+		iio_push_event(dev_info,
+			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
+			       IIO_EV_TYPE_THRESH,
+			       IIO_EV_DIR_EITHER),
+			       iio_get_time_ns());
+
+	if (ret & LTR501_STATUS_PS_INTR)
+		iio_push_event(dev_info,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+			       IIO_EV_TYPE_THRESH,
+			       IIO_EV_DIR_EITHER),
+			       iio_get_time_ns());
+
+	return IRQ_HANDLED;
+}
+
 static int ltr501_init(struct ltr501_data *data)
 {
 	int ret;
@@ -361,7 +642,6 @@ static int ltr501_probe(struct i2c_client *client,
 		return -ENODEV;
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ltr501_info;
 	indio_dev->channels = ltr501_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ltr501_channels);
 	indio_dev->name = LTR501_DRV_NAME;
@@ -371,6 +651,22 @@ static int ltr501_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	if (client->irq > 0) {
+		indio_dev->info = &ltr501_info;
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, ltr501_interrupt_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"ltr501_thresh_event",
+						indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "request irq (%d) failed\n",
+					client->irq);
+			return ret;
+		}
+	} else
+		indio_dev->info = &ltr501_info_no_irq;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 ltr501_trigger_handler, NULL);
 	if (ret)
-- 
1.9.1
