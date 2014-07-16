Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41223 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934929AbaGPSdG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:06 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 07/13] iio:bma180: Expose temperature channel
Date: Wed, 16 Jul 2014 20:32:50 +0200
Message-Id: <1405535576-26482-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

8-bit signed; 0 LSB @ 24 °C, 0.5 °C per LSB

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 80 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index aa7566f..91260a0 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -29,6 +29,7 @@
 /* Register set */
 #define BMA180_CHIP_ID		0x00 /* Need to distinguish BMA180 from other */
 #define BMA180_ACC_X_LSB	0x02 /* First of 6 registers of accel data */
+#define BMA180_TEMP		0x08
 #define BMA180_CTRL_REG0	0x0d
 #define BMA180_RESET		0x10
 #define BMA180_BW_TCS		0x20
@@ -84,27 +85,37 @@ struct bma180_data {
 	char *buff;
 };
 
-enum bma180_axis {
+enum bma180_chan {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	TEMP
 };
 
 static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
 static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
-static int bma180_get_acc_reg(struct bma180_data *data, enum bma180_axis axis)
+static int bma180_get_data_reg(struct bma180_data *data, enum bma180_chan chan)
 {
-	u8 reg = BMA180_ACC_X_LSB + axis * 2;
 	int ret;
 
 	if (data->sleep_state)
 		return -EBUSY;
 
-	ret = i2c_smbus_read_word_data(data->client, reg);
-	if (ret < 0)
-		dev_err(&data->client->dev,
-			"failed to read accel_%c register\n", 'x' + axis);
+	switch (chan) {
+	case TEMP:
+		ret = i2c_smbus_read_byte_data(data->client, BMA180_TEMP);
+		if (ret < 0)
+			dev_err(&data->client->dev, "failed to read temp register\n");
+		break;
+	default:
+		ret = i2c_smbus_read_word_data(data->client,
+			BMA180_ACC_X_LSB + chan * 2);
+		if (ret < 0)
+			dev_err(&data->client->dev,
+				"failed to read accel_%c register\n",
+				'x' + chan);
+	}
 
 	return ret;
 }
@@ -337,22 +348,35 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->mutex);
-		if (iio_buffer_enabled(indio_dev))
-			ret = -EBUSY;
-		else
-			ret = bma180_get_acc_reg(data, chan->scan_index);
+		if (iio_buffer_enabled(indio_dev)) {
+			mutex_unlock(&data->mutex);
+			return -EBUSY;
+		}
+		ret = bma180_get_data_reg(data, chan->scan_index);
 		mutex_unlock(&data->mutex);
 		if (ret < 0)
 			return ret;
-		*val = (s16)ret >> chan->scan_type.shift;
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+			chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*val = data->bw;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = data->scale;
-		return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = data->scale;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 500;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 48; /* 0 LSB @ 24 degree C */
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -443,7 +467,7 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	{ },
 };
 
-#define BMA180_CHANNEL(_axis) {					\
+#define BMA180_ACC_CHANNEL(_axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##_axis,					\
@@ -460,11 +484,24 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	.ext_info = bma180_ext_info,					\
 }
 
+#define BMA180_TEMP_CHANNEL {						\
+	.type = IIO_TEMP,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),	\
+	.scan_index = TEMP,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 8,						\
+		.storagebits = 16,					\
+	},								\
+}
+
 static const struct iio_chan_spec bma180_channels[] = {
-	BMA180_CHANNEL(X),
-	BMA180_CHANNEL(Y),
-	BMA180_CHANNEL(Z),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
+	BMA180_ACC_CHANNEL(X),
+	BMA180_ACC_CHANNEL(Y),
+	BMA180_ACC_CHANNEL(Z),
+	BMA180_TEMP_CHANNEL,
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 static irqreturn_t bma180_trigger_handler(int irq, void *p)
@@ -479,13 +516,14 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 
 	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
 			 indio_dev->masklength) {
-		ret = bma180_get_acc_reg(data, bit);
+		ret = bma180_get_data_reg(data, bit);
 		if (ret < 0) {
 			mutex_unlock(&data->mutex);
 			goto err;
 		}
 		((s16 *)data->buff)[i++] = ret;
 	}
+
 	mutex_unlock(&data->mutex);
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buff, time_ns);
-- 
1.9.1

