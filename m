Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59949 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644AbbHDLDP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 07:03:15 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 1/6] iio: bmg160: Use i2c regmap instead of direct i2c access
Date: Tue,  4 Aug 2015 13:02:54 +0200
Message-Id: <1438686179-18635-2-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
References: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch introduces regmap usage into the driver. This is done to
later easily support the SPI interface of this chip.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/gyro/Kconfig  |   2 +
 drivers/iio/gyro/bmg160.c | 200 +++++++++++++++++++++-------------------------
 2 files changed, 91 insertions(+), 111 deletions(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 8d2439345673..b44984b3bb24 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -55,6 +55,8 @@ config BMG160
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select REGMAP
+	select REGMAP_I2C
 	help
 	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
 	  driver. This driver also supports BMI055 gyroscope.
diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 460bf715d541..626f5c98dde8 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -28,6 +28,7 @@
 #include <linux/iio/events.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/regmap.h>
 
 #define BMG160_DRV_NAME		"bmg160"
 #define BMG160_IRQ_NAME		"bmg160_event"
@@ -98,6 +99,7 @@
 
 struct bmg160_data {
 	struct i2c_client *client;
+	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
 	struct mutex mutex;
@@ -134,12 +136,19 @@ static const struct {
 			   { 133, BMG160_RANGE_250DPS},
 			   { 66, BMG160_RANGE_125DPS} };
 
+struct regmap_config bmg160_regmap_i2c_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.use_single_rw = true,
+	.cache_type = REGCACHE_NONE,
+};
+
 static int bmg160_set_mode(struct bmg160_data *data, u8 mode)
 {
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_PMU_LPW, mode);
+	ret = regmap_write(data->regmap, BMG160_REG_PMU_LPW, mode);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
 		return ret;
@@ -169,8 +178,7 @@ static int bmg160_set_bw(struct bmg160_data *data, int val)
 	if (bw_bits < 0)
 		return bw_bits;
 
-	ret = i2c_smbus_write_byte_data(data->client, BMG160_REG_PMU_BW,
-					bw_bits);
+	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW, bw_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_pmu_bw\n");
 		return ret;
@@ -184,16 +192,17 @@ static int bmg160_set_bw(struct bmg160_data *data, int val)
 static int bmg160_chip_init(struct bmg160_data *data)
 {
 	int ret;
+	unsigned int val;
 
-	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_CHIP_ID);
+	ret = regmap_read(data->regmap, BMG160_REG_CHIP_ID, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_chip_id\n");
 		return ret;
 	}
 
-	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
-	if (ret != BMG160_CHIP_ID_VAL) {
-		dev_err(&data->client->dev, "invalid chip %x\n", ret);
+	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
+	if (val != BMG160_CHIP_ID_VAL) {
+		dev_err(&data->client->dev, "invalid chip %x\n", val);
 		return -ENODEV;
 	}
 
@@ -210,40 +219,31 @@ static int bmg160_chip_init(struct bmg160_data *data)
 		return ret;
 
 	/* Set Default Range */
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_RANGE,
-					BMG160_RANGE_500DPS);
+	ret = regmap_write(data->regmap, BMG160_REG_RANGE, BMG160_RANGE_500DPS);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_range\n");
 		return ret;
 	}
 	data->dps_range = BMG160_RANGE_500DPS;
 
-	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_SLOPE_THRES);
+	ret = regmap_read(data->regmap, BMG160_REG_SLOPE_THRES, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_slope_thres\n");
 		return ret;
 	}
-	data->slope_thres = ret;
+	data->slope_thres = val;
 
 	/* Set default interrupt mode */
-	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_EN_1);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_en_1\n");
-		return ret;
-	}
-	ret &= ~BMG160_INT1_BIT_OD;
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_INT_EN_1, ret);
+	ret = regmap_update_bits(data->regmap, BMG160_REG_INT_EN_1,
+				 BMG160_INT1_BIT_OD, 0);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_en_1\n");
+		dev_err(&data->client->dev, "Error updating bits in reg_int_en_1\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_INT_RST_LATCH,
-					BMG160_INT_MODE_LATCH_INT |
-					BMG160_INT_MODE_LATCH_RESET);
+	ret = regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
+			   BMG160_INT_MODE_LATCH_INT |
+			   BMG160_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Error writing reg_motion_intr\n");
@@ -284,41 +284,28 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 	int ret;
 
 	/* Enable/Disable INT_MAP0 mapping */
