Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52997 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbbIUKzm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2015 06:55:42 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 2/4] iio: bcm150: Remove i2c_client from private data
Date: Mon, 21 Sep 2015 12:55:14 +0200
Message-Id: <1442832916-30774-3-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1442832916-30774-1-git-send-email-mpa@pengutronix.de>
References: <1442832916-30774-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

i2c_client struct is now only used for debugging output. We can use the
device struct as well so we can remove all struct i2c_client usage.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/bmc150-accel.c | 116 +++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index a17034fd53fb..425885dc6800 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -186,9 +186,9 @@ enum bmc150_accel_trigger_id {
 };
 
 struct bmc150_accel_data {
-	struct i2c_client *client;
 	struct regmap *regmap;
 	struct device *dev;
+	int irq;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	atomic_t active_intr;
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
@@ -278,11 +278,11 @@ static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
 	lpw_bits = mode << BMC150_ACCEL_PMU_MODE_SHIFT;
 	lpw_bits |= (dur_val << BMC150_ACCEL_PMU_BIT_SLEEP_DUR_SHIFT);
 
-	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
+	dev_dbg(data->dev, "Set Mode bits %x\n", lpw_bits);
 
 	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
+		dev_err(data->dev, "Error writing reg_pmu_lpw\n");
 		return ret;
 	}
 
@@ -320,18 +320,18 @@ static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
 	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
 					data->slope_thres);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_6\n");
+		dev_err(data->dev, "Error writing reg_int_6\n");
 		return ret;
 	}
 
 	ret = regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
 				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error updating reg_int_5\n");
+		dev_err(data->dev, "Error updating reg_int_5\n");
 		return ret;
 	}
 
-	dev_dbg(&data->client->dev, "%s: %x %x\n", __func__, data->slope_thres,
+	dev_dbg(data->dev, "%s: %x %x\n", __func__, data->slope_thres,
 		data->slope_dur);
 
 	return ret;
@@ -380,17 +380,17 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	int ret;
 
 	if (on) {
-		ret = pm_runtime_get_sync(&data->client->dev);
+		ret = pm_runtime_get_sync(data->dev);
 	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
+		pm_runtime_mark_last_busy(data->dev);
+		ret = pm_runtime_put_autosuspend(data->dev);
 	}
 
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Failed: bmc150_accel_set_power_state for %d\n", on);
 		if (on)
-			pm_runtime_put_noidle(&data->client->dev);
+			pm_runtime_put_noidle(data->dev);
 
 		return ret;
 	}
@@ -473,7 +473,7 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
 				 (state ? info->map_bitmask : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error updating reg_int_map\n");
+		dev_err(data->dev, "Error updating reg_int_map\n");
 		goto out_fix_power_state;
 	}
 
@@ -481,7 +481,7 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	ret = regmap_update_bits(data->regmap, info->en_reg, info->en_bitmask,
 				 (state ? info->en_bitmask : 0));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error updating reg_int_en\n");
+		dev_err(data->dev, "Error updating reg_int_en\n");
 		goto out_fix_power_state;
 	}
 
@@ -507,7 +507,7 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
 				     BMC150_ACCEL_REG_PMU_RANGE,
 				     data->chip_info->scale_table[i].reg_range);
 			if (ret < 0) {
-				dev_err(&data->client->dev,
+				dev_err(data->dev,
 					"Error writing pmu_range\n");
 				return ret;
 			}
@@ -529,7 +529,7 @@ static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_temp\n");
+		dev_err(data->dev, "Error reading reg_temp\n");
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -558,7 +558,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
 			       &raw_val, 2);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
+		dev_err(data->dev, "Error reading axis %d\n", axis);
 		bmc150_accel_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -872,7 +872,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
+		dev_err(data->dev, "Error reading reg_fifo_status\n");
 		return ret;
 	}
 
@@ -1159,7 +1159,7 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
 			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 	mutex_unlock(&data->mutex);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Error writing reg_int_rst_latch\n");
 		return ret;
 	}
@@ -1217,7 +1217,7 @@ static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
+		dev_err(data->dev, "Error reading reg_int_status_2\n");
 		return ret;
 	}
 
@@ -1283,8 +1283,7 @@ static irqreturn_t bmc150_accel_irq_thread_handler(int irq, void *private)
 				   BMC150_ACCEL_INT_MODE_LATCH_INT |
 				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 		if (ret)
-			dev_err(&data->client->dev,
-				"Error writing reg_int_rst_latch\n");
+			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
 
 		ret = IRQ_HANDLED;
 	} else {
@@ -1323,17 +1322,13 @@ static irqreturn_t bmc150_accel_irq_handler(int irq, void *private)
 	return IRQ_NONE;
 }
 
