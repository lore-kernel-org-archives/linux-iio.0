Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43211 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbbG2NrK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 09:47:10 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 3/7] iio: bmg160: Remove i2c_client from data struct
Date: Wed, 29 Jul 2015 15:46:05 +0200
Message-Id: <1438177569-18772-4-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

i2c_client variable is not really used anymore in the core driver. It is
only used to get the device to make proper outputs.

This patch replaces all i2c_client usage through direct usage of the
device pointer.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/gyro/bmg160.c | 64 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 626f5c98dde8..71c605ea85ad 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -98,7 +98,7 @@
 #define BMG160_AUTO_SUSPEND_DELAY_MS	2000
 
 struct bmg160_data {
-	struct i2c_client *client;
+	struct device *dev;
 	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
@@ -150,7 +150,7 @@ static int bmg160_set_mode(struct bmg160_data *data, u8 mode)
 
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_LPW, mode);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
+		dev_err(data->dev, "Error writing reg_pmu_lpw\n");
 		return ret;
 	}
 
@@ -180,7 +180,7 @@ static int bmg160_set_bw(struct bmg160_data *data, int val)
 
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW, bw_bits);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_pmu_bw\n");
+		dev_err(data->dev, "Error writing reg_pmu_bw\n");
 		return ret;
 	}
 
@@ -196,13 +196,13 @@ static int bmg160_chip_init(struct bmg160_data *data)
 
 	ret = regmap_read(data->regmap, BMG160_REG_CHIP_ID, &val);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_chip_id\n");
+		dev_err(data->dev, "Error reading reg_chip_id\n");
 		return ret;
 	}
 
-	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
+	dev_dbg(data->dev, "Chip Id %x\n", val);
 	if (val != BMG160_CHIP_ID_VAL) {
-		dev_err(&data->client->dev, "invalid chip %x\n", val);
+		dev_err(data->dev, "invalid chip %x\n", val);
 		return -ENODEV;
 	}
 
@@ -221,14 +221,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	/* Set Default Range */
 	ret = regmap_write(data->regmap, BMG160_REG_RANGE, BMG160_RANGE_500DPS);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_range\n");
+		dev_err(data->dev, "Error writing reg_range\n");
 		return ret;
 	}
 	data->dps_range = BMG160_RANGE_500DPS;
 
 	ret = regmap_read(data->regmap, BMG160_REG_SLOPE_THRES, &val);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_slope_thres\n");
+		dev_err(data->dev, "Error reading reg_slope_thres\n");
 		return ret;
 	}
 	data->slope_thres = val;
@@ -237,7 +237,7 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	ret = regmap_update_bits(data->regmap, BMG160_REG_INT_EN_1,
 				 BMG160_INT1_BIT_OD, 0);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error updating bits in reg_int_en_1\n");
+		dev_err(data->dev, "Error updating bits in reg_int_en_1\n");
 		return ret;
 	}
 
@@ -245,7 +245,7 @@ static int bmg160_chip_init(struct bmg160_data *data)
 			   BMG160_INT_MODE_LATCH_INT |
 			   BMG160_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Error writing reg_motion_intr\n");
 		return ret;
 	}
@@ -259,17 +259,17 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 	int ret;
 
 	if (on)
-		ret = pm_runtime_get_sync(&data->client->dev);
+		ret = pm_runtime_get_sync(data->dev);
 	else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
+		pm_runtime_mark_last_busy(data->dev);
+		ret = pm_runtime_put_autosuspend(data->dev);
 	}
 
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Failed: bmg160_set_power_state for %d\n", on);
 		if (on)
-			pm_runtime_put_noidle(&data->client->dev);
+			pm_runtime_put_noidle(data->dev);
 
 		return ret;
 	}
@@ -288,7 +288,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 				 BMG160_INT_MAP_0_BIT_ANY,
 				 (status ? BMG160_INT_MAP_0_BIT_ANY : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error updating bits reg_int_map0\n");
+		dev_err(data->dev, "Error updating bits reg_int_map0\n");
 		return ret;
 	}
 
