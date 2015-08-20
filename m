Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44433 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbbHTMuP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 08:50:15 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 1/4] iio: bmc150: Use i2c regmap
Date: Thu, 20 Aug 2015 14:49:43 +0200
Message-Id: <1440074986-28716-2-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This replaces all usage of direct i2c accesses with regmap accesses.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/accel/Kconfig        |   2 +
 drivers/iio/accel/bmc150-accel.c | 219 +++++++++++++++++----------------------
 2 files changed, 95 insertions(+), 126 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 00e7bcbdbe24..01dd03d194d1 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -22,6 +22,8 @@ config BMC150_ACCEL
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select REGMAP
+	select REGMAP_I2C
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
 	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 55751d9e1ade..c5c773e75173 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -35,6 +35,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/regmap.h>
 
 #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
 #define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
@@ -185,6 +186,8 @@ enum bmc150_accel_trigger_id {
 
 struct bmc150_accel_data {
 	struct i2c_client *client;
+	struct regmap *regmap;
+	struct device *dev;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	atomic_t active_intr;
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
@@ -241,6 +244,11 @@ static const struct {
 				       {500000, BMC150_ACCEL_SLEEP_500_MS},
 				       {1000000, BMC150_ACCEL_SLEEP_1_SEC} };
 
+static const struct regmap_config bmc150_i2c_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x3f,
+};
 
 static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
 				 enum bmc150_power_modes mode,
@@ -270,8 +278,7 @@ static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
 
 	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
 		return ret;
@@ -289,8 +296,7 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
 	for (i = 0; i < ARRAY_SIZE(bmc150_accel_samp_freq_table); ++i) {
 		if (bmc150_accel_samp_freq_table[i].val == val &&
 				bmc150_accel_samp_freq_table[i].val2 == val2) {
-			ret = i2c_smbus_write_byte_data(
-				data->client,
+			ret = regmap_write(data->regmap,
 				BMC150_ACCEL_REG_PMU_BW,
 				bmc150_accel_samp_freq_table[i].bw_bits);
 			if (ret < 0)
@@ -307,26 +313,19 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
 
 static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
 {
-	int ret, val;
+	int ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_6,
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
 					data->slope_thres);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_6\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
+	ret = regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
+				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_5\n");
-		return ret;
-	}
-
-	val = (ret & ~BMC150_ACCEL_SLOPE_DUR_MASK) | data->slope_dur;
-	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
-					val);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error write reg_int_5\n");
+		dev_err(&data->client->dev, "Error updating reg_int_5\n");
 		return ret;
 	}
 
@@ -348,17 +347,18 @@ static int bmc150_accel_any_motion_setup(struct bmc150_accel_trigger *t,
 static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 {
 	int ret;
+	unsigned int val;
 
-	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
+	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Error: Reading chip id\n");
 		return ret;
 	}
 
-	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
-	if (ret != data->chip_info->chip_id) {
-		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
+	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
+	if (val != data->chip_info->chip_id) {
+		dev_err(&data->client->dev, "Invalid chip %x\n", val);
 		return -ENODEV;
 	}
 
@@ -372,9 +372,8 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 		return ret;
 
 	/* Set Default Range */
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_PMU_RANGE,
-					BMC150_ACCEL_DEF_RANGE_4G);
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
+			   BMC150_ACCEL_DEF_RANGE_4G);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 					"Error writing reg_pmu_range\n");
@@ -391,10 +390,9 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 		return ret;
 
 	/* Set default as latched interrupts */
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_INT_RST_LATCH,
-					BMC150_ACCEL_INT_MODE_LATCH_INT |
-					BMC150_ACCEL_INT_MODE_LATCH_RESET);
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
+			   BMC150_ACCEL_INT_MODE_LATCH_INT |
+			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Error writing reg_int_rst_latch\n");
@@ -527,38 +525,18 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 		return ret;
 
 	/* map the interrupt to the appropriate pins */
-	ret = i2c_smbus_read_byte_data(data->client, info->map_reg);
+	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
+				 (state ? info->map_bitmask : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_map\n");
-		goto out_fix_power_state;
-	}
-	if (state)
-		ret |= info->map_bitmask;
-	else
-		ret &= ~info->map_bitmask;
-
-	ret = i2c_smbus_write_byte_data(data->client, info->map_reg,
-					ret);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_map\n");
+		dev_err(&data->client->dev, "Error updating reg_int_map\n");
 		goto out_fix_power_state;
 	}
 
 	/* enable/disable the interrupt */