-static int bmc150_accel_gpio_probe(struct i2c_client *client,
-				   struct bmc150_accel_data *data)
+static int bmc150_accel_gpio_probe(struct bmc150_accel_data *data)
 {
 	struct device *dev;
 	struct gpio_desc *gpio;
 	int ret;
 
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
+	dev = data->dev;
 
 	/* data ready gpio interrupt pin */
 	gpio = devm_gpiod_get_index(dev, BMC150_ACCEL_GPIO_NAME, 0, GPIOD_IN);
@@ -1386,7 +1381,7 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
 	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
 		struct bmc150_accel_trigger *t = &data->triggers[i];
 
-		t->indio_trig = devm_iio_trigger_alloc(&data->client->dev,
+		t->indio_trig = devm_iio_trigger_alloc(data->dev,
 					       bmc150_accel_triggers[i].name,
 						       indio_dev->name,
 						       indio_dev->id);
@@ -1395,7 +1390,7 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
 			break;
 		}
 
-		t->indio_trig->dev.parent = &data->client->dev;
+		t->indio_trig->dev.parent = data->dev;
 		t->indio_trig->ops = &bmc150_accel_trigger_ops;
 		t->intr = bmc150_accel_triggers[i].intr;
 		t->data = data;
@@ -1424,7 +1419,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
 
 	ret = regmap_write(data->regmap, reg, data->fifo_mode);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
+		dev_err(data->dev, "Error writing reg_fifo_config1\n");
 		return ret;
 	}
 
@@ -1434,7 +1429,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
 	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
 			   data->watermark);
 	if (ret < 0)
-		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
+		dev_err(data->dev, "Error writing reg_fifo_config0\n");
 
 	return ret;
 }
@@ -1523,12 +1518,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Error: Reading chip id\n");
 		return ret;
 	}
 
-	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
+	dev_dbg(data->dev, "Chip Id %x\n", val);
 	for (i = 0; i < ARRAY_SIZE(bmc150_accel_chip_info_tbl); i++) {
 		if (bmc150_accel_chip_info_tbl[i].chip_id == val) {
 			data->chip_info = &bmc150_accel_chip_info_tbl[i];
@@ -1537,7 +1532,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 	}
 
 	if (!data->chip_info) {
-		dev_err(&data->client->dev, "Invalid chip %x\n", val);
+		dev_err(data->dev, "Invalid chip %x\n", val);
 		return -ENODEV;
 	}
 
@@ -1554,7 +1549,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
 			   BMC150_ACCEL_DEF_RANGE_4G);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 					"Error writing reg_pmu_range\n");
 		return ret;
 	}
@@ -1573,7 +1568,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 			   BMC150_ACCEL_INT_MODE_LATCH_INT |
 			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Error writing reg_int_rst_latch\n");
 		return ret;
 	}
@@ -1588,6 +1583,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
 	const char *name = NULL;
+	struct device *dev;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -1595,12 +1591,13 @@ static int bmc150_accel_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
 	data->dev = &client->dev;
+	dev = &client->dev;
+	data->irq = client->irq;
 
 	data->regmap = devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
 	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
+		dev_err(dev, "Failed to initialize i2c regmap\n");
 		return PTR_ERR(data->regmap);
 	}
 
@@ -1613,7 +1610,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 
 	mutex_init(&data->mutex);
 
-	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.parent = dev;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->name = name ? name : data->chip_info->name;
@@ -1625,16 +1622,16 @@ static int bmc150_accel_probe(struct i2c_client *client,
 					 bmc150_accel_trigger_handler,
 					 &bmc150_accel_buffer_ops);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed: iio triggered buffer setup\n");
+		dev_err(data->dev, "Failed: iio triggered buffer setup\n");
 		return ret;
 	}
 
-	if (client->irq < 0)
-		client->irq = bmc150_accel_gpio_probe(client, data);
+	if (data->irq <= 0)
+		data->irq = bmc150_accel_gpio_probe(data);
 
-	if (client->irq > 0) {
+	if (data->irq > 0) {
 		ret = devm_request_threaded_irq(
-						&client->dev, client->irq,
+						data->dev, data->irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,
 						IRQF_TRIGGER_RISING,
@@ -1652,7 +1649,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
 				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
 		if (ret < 0) {
-			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
+			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
 			goto err_buffer_cleanup;
 		}
 
@@ -1673,18 +1670,17 @@ static int bmc150_accel_probe(struct i2c_client *client,
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "Unable to register iio device\n");
+		dev_err(data->dev, "Unable to register iio device\n");
 		goto err_trigger_unregister;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		goto err_iio_unregister;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
-					 BMC150_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, BMC150_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
 
 	return 0;
 
@@ -1703,9 +1699,9 @@ static int bmc150_accel_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
+	pm_runtime_disable(data->dev);
+	pm_runtime_set_suspended(data->dev);
+	pm_runtime_put_noidle(data->dev);
 
 	iio_device_unregister(indio_dev);
 
@@ -1723,7 +1719,7 @@ static int bmc150_accel_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int bmc150_accel_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->mutex);
@@ -1735,7 +1731,7 @@ static int bmc150_accel_suspend(struct device *dev)
 
 static int bmc150_accel_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->mutex);
@@ -1751,11 +1747,11 @@ static int bmc150_accel_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int bmc150_accel_runtime_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	dev_dbg(&data->client->dev,  __func__);
+	dev_dbg(data->dev,  __func__);
 	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);
 	if (ret < 0)
 		return -EAGAIN;
@@ -1765,12 +1761,12 @@ static int bmc150_accel_runtime_suspend(struct device *dev)
 
 static int bmc150_accel_runtime_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 	int sleep_val;
 
-	dev_dbg(&data->client->dev,  __func__);
+	dev_dbg(data->dev,  __func__);
 
 	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
 	if (ret < 0)
-- 
2.5.1