-	ret = i2c_smbus_read_byte_data(data->client,  BMG160_REG_INT_MAP_0);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_map0\n");
-		return ret;
-	}
-	if (status)
-		ret |= BMG160_INT_MAP_0_BIT_ANY;
-	else
-		ret &= ~BMG160_INT_MAP_0_BIT_ANY;
-
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_INT_MAP_0,
-					ret);
+	ret = regmap_update_bits(data->regmap, BMG160_REG_INT_MAP_0,
+				 BMG160_INT_MAP_0_BIT_ANY,
+				 (status ? BMG160_INT_MAP_0_BIT_ANY : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_map0\n");
+		dev_err(&data->client->dev, "Error updating bits reg_int_map0\n");
 		return ret;
 	}
 
 	/* Enable/Disable slope interrupts */
 	if (status) {
 		/* Update slope thres */
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_SLOPE_THRES,
-						data->slope_thres);
+		ret = regmap_write(data->regmap, BMG160_REG_SLOPE_THRES,
+				   data->slope_thres);
 		if (ret < 0) {
 			dev_err(&data->client->dev,
 				"Error writing reg_slope_thres\n");
 			return ret;
 		}
 
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_MOTION_INTR,
-						BMG160_INT_MOTION_X |
-						BMG160_INT_MOTION_Y |
-						BMG160_INT_MOTION_Z);
+		ret = regmap_write(data->regmap, BMG160_REG_MOTION_INTR,
+				   BMG160_INT_MOTION_X | BMG160_INT_MOTION_Y |
+				   BMG160_INT_MOTION_Z);
 		if (ret < 0) {
 			dev_err(&data->client->dev,
 				"Error writing reg_motion_intr\n");
@@ -331,10 +318,10 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 		 * to set latched mode, we will be flooded anyway with INTR
 		 */
 		if (!data->dready_trigger_on) {
-			ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_INT_RST_LATCH,
-						BMG160_INT_MODE_LATCH_INT |
-						BMG160_INT_MODE_LATCH_RESET);
+			ret = regmap_write(data->regmap,
+					   BMG160_REG_INT_RST_LATCH,
+					   BMG160_INT_MODE_LATCH_INT |
+					   BMG160_INT_MODE_LATCH_RESET);
 			if (ret < 0) {
 				dev_err(&data->client->dev,
 					"Error writing reg_rst_latch\n");
@@ -342,14 +329,12 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 			}
 		}
 
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_INT_EN_0,
-						BMG160_DATA_ENABLE_INT);
+		ret = regmap_write(data->regmap, BMG160_REG_INT_EN_0,
+				   BMG160_DATA_ENABLE_INT);
 
-	} else
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_INT_EN_0,
-						0);
+	} else {
+		ret = regmap_write(data->regmap, BMG160_REG_INT_EN_0, 0);
+	}
 
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_en0\n");
@@ -365,55 +350,39 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 	int ret;
 
 	/* Enable/Disable INT_MAP1 mapping */
-	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_MAP_1);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_map1\n");
-		return ret;
-	}
-
-	if (status)
-		ret |= BMG160_INT_MAP_1_BIT_NEW_DATA;
-	else
-		ret &= ~BMG160_INT_MAP_1_BIT_NEW_DATA;
-
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_INT_MAP_1,
-					ret);
+	ret = regmap_update_bits(data->regmap, BMG160_REG_INT_MAP_1,
+				 BMG160_INT_MAP_1_BIT_NEW_DATA,
+				 (status ? BMG160_INT_MAP_1_BIT_NEW_DATA : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_map1\n");
+		dev_err(&data->client->dev, "Error updating bits in reg_int_map1\n");
 		return ret;
 	}
 
 	if (status) {
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_INT_RST_LATCH,
-						BMG160_INT_MODE_NON_LATCH_INT |
-						BMG160_INT_MODE_LATCH_RESET);
+		ret = regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
+				   BMG160_INT_MODE_NON_LATCH_INT |
+				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
 			dev_err(&data->client->dev,
 				"Error writing reg_rst_latch\n");
 				return ret;
 		}
 
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_INT_EN_0,
-						BMG160_DATA_ENABLE_INT);
+		ret = regmap_write(data->regmap, BMG160_REG_INT_EN_0,
+				   BMG160_DATA_ENABLE_INT);
 
 	} else {
 		/* Restore interrupt mode */
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_INT_RST_LATCH,
-						BMG160_INT_MODE_LATCH_INT |
-						BMG160_INT_MODE_LATCH_RESET);
+		ret = regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
+				   BMG160_INT_MODE_LATCH_INT |
+				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
 			dev_err(&data->client->dev,
 				"Error writing reg_rst_latch\n");
 				return ret;
 		}
 
