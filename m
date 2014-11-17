Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54577 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbaKQSGV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Nov 2014 13:06:21 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC 8/8] iio: bmc150: add support for hardware fifo
Date: Mon, 17 Nov 2014 19:56:06 +0200
Message-Id: <1416246966-3083-9-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for hardware fifo. Fifo and stream mode are
supported as well as fifo-full and fifo-watermark events.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 249 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 72d2dca..404cfec 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -67,7 +67,9 @@
 #define BMC150_ACCEL_INT_MAP_0_BIT_SLOPE	BIT(2)
 
 #define BMC150_ACCEL_REG_INT_MAP_1		0x1A
-#define BMC150_ACCEL_INT_MAP_1_BIT_DATA	BIT(0)
+#define BMC150_ACCEL_INT_MAP_1_BIT_DATA		BIT(0)
+#define BMC150_ACCEL_INT_MAP_1_BIT_FWM		BIT(1)
+#define BMC150_ACCEL_INT_MAP_1_BIT_FFULL	BIT(2)
 
 #define BMC150_ACCEL_REG_INT_RST_LATCH		0x21
 #define BMC150_ACCEL_INT_MODE_LATCH_RESET	0x80
@@ -80,7 +82,9 @@
 #define BMC150_ACCEL_INT_EN_BIT_SLP_Z		BIT(2)
 
 #define BMC150_ACCEL_REG_INT_EN_1		0x17
-#define BMC150_ACCEL_INT_EN_BIT_DATA_EN	BIT(4)
+#define BMC150_ACCEL_INT_EN_BIT_DATA_EN		BIT(4)
+#define BMC150_ACCEL_INT_EN_BIT_FFULL_EN	BIT(5)
+#define BMC150_ACCEL_INT_EN_BIT_FWM_EN		BIT(6)
 
 #define BMC150_ACCEL_REG_INT_OUT_CTRL		0x20
 #define BMC150_ACCEL_INT_OUT_CTRL_INT1_LVL	BIT(0)
@@ -119,6 +123,13 @@
 #define BMC150_ACCEL_AXIS_TO_REG(axis)	(BMC150_ACCEL_REG_XOUT_L + (axis * 2))
 #define BMC150_AUTO_SUSPEND_DELAY_MS		2000
 
+#define BMC150_ACCEL_REG_FIFO_STATUS		0x0E
+#define BMC150_ACCEL_REG_FIFO_CONFIG0		0x30
+#define BMC150_ACCEL_REG_FIFO_CONFIG1		0x3E
+#define BMC150_ACCEL_REG_FIFO_DATA		0x3F
+#define BMC150_ACCEL_REG_FIFO_
+#define BMC150_ACCEL_FIFO_LENGTH		32
+
 enum bmc150_accel_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -177,12 +188,13 @@ struct bmc150_accel_event {
 			u32 duration;
 			u32 threshold;
 		} slope;
+		u8 watermark;
 	};
 };
 
-#define BMC150_ACCEL_INTERRUPTS		2
+#define BMC150_ACCEL_INTERRUPTS		4
 #define BMC150_ACCEL_TRIGGERS		2