-	ret = i2c_smbus_read_byte_data(data->client, info->en_reg);
+	ret = regmap_update_bits(data->regmap, info->en_reg, info->en_bitmask,
+				 (state ? info->en_bitmask : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_en\n");
-		goto out_fix_power_state;
-	}
-
-	if (state)
-		ret |= info->en_bitmask;
-	else
-		ret &= ~info->en_bitmask;
-
-	ret = i2c_smbus_write_byte_data(data->client, info->en_reg, ret);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_en\n");
+		dev_err(&data->client->dev, "Error updating reg_int_en\n");
 		goto out_fix_power_state;
 	}
 
@@ -581,8 +559,7 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
 
 	for (i = 0; i < ARRAY_SIZE(data->chip_info->scale_table); ++i) {
 		if (data->chip_info->scale_table[i].scale == val) {
-			ret = i2c_smbus_write_byte_data(
-				     data->client,
+			ret = regmap_write(data->regmap,
 				     BMC150_ACCEL_REG_PMU_RANGE,
 				     data->chip_info->scale_table[i].reg_range);
 			if (ret < 0) {
@@ -602,16 +579,17 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
 static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
 {
 	int ret;
+	unsigned int value;
 
 	mutex_lock(&data->mutex);
 
-	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_TEMP);
+	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_temp\n");
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
-	*val = sign_extend32(ret, 7);
+	*val = sign_extend32(value, 7);
 
 	mutex_unlock(&data->mutex);
 
@@ -624,6 +602,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 {
 	int ret;
 	int axis = chan->scan_index;
+	unsigned int raw_val;
 
 	mutex_lock(&data->mutex);
 	ret = bmc150_accel_set_power_state(data, true);
@@ -632,15 +611,15 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 		return ret;
 	}
 
-	ret = i2c_smbus_read_word_data(data->client,
-				       BMC150_ACCEL_AXIS_TO_REG(axis));
+	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
+			       &raw_val, 2);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
 		bmc150_accel_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
-	*val = sign_extend32(ret >> chan->scan_type.shift,
+	*val = sign_extend32(raw_val >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 	ret = bmc150_accel_set_power_state(data, false);
 	mutex_unlock(&data->mutex);
@@ -904,52 +883,34 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
  * We must read at least one full frame in one burst, otherwise the rest of the
  * frame data is discarded.
  */
-static int bmc150_accel_fifo_transfer(const struct i2c_client *client,
+static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
 				      char *buffer, int samples)
 {
 	int sample_length = 3 * 2;
-	u8 reg_fifo_data = BMC150_ACCEL_REG_FIFO_DATA;
-	int ret = -EIO;
-
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-		struct i2c_msg msg[2] = {
-			{
-				.addr = client->addr,
-				.flags = 0,
-				.buf = &reg_fifo_data,
-				.len = sizeof(reg_fifo_data),
-			},
-			{
-				.addr = client->addr,
-				.flags = I2C_M_RD,
-				.buf = (u8 *)buffer,
-				.len = samples * sample_length,
-			}
-		};
+	int ret;
+	int total_length = samples * sample_length;
+	int i;
+	int step = regmap_get_raw_read_max(data->regmap);
 
-		ret = i2c_transfer(client->adapter, msg, 2);
-		if (ret != 2)
-			ret = -EIO;
-		else
-			ret = 0;
-	} else {
-		int i, step = I2C_SMBUS_BLOCK_MAX / sample_length;
-
-		for (i = 0; i < samples * sample_length; i += step) {
-			ret = i2c_smbus_read_i2c_block_data(client,
-							    reg_fifo_data, step,
-							    &buffer[i]);
-			if (ret != step) {
-				ret = -EIO;
-				break;
-			}
+	if (!step || step > total_length)
+		step = total_length;
+	else if (step < total_length)
+		step = sample_length;
 
-			ret = 0;
-		}
+	/*
+	 * Seems we have a bus with size limitation so we have to execute
+	 * multiple reads
+	 */
+	for (i = 0; i < total_length; i += step) {
+		ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
+				      &buffer[i], step);
+		if (ret)
+			break;
 	}
 
 	if (ret)
-		dev_err(&client->dev, "Error transferring data from fifo\n");
+		dev_err(data->dev, "Error transferring data from fifo in single steps of %zu\n",
+			step);
 
 	return ret;
 }
@@ -963,14 +924,15 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
 	int64_t tstamp;
 	uint64_t sample_period;
-	ret = i2c_smbus_read_byte_data(data->client,
-				       BMC150_ACCEL_REG_FIFO_STATUS);
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
 		return ret;
 	}
 
-	count = ret & 0x7F;
+	count = val & 0x7F;
 
 	if (!count)
 		return 0;
@@ -1009,7 +971,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 	if (samples && count > samples)
 		count = samples;
 
-	ret = bmc150_accel_fifo_transfer(data->client, (u8 *)buffer, count);
+	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
 	if (ret)
 		return ret;
 
@@ -1206,17 +1168,19 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int bit, ret, i = 0;
+	unsigned int raw_val;
 
 	mutex_lock(&data->mutex);
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
-		ret = i2c_smbus_read_word_data(data->client,
-					       BMC150_ACCEL_AXIS_TO_REG(bit));
+		ret = regmap_bulk_read(data->regmap,
+				       BMC150_ACCEL_AXIS_TO_REG(bit), &raw_val,
+				       2);
 		if (ret < 0) {
 			mutex_unlock(&data->mutex);
 			goto err_read;
 		}
-		data->buffer[i++] = ret;
+		data->buffer[i++] = raw_val;
 	}
 	mutex_unlock(&data->mutex);
 
@@ -1240,10 +1204,9 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
 
 	mutex_lock(&data->mutex);
 	/* clear any latched interrupt */
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_INT_RST_LATCH,
-					BMC150_ACCEL_INT_MODE_LATCH_INT |
-					BMC150_ACCEL_INT_MODE_LATCH_RESET);
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
+			   BMC150_ACCEL_INT_MODE_LATCH_INT |
+			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 	mutex_unlock(&data->mutex);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
@@ -1300,34 +1263,34 @@ static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int dir;
 	int ret;
+	unsigned int val;
 
-	ret = i2c_smbus_read_byte_data(data->client,
-				       BMC150_ACCEL_REG_INT_STATUS_2);
+	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
 		return ret;
 	}
 