@@ -298,7 +298,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 		ret = regmap_write(data->regmap, BMG160_REG_SLOPE_THRES,
 				   data->slope_thres);
 		if (ret < 0) {
-			dev_err(&data->client->dev,
+			dev_err(data->dev,
 				"Error writing reg_slope_thres\n");
 			return ret;
 		}
@@ -307,7 +307,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 				   BMG160_INT_MOTION_X | BMG160_INT_MOTION_Y |
 				   BMG160_INT_MOTION_Z);
 		if (ret < 0) {
-			dev_err(&data->client->dev,
+			dev_err(data->dev,
 				"Error writing reg_motion_intr\n");
 			return ret;
 		}
@@ -323,7 +323,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 					   BMG160_INT_MODE_LATCH_INT |
 					   BMG160_INT_MODE_LATCH_RESET);
 			if (ret < 0) {
-				dev_err(&data->client->dev,
+				dev_err(data->dev,
 					"Error writing reg_rst_latch\n");
 				return ret;
 			}
@@ -337,7 +337,7 @@ static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 	}
 
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_en0\n");
+		dev_err(data->dev, "Error writing reg_int_en0\n");
 		return ret;
 	}
 
@@ -354,7 +354,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 				 BMG160_INT_MAP_1_BIT_NEW_DATA,
 				 (status ? BMG160_INT_MAP_1_BIT_NEW_DATA : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error updating bits in reg_int_map1\n");
+		dev_err(data->dev, "Error updating bits in reg_int_map1\n");
 		return ret;
 	}
 
@@ -363,7 +363,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 				   BMG160_INT_MODE_NON_LATCH_INT |
 				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
-			dev_err(&data->client->dev,
+			dev_err(data->dev,
 				"Error writing reg_rst_latch\n");
 				return ret;
 		}
@@ -377,7 +377,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 				   BMG160_INT_MODE_LATCH_INT |
 				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
-			dev_err(&data->client->dev,
+			dev_err(data->dev,
 				"Error writing reg_rst_latch\n");
 				return ret;
 		}
@@ -386,7 +386,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 	}
 
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_en0\n");
+		dev_err(data->dev, "Error writing reg_int_en0\n");
 		return ret;
 	}
 
@@ -416,7 +416,7 @@ static int bmg160_set_scale(struct bmg160_data *data, int val)
 			ret = regmap_write(data->regmap, BMG160_REG_RANGE,
 					   bmg160_scale_table[i].dps_range);
 			if (ret < 0) {
-				dev_err(&data->client->dev,
+				dev_err(data->dev,
 					"Error writing reg_range\n");
 				return ret;
 			}
@@ -442,7 +442,7 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 
 	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_temp\n");
+		dev_err(data->dev, "Error reading reg_temp\n");
 		bmg160_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -472,7 +472,7 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
 			       2);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
+		dev_err(data->dev, "Error reading axis %d\n", axis);
 		bmg160_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -815,7 +815,7 @@ static int bmg160_trig_try_reen(struct iio_trigger *trig)
 			   BMG160_INT_MODE_LATCH_INT |
 			   BMG160_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_rst_latch\n");
+		dev_err(data->dev, "Error writing reg_rst_latch\n");
 		return ret;
 	}
 
@@ -881,7 +881,7 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
 
 	ret = regmap_read(data->regmap, BMG160_REG_INT_STATUS_2, &val);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_status2\n");
+		dev_err(data->dev, "Error reading reg_int_status2\n");
 		goto ack_intr_status;
 	}
 
@@ -918,7 +918,7 @@ ack_intr_status:
 				   BMG160_INT_MODE_LATCH_INT |
 				   BMG160_INT_MODE_LATCH_RESET);
 		if (ret < 0)
-			dev_err(&data->client->dev,
+			dev_err(data->dev,
 				"Error writing reg_rst_latch\n");
 	}
 
@@ -1023,7 +1023,7 @@ static int bmg160_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	data->dev = &client->dev;
 
 	ret = bmg160_chip_init(data);
 	if (ret < 0)
@@ -1190,7 +1190,7 @@ static int bmg160_runtime_suspend(struct device *dev)
 
 	ret = bmg160_set_mode(data, BMG160_MODE_SUSPEND);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "set mode failed\n");
+		dev_err(data->dev, "set mode failed\n");
 		return -EAGAIN;
 	}
 
-- 
2.1.4

