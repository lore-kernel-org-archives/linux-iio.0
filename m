Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35489 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbcDFFVd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 01:21:33 -0400
Date: Tue, 5 Apr 2016 22:21:31 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 9/9] iio: gyro: bmg160_core: use regmap to retrieve struct
 device
Message-ID: <0f9aa018527fa698196caa51cff174c16a4cf34e.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1459918214.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver includes struct regmap and struct device in its global data.
Remove the struct device and use regmap API to retrieve device info.

Patch created using Coccinelle plus manual edits.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/gyro/bmg160_core.c | 86 +++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 2493bb1..b2b1071 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -95,7 +95,6 @@
 #define BMG160_AUTO_SUSPEND_DELAY_MS	2000
 
 struct bmg160_data {
-	struct device *dev;
 	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
@@ -137,11 +136,12 @@ static const struct {
 
 static int bmg160_set_mode(struct bmg160_data *data, u8 mode)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_LPW, mode);
 	if (ret < 0) {
-		dev_err(data->dev, "Error writing reg_pmu_lpw\n");
+		dev_err(dev, "Error writing reg_pmu_lpw\n");
 		return ret;
 	}
 
@@ -162,6 +162,7 @@ static int bmg160_convert_freq_to_bit(int val)
 
 static int bmg160_set_bw(struct bmg160_data *data, int val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	int bw_bits;
 
@@ -171,7 +172,7 @@ static int bmg160_set_bw(struct bmg160_data *data, int val)
 
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW, bw_bits);
 	if (ret < 0) {
-		dev_err(data->dev, "Error writing reg_pmu_bw\n");
+		dev_err(dev, "Error writing reg_pmu_bw\n");
 		return ret;
 	}
 
@@ -182,18 +183,19 @@ static int bmg160_set_bw(struct bmg160_data *data, int val)
 
 static int bmg160_chip_init(struct bmg160_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	unsigned int val;
 
 	ret = regmap_read(data->regmap, BMG160_REG_CHIP_ID, &val);
 	if (ret < 0) {
-		dev_err(data->dev, "Error reading reg_chip_id\n");
+		dev_err(dev, "Error reading reg_chip_id\n");
 		return ret;
 	}
 
-	dev_dbg(data->dev, "Chip Id %x\n", val);
+	dev_dbg(dev, "Chip Id %x\n", val);
 	if (val != BMG160_CHIP_ID_VAL) {
-		dev_err(data->dev, "invalid chip %x\n", val);
+		dev_err(dev, "invalid chip %x\n", val);
 		return -ENODEV;
 	}
 
@@ -212,14 +214,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	/* Set Default Range */
 	ret = regmap_write(data->regmap, BMG160_REG_RANGE, BMG160_RANGE_500DPS);
 	if (ret < 0) {
-		dev_err(data->dev, "Error writing reg_range\n");
+		dev_err(dev, "Error writing reg_range\n");
 		return ret;
 	}
 	data->dps_range = BMG160_RANGE_500DPS;
 
 	ret = regmap_read(data->regmap, BMG160_REG_SLOPE_THRES, &val);
 	if (ret < 0) {
-		dev_err(data->dev, "Error reading reg_slope_thres\n");
+		dev_err(dev, "Error reading reg_slope_thres\n");
 		return ret;
 	}
 	data->slope_thres = val;
@@ -228,7 +230,7 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	ret = regmap_update_bits(data->regmap, BMG160_REG_INT_EN_1,
 				 BMG160_INT1_BIT_OD, 0);
 	if (ret < 0) {
-		dev_err(data->dev, "Error updating bits in reg_int_en_1\n");
+		dev_err(dev, "Error updating bits in reg_int_en_1\n");
 		return ret;
 	}
 
@@ -236,7 +238,7 @@ static int bmg160_chip_init(struct bmg160_data *data)
 			   BMG160_INT_MODE_LATCH_INT |
 			   BMG160_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
-		dev_err(data->dev,
+		dev_err(dev,
 			"Error writing reg_motion_intr\n");
 		return ret;
 	}
@@ -247,20 +249,21 @@ static int bmg160_chip_init(struct bmg160_data *data)
 static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 {
 #ifdef CONFIG_PM
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (on)
-		ret = pm_runtime_get_sync(data->dev);
+		ret = pm_runtime_get_sync(dev);
 	else {
-		pm_runtime_mark_last_busy(data->dev);
-		ret = pm_runtime_put_autosuspend(data->dev);
+		pm_runtime_mark_last_busy(dev);
+		ret = pm_runtime_put_autosuspend(dev);
 	}
 
 	if (ret < 0) {
-		dev_err(data->dev,
-			"Failed: bmg160_set_power_state for %d\n", on);
+		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
+
 		if (on)
-			pm_runtime_put_noidle(data->dev);
+			pm_runtime_put_noidle(dev);
 
 		return ret;
 	}
@@ -272,6 +275,7 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 					     bool status)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	/* Enable/Disable INT_MAP0 mapping */
@@ -279,7 +283,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 				 BMG160_INT_MAP_0_BIT_ANY,
 				 (status ? BMG160_INT_MAP_0_BIT_ANY : 0));
 	if (ret < 0) {
-		dev_err(data->dev, "Error updating bits reg_int_map0\n");
+		dev_err(dev, "Error updating bits reg_int_map0\n");
 		return ret;
 	}
 
@@ -289,8 +293,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 		ret = regmap_write(data->regmap, BMG160_REG_SLOPE_THRES,
 				   data->slope_thres);
 		if (ret < 0) {
-			dev_err(data->dev,
-				"Error writing reg_slope_thres\n");
+			dev_err(dev, "Error writing reg_slope_thres\n");
 			return ret;
 		}
 
@@ -298,8 +301,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 				   BMG160_INT_MOTION_X | BMG160_INT_MOTION_Y |
 				   BMG160_INT_MOTION_Z);
 		if (ret < 0) {
-			dev_err(data->dev,
-				"Error writing reg_motion_intr\n");
+			dev_err(dev, "Error writing reg_motion_intr\n");
 			return ret;
 		}
 
