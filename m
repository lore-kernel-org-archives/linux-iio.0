Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20348 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757088AbbCCQVW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Mar 2015 11:21:22 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v4 3/3] iio: bmc150_accel: add support for hardware fifo
Date: Tue,  3 Mar 2015 18:21:02 +0200
Message-Id: <1425399662-5539-4-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com>
References: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We only advertise hardware fifo support if the I2C bus supports full
I2C or smbus I2C block data reads since it is mandatory to read the
full frame in one read (otherwise the rest of the frame is discarded).

The hardware fifo is enabled only when triggers are not active because:

(a) when using the any-motion trigger the user expects to see samples
based on ROC events, but the fifo stores samples based on the sample
frequency

(b) the data-ready trigger is waking the CPU for for every sample, so
using the hardware fifo does not have any benefit

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 353 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 339 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index d826394..a1e5767 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -70,7 +70,9 @@
 #define BMC150_ACCEL_INT_MAP_0_BIT_SLOPE	BIT(2)
 
 #define BMC150_ACCEL_REG_INT_MAP_1		0x1A
-#define BMC150_ACCEL_INT_MAP_1_BIT_DATA	BIT(0)
+#define BMC150_ACCEL_INT_MAP_1_BIT_DATA		BIT(0)
+#define BMC150_ACCEL_INT_MAP_1_BIT_FWM		BIT(1)
+#define BMC150_ACCEL_INT_MAP_1_BIT_FFULL	BIT(2)
 
 #define BMC150_ACCEL_REG_INT_RST_LATCH		0x21
 #define BMC150_ACCEL_INT_MODE_LATCH_RESET	0x80
@@ -83,7 +85,9 @@
 #define BMC150_ACCEL_INT_EN_BIT_SLP_Z		BIT(2)
 
 #define BMC150_ACCEL_REG_INT_EN_1		0x17
-#define BMC150_ACCEL_INT_EN_BIT_DATA_EN	BIT(4)
+#define BMC150_ACCEL_INT_EN_BIT_DATA_EN		BIT(4)
+#define BMC150_ACCEL_INT_EN_BIT_FFULL_EN	BIT(5)
+#define BMC150_ACCEL_INT_EN_BIT_FWM_EN		BIT(6)
 
 #define BMC150_ACCEL_REG_INT_OUT_CTRL		0x20
 #define BMC150_ACCEL_INT_OUT_CTRL_INT1_LVL	BIT(0)
@@ -122,6 +126,12 @@
 #define BMC150_ACCEL_AXIS_TO_REG(axis)	(BMC150_ACCEL_REG_XOUT_L + (axis * 2))
 #define BMC150_AUTO_SUSPEND_DELAY_MS		2000
 
+#define BMC150_ACCEL_REG_FIFO_STATUS		0x0E
+#define BMC150_ACCEL_REG_FIFO_CONFIG0		0x30
+#define BMC150_ACCEL_REG_FIFO_CONFIG1		0x3E
+#define BMC150_ACCEL_REG_FIFO_DATA		0x3F
+#define BMC150_ACCEL_FIFO_LENGTH		32
+
 enum bmc150_accel_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -179,13 +189,14 @@ struct bmc150_accel_data {
 	atomic_t active_intr;
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
+	u8 fifo_mode, watermark;
 	s16 buffer[8];
 	u8 bw_bits;
 	u32 slope_dur;
 	u32 slope_thres;
 	u32 range;
 	int ev_enable_state;
-	int64_t timestamp;
+	int64_t timestamp, old_timestamp;
 	const struct bmc150_accel_chip_info *chip_info;
 };
 
@@ -470,6 +481,12 @@ static const struct bmc150_accel_interrupt_info {
 			BMC150_ACCEL_INT_EN_BIT_SLP_Y |
 			BMC150_ACCEL_INT_EN_BIT_SLP_Z
 	},
+	{ /* fifo watermark interrupt */
+		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
+		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_FWM,
+		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
+		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_FWM_EN,
+	},
 };
 
 static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