-#define BMC150_ACCEL_EVENTS		1
+#define BMC150_ACCEL_EVENTS		3
 
 struct bmc150_accel_data {
 	struct i2c_client *client;
@@ -191,6 +203,7 @@ struct bmc150_accel_data {
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct bmc150_accel_event events[BMC150_ACCEL_EVENTS];
 	struct mutex mutex;
+	int fifo_mode;
 	s16 buffer[8];
 	u8 bw_bits;
 	u32 range;
@@ -483,6 +496,18 @@ bmc150_accel_interrupts[BMC150_ACCEL_INTERRUPTS] = {
 			BMC150_ACCEL_INT_EN_BIT_SLP_Y |
 			BMC150_ACCEL_INT_EN_BIT_SLP_Z
 	},
+	{ /* fifo full interrupt */
+		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_FFULL,
+		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
+		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_FFULL_EN,
+	},
+	{ /* fifo watermark interrupt */
+		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_FWM,
+		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
+		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_FWM_EN,
+	},
 };
 
 static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
@@ -699,11 +724,85 @@ static int bmc150_accel_read_raw(struct iio_dev *indio_dev,
 		ret = bmc150_accel_get_bw(data, val, val2);
 		mutex_unlock(&data->mutex);
 		return ret;
+	case IIO_CHAN_INFO_FIFO_LENGTH:
+		*val2 = 0;
+		*val = BMC150_ACCEL_FIFO_LENGTH;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
 }
 
+static int bmc150_accel_fifo_flush(struct iio_dev *indio_dev)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int ret, i;
+	u8 count;
+	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
+	u8 reg_fifo_data = BMC150_ACCEL_REG_FIFO_DATA;
+	struct i2c_msg msg[2];
+	int64_t tstamp;
+	int sample_freq = 0, sec, ms;
+
+	ret = bmc150_accel_get_bw(data, &sec, &ms);
+	if (ret == 0)
+		sample_freq = sec * 1000000000 + ms * 1000;
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       BMC150_ACCEL_REG_FIFO_STATUS);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Error reading reg_fifo_status\n");
+		return ret;
+	}
+
+	count = ret & 0x7F;
+
+	i = i2c_smbus_read_byte_data(data->client,
+				     BMC150_ACCEL_REG_FIFO_CONFIG1);
+	if (!count)
+		return 0;
+
+	msg[0].addr = data->client->addr;
+	msg[0].flags = 0;
+	msg[0].buf = &reg_fifo_data;
+	msg[0].len = sizeof(reg_fifo_data);
+
+	msg[1].addr = data->client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].buf = (u8 *)buffer;
+	msg[1].len = count * 3 * 2;
+
+	ret = i2c_transfer(data->client->adapter, msg, 2);
+	if (ret != 2) {
+		dev_err(&indio_dev->dev, "Error reading reg_fifo_data\n");
+		return ret;
+	}
+
+	if (!data->timestamp)
+		data->timestamp = iio_get_time_ns();
+
+	tstamp = data->timestamp - count * sample_freq;
+
+	for (i = 0; i < count; i++) {
+		u16 sample[8];
+		int j, bit;
+
+		j = 0;
+		for_each_set_bit(bit, indio_dev->buffer->scan_mask,
+				 indio_dev->masklength) {
+			memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
+		}
+
+		iio_push_to_buffers_with_timestamp(indio_dev, sample, tstamp);
+
+		tstamp += sample_freq;
+	}
+
+	data->timestamp = 0;
+
+	return 0;
+}
+
 static int bmc150_accel_write_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan,
 				  int val, int val2, long mask)
@@ -725,6 +824,8 @@ static int bmc150_accel_write_raw(struct iio_dev *indio_dev,
 		ret = bmc150_accel_set_scale(data, val2);
 		mutex_unlock(&data->mutex);
 		return ret;
+	case IIO_CHAN_INFO_FIFO_FLUSH:
+		return bmc150_accel_fifo_flush(indio_dev);
 	default:
 		ret = -EINVAL;
 	}
@@ -764,6 +865,22 @@ static int bmc150_accel_event_roc_read(struct bmc150_accel_event *event,
 	return IIO_VAL_INT;
 }
 