-	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
+	if (val & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
 		dir = IIO_EV_DIR_FALLING;
 	else
 		dir = IIO_EV_DIR_RISING;
 
-	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_X)
+	if (val & BMC150_ACCEL_ANY_MOTION_BIT_X)
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
 							0,
 							IIO_MOD_X,
 							IIO_EV_TYPE_ROC,
 							dir),
 							data->timestamp);
-	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Y)
+	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Y)
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
 							0,
 							IIO_MOD_Y,
 							IIO_EV_TYPE_ROC,
 							dir),
 							data->timestamp);
-	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Z)
+	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Z)
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
 							0,
 							IIO_MOD_Z,
@@ -1360,10 +1323,9 @@ static irqreturn_t bmc150_accel_irq_thread_handler(int irq, void *private)
 	}
 
 	if (ack) {
-		ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_INT_RST_LATCH,
-					BMC150_ACCEL_INT_MODE_LATCH_INT |
-					BMC150_ACCEL_INT_MODE_LATCH_RESET);
+		ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
+				   BMC150_ACCEL_INT_MODE_LATCH_INT |
+				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 		if (ret)
 			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
 		ret = IRQ_HANDLED;
@@ -1516,7 +1478,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
 	u8 reg = BMC150_ACCEL_REG_FIFO_CONFIG1;
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, reg, data->fifo_mode);
+	ret = regmap_write(data->regmap, reg, data->fifo_mode);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
 		return ret;
@@ -1525,9 +1487,8 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
 	if (!data->fifo_mode)
 		return 0;
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMC150_ACCEL_REG_FIFO_CONFIG0,
-					data->watermark);
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
+			   data->watermark);
 	if (ret < 0)
 		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
 
@@ -1627,6 +1588,13 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->dev = &client->dev;
+
+	data->regmap = devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
+		return PTR_ERR(data->regmap);
+	}
 
 	if (id) {
 		name = id->name;
@@ -1680,9 +1648,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		 * want to use latch mode when we can to prevent interrupt
 		 * flooding.
 		 */
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMC150_ACCEL_REG_INT_RST_LATCH,
-					     BMC150_ACCEL_INT_MODE_LATCH_RESET);
+		ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
+				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
 			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
 			goto err_buffer_cleanup;
-- 
2.4.6