-		ret = i2c_smbus_write_byte_data(data->client,
-						BMG160_REG_INT_EN_0,
-						0);
+		ret = regmap_write(data->regmap, BMG160_REG_INT_EN_0, 0);
 	}
 
 	if (ret < 0) {
@@ -444,10 +413,8 @@ static int bmg160_set_scale(struct bmg160_data *data, int val)
 
 	for (i = 0; i < ARRAY_SIZE(bmg160_scale_table); ++i) {
 		if (bmg160_scale_table[i].scale == val) {
-			ret = i2c_smbus_write_byte_data(
-					data->client,
-					BMG160_REG_RANGE,
-					bmg160_scale_table[i].dps_range);
+			ret = regmap_write(data->regmap, BMG160_REG_RANGE,
+					   bmg160_scale_table[i].dps_range);
 			if (ret < 0) {
 				dev_err(&data->client->dev,
 					"Error writing reg_range\n");
@@ -464,6 +431,7 @@ static int bmg160_set_scale(struct bmg160_data *data, int val)
 static int bmg160_get_temp(struct bmg160_data *data, int *val)
 {
 	int ret;
+	unsigned int raw_val;
 
 	mutex_lock(&data->mutex);
 	ret = bmg160_set_power_state(data, true);
@@ -472,7 +440,7 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_TEMP);
+	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_temp\n");
 		bmg160_set_power_state(data, false);
@@ -480,7 +448,7 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 		return ret;
 	}
 
-	*val = sign_extend32(ret, 7);
+	*val = sign_extend32(raw_val, 7);
 	ret = bmg160_set_power_state(data, false);
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
@@ -492,6 +460,7 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 {
 	int ret;
+	unsigned int raw_val;
 
 	mutex_lock(&data->mutex);
 	ret = bmg160_set_power_state(data, true);
@@ -500,7 +469,8 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 		return ret;
 	}
 
-	ret = i2c_smbus_read_word_data(data->client, BMG160_AXIS_TO_REG(axis));
+	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
+			       2);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
 		bmg160_set_power_state(data, false);
@@ -508,7 +478,7 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 		return ret;
 	}
 
-	*val = sign_extend32(ret, 15);
+	*val = sign_extend32(raw_val, 15);
 	ret = bmg160_set_power_state(data, false);
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
@@ -807,12 +777,13 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmg160_data *data = iio_priv(indio_dev);
 	int bit, ret, i = 0;
+	unsigned int val;
 
 	mutex_lock(&data->mutex);
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
-		ret = i2c_smbus_read_word_data(data->client,
-					       BMG160_AXIS_TO_REG(bit));
+		ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(bit),
+				       &val, 2);
 		if (ret < 0) {
 			mutex_unlock(&data->mutex);
 			goto err;
@@ -840,10 +811,9 @@ static int bmg160_trig_try_reen(struct iio_trigger *trig)
 		return 0;
 
 	/* Set latched mode interrupt and clear any latched interrupt */
-	ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_INT_RST_LATCH,
-					BMG160_INT_MODE_LATCH_INT |
-					BMG160_INT_MODE_LATCH_RESET);
+	ret = regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
+			   BMG160_INT_MODE_LATCH_INT |
+			   BMG160_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_rst_latch\n");
 		return ret;
@@ -907,33 +877,34 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
 	struct bmg160_data *data = iio_priv(indio_dev);
 	int ret;
 	int dir;
+	unsigned int val;
 
-	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_STATUS_2);
+	ret = regmap_read(data->regmap, BMG160_REG_INT_STATUS_2, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_status2\n");
 		goto ack_intr_status;
 	}
 
-	if (ret & 0x08)
+	if (val & 0x08)
 		dir = IIO_EV_DIR_RISING;
 	else
 		dir = IIO_EV_DIR_FALLING;
 
-	if (ret & BMG160_ANY_MOTION_BIT_X)
+	if (val & BMG160_ANY_MOTION_BIT_X)
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
 							0,
 							IIO_MOD_X,
 							IIO_EV_TYPE_ROC,
 							dir),
 							iio_get_time_ns());
-	if (ret & BMG160_ANY_MOTION_BIT_Y)
+	if (val & BMG160_ANY_MOTION_BIT_Y)
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
 							0,
 							IIO_MOD_Y,
 							IIO_EV_TYPE_ROC,
 							dir),
 							iio_get_time_ns());
-	if (ret & BMG160_ANY_MOTION_BIT_Z)
+	if (val & BMG160_ANY_MOTION_BIT_Z)
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
 							0,
 							IIO_MOD_Z,
@@ -943,10 +914,9 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
 
 ack_intr_status:
 	if (!data->dready_trigger_on) {
-		ret = i2c_smbus_write_byte_data(data->client,
-					BMG160_REG_INT_RST_LATCH,
-					BMG160_INT_MODE_LATCH_INT |
-					BMG160_INT_MODE_LATCH_RESET);
+		ret = regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
+				   BMG160_INT_MODE_LATCH_INT |
+				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0)
 			dev_err(&data->client->dev,
 				"Error writing reg_rst_latch\n");
@@ -1038,6 +1008,14 @@ static int bmg160_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
 	const char *name = NULL;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
-- 
2.1.4