+static int bmc150_accel_event_watermark_read(struct bmc150_accel_event *event,
+					     enum iio_event_info info,
+					     int *val, int *val2)
+{
+	*val2 = 0;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val = event->watermark;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
 static int bmc150_accel_read_event(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan,
 				   enum iio_event_type type,
@@ -807,6 +924,38 @@ static int bmc150_accel_event_roc_write(struct bmc150_accel_event *event,
 	return ret;
 }
 
+static int bmc150_accel_event_watermark_write(struct bmc150_accel_event *event,
+					      enum iio_event_info info,
+					      int val, int val2)
+{
+	struct bmc150_accel_data *data = event->data;
+	int ret;
+
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val > BMC150_ACCEL_FIFO_LENGTH) {
+			ret = -EINVAL;
+			break;
+		}
+		mutex_lock(&data->mutex);
+		ret = i2c_smbus_write_byte_data(data->client,
+						BMC150_ACCEL_REG_FIFO_CONFIG0,
+						val);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
+			break;
+		}
+		event->watermark = val;
+		mutex_unlock(&data->mutex);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int bmc150_accel_write_event(struct iio_dev *indio_dev,
 				    const struct iio_chan_spec *chan,
 				    enum iio_event_type type,
@@ -900,6 +1049,76 @@ static const struct iio_event_spec bmc150_accel_events[BMC150_ACCEL_EVENTS] = {
 				 BIT(IIO_EV_INFO_ENABLE) |
 				 BIT(IIO_EV_INFO_PERIOD)
 	},
+	{
+		.type = IIO_EV_TYPE_FIFO_FULL,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE)
+	},
+	{
+		.type = IIO_EV_TYPE_FIFO_WATERMARK,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE)
+	},
+};
+
+
+static const char * const bmc150_accel_fifo_modes[] = {
+	"disabled",
+	"fifo",
+	"stream"
+};
+
+static int bmc150_accel_fifo_mode_set(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      unsigned int mode)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 val;
+
+	switch (mode) {
+	case 0:
+		val = 0;
+		break;
+	case 1:
+		val = 0x40;
+		break;
+	case 2:
+		val = 0x80;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					BMC150_ACCEL_REG_FIFO_CONFIG1, val);
+	if (ret < 0)
+		dev_err(&indio_dev->dev, "Error writing reg_fifo_config1\n");
+
+	data->fifo_mode  = mode;
+
+	return ret;
+}
+
+static int bmc150_accel_fifo_mode_get(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+
+	return data->fifo_mode;
+}
+
+static const struct iio_enum bmc150_accel_fifo_mode_enum = {
+	.items = bmc150_accel_fifo_modes,
+	.num_items = ARRAY_SIZE(bmc150_accel_fifo_modes),
+	.set = bmc150_accel_fifo_mode_set,
+	.get = bmc150_accel_fifo_mode_get,
+};
+
+static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
+	IIO_FIFO_EXT_INFO(&bmc150_accel_fifo_mode_enum, IIO_SHARED_BY_TYPE),
+	{},
 };
 
 #define BMC150_ACCEL_CHANNEL(_axis, bits) {				\
@@ -908,7 +1127,9 @@ static const struct iio_event_spec bmc150_accel_events[BMC150_ACCEL_EVENTS] = {
 	.channel2 = IIO_MOD_##_axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+				BIT(IIO_CHAN_INFO_FIFO_LENGTH) |	\
+				BIT(IIO_CHAN_INFO_FIFO_FLUSH),		\
 	.scan_index = AXIS_##_axis,					\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -917,7 +1138,8 @@ static const struct iio_event_spec bmc150_accel_events[BMC150_ACCEL_EVENTS] = {
 		.shift = 16 - (bits),					\
 	},								\
 	.event_spec = bmc150_accel_events,				\
-	.num_event_specs = ARRAY_SIZE(bmc150_accel_events)		\
+	.num_event_specs = ARRAY_SIZE(bmc150_accel_events),		\
+	.ext_info = bmc150_accel_ext_info,				\
 }
 
 #define BMC150_ACCEL_CHANNELS(bits) {					\
@@ -1286,6 +1508,17 @@ static struct {
 		.read = bmc150_accel_event_roc_read,
 		.write = bmc150_accel_event_roc_write,
 	},
+	{
+		.intr = 2,
+		.type = IIO_EV_TYPE_FIFO_FULL,
+	},
+	{
+		.intr = 3,
+		.type = IIO_EV_TYPE_FIFO_WATERMARK,
+		.read = bmc150_accel_event_watermark_read,
+		.write = bmc150_accel_event_watermark_write,
+	},
+
 };
 
 static void bmc150_accel_events_setup(struct iio_dev *indio_dev,
@@ -1460,6 +1693,7 @@ static int bmc150_accel_resume(struct device *dev)
 	mutex_lock(&data->mutex);
 	if (atomic_read(&data->active_intr))
 		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
+	bmc150_accel_fifo_mode_set(indio_dev, NULL, data->fifo_mode);
 	mutex_unlock(&data->mutex);
 
 	return 0;
@@ -1489,6 +1723,9 @@ static int bmc150_accel_runtime_resume(struct device *dev)
 	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
 	if (ret < 0)
 		return ret;
+	ret = bmc150_accel_fifo_mode_set(indio_dev, NULL, data->fifo_mode);
+	if (ret < 0)
+		return ret;
 
 	sleep_val = bmc150_accel_get_startup_times(data);
 	if (sleep_val < 20)
-- 
1.9.1