@@ -823,6 +840,183 @@ static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
+
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+
+	if (val > BMC150_ACCEL_FIFO_LENGTH)
+		val = BMC150_ACCEL_FIFO_LENGTH * 3 / 4;
+
+	mutex_lock(&data->mutex);
+	data->watermark = val;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static int bmc150_accel_get_watermark(struct iio_dev *indio_dev)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	if (!data->fifo_mode)
+		ret = 0;
+	else
+		ret = data->watermark;
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+/*
+ * We must read at least one full frame in one burst, otherwise the rest of the
+ * frame data is discarded.
+ */
+static int bmc150_accel_fifo_transfer(const struct i2c_client *client,
+				      char *buffer, int samples)
+{
+	int sample_length = 3 * 2;
+	u8 reg_fifo_data = BMC150_ACCEL_REG_FIFO_DATA;
+	int ret = -EIO;
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		struct i2c_msg msg[2] = {
+			{
+				.addr = client->addr,
+				.flags = 0,
+				.buf = &reg_fifo_data,
+				.len = sizeof(reg_fifo_data),
+			},
+			{
+				.addr = client->addr,
+				.flags = I2C_M_RD,
+				.buf = (u8 *)buffer,
+				.len = samples * sample_length,
+			}
+		};
+
+		ret = i2c_transfer(client->adapter, msg, 2);
+		if (ret != 2)
+			ret = -EIO;
+		else
+			ret = 0;
+	} else {
+		int i, step = I2C_SMBUS_BLOCK_MAX / sample_length;
+
+		for (i = 0; i < samples * sample_length; i += step) {
+			ret = i2c_smbus_read_i2c_block_data(client,
+							    reg_fifo_data, step,
+							    &buffer[i]);
+			if (ret != step) {
+				ret = -EIO;
+				break;
+			}
+
+			ret = 0;
+		}
+	}
+
+	if (ret)
+		dev_err(&client->dev, "Error transferring data from fifo\n");
+
+	return ret;
+}
+
+static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
+				     unsigned samples, bool irq)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int ret, i;
+	u8 count;
+	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
+	int64_t tstamp, sample_period;
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       BMC150_ACCEL_REG_FIFO_STATUS);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
+		return ret;
+	}
+
+	count = ret & 0x7F;
+
+	if (!count)
+		return 0;
+
+	/*
+	 * If we getting called from IRQ handler we know the stored timestamp is
+	 * fairly accurate for the last stored sample. Otherwise, if we are
+	 * called as a result of a read operation from userspace and hence
+	 * before the watermark interrupt was triggered, take a timestamp
+	 * now. We can fall anywhere in between two samples so the error in this
+	 * case is +/- one sample period.
+	 */
+	if (!irq) {
+		data->old_timestamp = data->timestamp;
+		data->timestamp = iio_get_time_ns();
+	}
+
+	/*
+	 * Approximate timestamps for each of the sample based on the sampling
+	 * frequency, timestamp for last sample and number of samples.
+	 *
+	 * Note that we can't use the current bandwidth settings to compute the
+	 * sample period because the sample rate varies with the device
+	 * (e.g. between 31.70ms to 32.20ms for a bandwidth of 15.63HZ). That
+	 * small variation adds when we store a large number of samples and
+	 * creates significant jitter between the last and first samples in
+	 * different batches (e.g. 32ms vs 21ms).
+	 *
+	 * To avoid this issue we compute the actual sample period ourselves
+	 * based on the timestamp delta between the last two flush operations.
+	 */
+	sample_period = (data->timestamp - data->old_timestamp) / count;
+	tstamp = data->timestamp - (count - 1) * sample_period;
+
+	if (samples && count > samples)
+		count = samples;
+
+	ret = bmc150_accel_fifo_transfer(data->client, (u8 *)buffer, count);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ideally we want the IIO core to handle the demux when running in fifo
+	 * mode but not when running in triggerde buffer mode. Unfortunately
+	 * this does not seem to be possible, so stick with driver demux for
+	 * now.
+	 */
+	for (i = 0; i < count; i++) {
+		u16 sample[8];
+		int j, bit;
+
+		j = 0;
+		for_each_set_bit(bit, indio_dev->active_scan_mask,
+				 indio_dev->masklength)
+			memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
+
+		iio_push_to_buffers_with_timestamp(indio_dev, sample, tstamp);
+
+		tstamp += sample_period;
+	}
+
+	return count;
+}
+
+static int bmc150_accel_fifo_flush(struct iio_dev *indio_dev, unsigned samples)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = __bmc150_accel_fifo_flush(indio_dev, samples, false);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 		"15.620000 31.260000 62.50000 125 250 500 1000 2000");
 
@@ -950,7 +1144,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 	},
 };
 
-static const struct iio_info bmc150_accel_info = {
+static struct iio_info bmc150_accel_info = {
 	.attrs			= &bmc150_accel_attrs_group,
 	.read_raw		= bmc150_accel_read_raw,
 	.write_raw		= bmc150_accel_write_raw,
@@ -959,6 +1153,9 @@ static const struct iio_info bmc150_accel_info = {
 	.write_event_config	= bmc150_accel_write_event_config,
 	.read_event_config	= bmc150_accel_read_event_config,
 	.validate_trigger	= bmc150_accel_validate_trigger,
+	.hwfifo_set_watermark	= bmc150_accel_set_watermark,
+	.hwfifo_get_watermark	= bmc150_accel_get_watermark,
+	.hwfifo_flush		= bmc150_accel_fifo_flush,
 	.driver_module		= THIS_MODULE,
 };
 
@@ -1057,18 +1254,17 @@ static const struct iio_trigger_ops bmc150_accel_trigger_ops = {
 	.owner = THIS_MODULE,
 };
 
-static irqreturn_t bmc150_accel_event_handler(int irq, void *private)
+static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = private;
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int ret;
 	int dir;
+	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client,
 				       BMC150_ACCEL_REG_INT_STATUS_2);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
-		goto ack_intr_status;
+		return ret;
 	}
 
 	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
@@ -1097,35 +1293,73 @@ static irqreturn_t bmc150_accel_event_handler(int irq, void *private)
 							IIO_EV_TYPE_ROC,
 							dir),
 							data->timestamp);