@@ -314,8 +316,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 					   BMG160_INT_MODE_LATCH_INT |
 					   BMG160_INT_MODE_LATCH_RESET);
 			if (ret < 0) {
-				dev_err(data->dev,
-					"Error writing reg_rst_latch\n");
+				dev_err(dev, "Error writing reg_rst_latch\n");
 				return ret;
 			}
 		}
@@ -328,7 +329,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 	}
 
 	if (ret < 0) {
-		dev_err(data->dev, "Error writing reg_int_en0\n");
+		dev_err(dev, "Error writing reg_int_en0\n");
 		return ret;
 	}
 
@@ -338,6 +339,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 					   bool status)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	/* Enable/Disable INT_MAP1 mapping */
@@ -345,7 +347,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 				 BMG160_INT_MAP_1_BIT_NEW_DATA,
 				 (status ? BMG160_INT_MAP_1_BIT_NEW_DATA : 0));
 	if (ret < 0) {
-		dev_err(data->dev, "Error updating bits in reg_int_map1\n");
+		dev_err(dev, "Error updating bits in reg_int_map1\n");
 		return ret;
 	}
 
@@ -354,9 +356,8 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 				   BMG160_INT_MODE_NON_LATCH_INT |
 				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
-			dev_err(data->dev,
-				"Error writing reg_rst_latch\n");
-				return ret;
+			dev_err(dev, "Error writing reg_rst_latch\n");
+			return ret;
 		}
 
 		ret = regmap_write(data->regmap, BMG160_REG_INT_EN_0,
@@ -368,16 +369,15 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 				   BMG160_INT_MODE_LATCH_INT |
 				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
-			dev_err(data->dev,
-				"Error writing reg_rst_latch\n");
-				return ret;
+			dev_err(dev, "Error writing reg_rst_latch\n");
+			return ret;
 		}
 
 		ret = regmap_write(data->regmap, BMG160_REG_INT_EN_0, 0);
 	}
 
 	if (ret < 0) {
-		dev_err(data->dev, "Error writing reg_int_en0\n");
+		dev_err(dev, "Error writing reg_int_en0\n");
 		return ret;
 	}
 
@@ -400,6 +400,7 @@ static int bmg160_get_bw(struct bmg160_data *data, int *val)
 
 static int bmg160_set_scale(struct bmg160_data *data, int val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret, i;
 
 	for (i = 0; i < ARRAY_SIZE(bmg160_scale_table); ++i) {
@@ -407,8 +408,7 @@ static int bmg160_set_scale(struct bmg160_data *data, int val)
 			ret = regmap_write(data->regmap, BMG160_REG_RANGE,
 					   bmg160_scale_table[i].dps_range);
 			if (ret < 0) {
-				dev_err(data->dev,
-					"Error writing reg_range\n");
+				dev_err(dev, "Error writing reg_range\n");
 				return ret;
 			}
 			data->dps_range = bmg160_scale_table[i].dps_range;
@@ -421,6 +421,7 @@ static int bmg160_set_scale(struct bmg160_data *data, int val)
 
 static int bmg160_get_temp(struct bmg160_data *data, int *val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	unsigned int raw_val;
 
@@ -433,7 +434,7 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 
 	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
 	if (ret < 0) {
-		dev_err(data->dev, "Error reading reg_temp\n");
+		dev_err(dev, "Error reading reg_temp\n");
 		bmg160_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -450,6 +451,7 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 
 static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	unsigned int raw_val;
 
@@ -463,7 +465,7 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
 			       2);
 	if (ret < 0) {
-		dev_err(data->dev, "Error reading axis %d\n", axis);
+		dev_err(dev, "Error reading axis %d\n", axis);
 		bmg160_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -793,6 +795,7 @@ static int bmg160_trig_try_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	/* new data interrupts don't need ack */
@@ -804,7 +807,7 @@ static int bmg160_trig_try_reen(struct iio_trigger *trig)
 			   BMG160_INT_MODE_LATCH_INT |
 			   BMG160_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
-		dev_err(data->dev, "Error writing reg_rst_latch\n");
+		dev_err(dev, "Error writing reg_rst_latch\n");
 		return ret;
 	}
 
@@ -864,13 +867,14 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	int dir;
 	unsigned int val;
 
 	ret = regmap_read(data->regmap, BMG160_REG_INT_STATUS_2, &val);
 	if (ret < 0) {
-		dev_err(data->dev, "Error reading reg_int_status2\n");
+		dev_err(dev, "Error reading reg_int_status2\n");
 		goto ack_intr_status;
 	}
 
@@ -907,8 +911,7 @@ ack_intr_status:
 				   BMG160_INT_MODE_LATCH_INT |
 				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0)
-			dev_err(data->dev,
-				"Error writing reg_rst_latch\n");
+			dev_err(dev, "Error writing reg_rst_latch\n");
 	}
 
 	return IRQ_HANDLED;
@@ -976,7 +979,6 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
-	data->dev = dev;
 	data->irq = irq;
 	data->regmap = regmap;
 
@@ -1139,7 +1141,7 @@ static int bmg160_runtime_suspend(struct device *dev)
 
 	ret = bmg160_set_mode(data, BMG160_MODE_SUSPEND);
 	if (ret < 0) {
-		dev_err(data->dev, "set mode failed\n");
+		dev_err(dev, "set mode failed\n");
 		return -EAGAIN;
 	}
 
-- 
2.1.4