-ack_intr_status:
-	if (!data->triggers[BMC150_ACCEL_TRIGGER_DATA_READY].enabled)
+	return ret;
+}
+
+static irqreturn_t bmc150_accel_event_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	bool ack = false;
+	int ret;
+
+	mutex_lock(&data->mutex);
+
+	if (data->fifo_mode) {
+		ret = __bmc150_accel_fifo_flush(indio_dev,
+						BMC150_ACCEL_FIFO_LENGTH, true);
+		if (ret > 0)
+			ack = true;
+	}
+
+	if (data->ev_enable_state) {
+		ret = bmc150_accel_handle_roc_event(indio_dev);
+		if (ret > 0)
+			ack = true;
+	}
+
+	if (ack) {
 		ret = i2c_smbus_write_byte_data(data->client,
 					BMC150_ACCEL_REG_INT_RST_LATCH,
 					BMC150_ACCEL_INT_MODE_LATCH_INT |
 					BMC150_ACCEL_INT_MODE_LATCH_RESET);
+		if (ret)
+			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
+		ret = IRQ_HANDLED;
+	} else {
+		ret = IRQ_NONE;
+	}
 
-	return IRQ_HANDLED;
+	mutex_unlock(&data->mutex);
+
+	return ret;
 }
 
 static irqreturn_t bmc150_accel_data_rdy_trig_poll(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	bool ack = false;
 	int i;
 
+	data->old_timestamp = data->timestamp;
 	data->timestamp = iio_get_time_ns();
 
 	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
 		if (data->triggers[i].enabled) {
 			iio_trigger_poll(data->triggers[i].indio_trig);
+			ack = true;
 			break;
 		}
 	}
 
-	if (data->ev_enable_state)
+	if (data->ev_enable_state || data->fifo_mode)
 		return IRQ_WAKE_THREAD;
-	else
+
+	if (ack)
 		return IRQ_HANDLED;
+
+	return IRQ_NONE;
 }
 
 static const char *bmc150_accel_match_acpi_device(struct device *dev, int *data)
@@ -1232,6 +1466,84 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
 	return ret;
 }
 
+#define BMC150_ACCEL_FIFO_MODE_STREAM          0x80
+#define BMC150_ACCEL_FIFO_MODE_FIFO            0x40
+#define BMC150_ACCEL_FIFO_MODE_BYPASS          0x00
+
+static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
+{
+	u8 reg = BMC150_ACCEL_REG_FIFO_CONFIG1;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, reg, data->fifo_mode);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
+		return ret;
+	}
+
+	if (!data->fifo_mode)
+		return 0;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					BMC150_ACCEL_REG_FIFO_CONFIG0,
+					data->watermark);
+	if (ret < 0)
+		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
+
+	return ret;
+}
+
+static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		return iio_triggered_buffer_postenable(indio_dev);
+
+	if (!data->watermark)
+		return 0;
+
+	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
+					 true);
+	if (ret)
+		return ret;
+
+	data->fifo_mode = BMC150_ACCEL_FIFO_MODE_FIFO;
+
+	ret = bmc150_accel_fifo_set_mode(data);
+	if (ret) {
+		data->fifo_mode = 0;
+		bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
+					   false);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		return iio_triggered_buffer_predisable(indio_dev);
+
+	if (!data->fifo_mode)
+		return 0;
+
+	data->fifo_mode = 0;
+	bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK, false);
+	bmc150_accel_fifo_set_mode(data);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
+	.postenable = bmc150_accel_buffer_postenable,
+	.predisable = bmc150_accel_buffer_predisable,
+};
+
 static int bmc150_accel_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -1270,6 +1582,15 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
+	    i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+	} else {
+		bmc150_accel_info.hwfifo_set_watermark = NULL;
+		bmc150_accel_info.hwfifo_get_watermark = NULL;
+		bmc150_accel_info.hwfifo_flush = NULL;
+	}
 	indio_dev->info = &bmc150_accel_info;
 
 	if (client->irq < 0)
@@ -1309,7 +1630,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		ret = iio_triggered_buffer_setup(indio_dev,
 						 &iio_pollfunc_store_time,
 						 bmc150_accel_trigger_handler,
-						 NULL);
+						 &bmc150_accel_buffer_ops);
 		if (ret < 0) {
 			dev_err(&client->dev,
 				"Failed: iio triggered buffer setup\n");
@@ -1386,6 +1707,7 @@ static int bmc150_accel_resume(struct device *dev)
 	mutex_lock(&data->mutex);
 	if (atomic_read(&data->active_intr))
 		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
+	bmc150_accel_fifo_set_mode(data);
 	mutex_unlock(&data->mutex);
 
 	return 0;
@@ -1419,6 +1741,9 @@ static int bmc150_accel_runtime_resume(struct device *dev)
 	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
 	if (ret < 0)
 		return ret;
+	ret = bmc150_accel_fifo_set_mode(data);
+	if (ret < 0)
+		return ret;
 
 	sleep_val = bmc150_accel_get_startup_times(data);
 	if (sleep_val < 20)
-- 
1.9.1

