Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44382 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977AbbHDLDU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 07:03:20 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 4/6] iio: bmg160: Remove remaining uses of i2c_client
Date: Tue,  4 Aug 2015 13:02:57 +0200
Message-Id: <1438686179-18635-5-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
References: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/gyro/bmg160.c | 55 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index b47b7af19e32..865ef4c1c43f 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -110,6 +110,7 @@ struct bmg160_data {
 	int slope_thres;
 	bool dready_trigger_on;
 	bool motion_trigger_on;
+	int irq;
 };
 
 enum bmg160_axis {
@@ -963,18 +964,14 @@ static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
 	.postdisable = bmg160_buffer_postdisable,
 };
 
-static int bmg160_gpio_probe(struct i2c_client *client,
-			     struct bmg160_data *data)
+static int bmg160_gpio_probe(struct bmg160_data *data)
 
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
 	gpio = devm_gpiod_get_index(dev, BMG160_GPIO_NAME, 0, GPIOD_IN);
@@ -983,11 +980,11 @@ static int bmg160_gpio_probe(struct i2c_client *client,
 		return PTR_ERR(gpio);
 	}
 
-	ret = gpiod_to_irq(gpio);
+	data->irq = gpiod_to_irq(gpio);
 
 	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
 
-	return ret;
+	return 0;
 }
 
 static const char *bmg160_match_acpi_device(struct device *dev)
@@ -1009,6 +1006,7 @@ static int bmg160_probe(struct i2c_client *client,
 	int ret;
 	const char *name = NULL;
 	struct regmap *regmap;
+	struct device *dev = &client->dev;
 
 	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
 	if (IS_ERR(regmap)) {
@@ -1022,8 +1020,9 @@ static int bmg160_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	dev_set_drvdata(&client->dev, indio_dev);
-	data->dev = &client->dev;
+	dev_set_drvdata(dev, indio_dev);
+	data->dev = dev;
+	data->irq = client->irq;
 
 	ret = bmg160_chip_init(data);
 	if (ret < 0)
@@ -1034,22 +1033,22 @@ static int bmg160_probe(struct i2c_client *client,
 	if (id)
 		name = id->name;
 
-	if (ACPI_HANDLE(&client->dev))
-		name = bmg160_match_acpi_device(&client->dev);
+	if (ACPI_HANDLE(dev))
+		name = bmg160_match_acpi_device(dev);
 
-	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.parent = dev;
 	indio_dev->channels = bmg160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmg160_channels);
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmg160_info;
 
-	if (client->irq <= 0)
-		client->irq = bmg160_gpio_probe(client, data);
+	if (data->irq <= 0)
+		bmg160_gpio_probe(data);
 
-	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(&client->dev,
-						client->irq,
+	if (data->irq > 0) {
+		ret = devm_request_threaded_irq(dev,
+						data->irq,
 						bmg160_data_rdy_trig_poll,
 						bmg160_event_handler,
 						IRQF_TRIGGER_RISING,
@@ -1058,28 +1057,28 @@ static int bmg160_probe(struct i2c_client *client,
 		if (ret)
 			return ret;
 
-		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
+		data->dready_trig = devm_iio_trigger_alloc(dev,
 							   "%s-dev%d",
 							   indio_dev->name,
 							   indio_dev->id);
 		if (!data->dready_trig)
 			return -ENOMEM;
 
-		data->motion_trig = devm_iio_trigger_alloc(&client->dev,
+		data->motion_trig = devm_iio_trigger_alloc(dev,
 							  "%s-any-motion-dev%d",
 							  indio_dev->name,
 							  indio_dev->id);
 		if (!data->motion_trig)
 			return -ENOMEM;
 
-		data->dready_trig->dev.parent = &client->dev;
+		data->dready_trig->dev.parent = dev;
 		data->dready_trig->ops = &bmg160_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
 		if (ret)
 			return ret;
 
-		data->motion_trig->dev.parent = &client->dev;
+		data->motion_trig->dev.parent = dev;
 		data->motion_trig->ops = &bmg160_trigger_ops;
 		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
 		ret = iio_trigger_register(data->motion_trig);
@@ -1094,25 +1093,25 @@ static int bmg160_probe(struct i2c_client *client,
 					 bmg160_trigger_handler,
 					 &bmg160_buffer_setup_ops);
 	if (ret < 0) {
-		dev_err(&client->dev,
+		dev_err(dev,
 			"iio triggered buffer setup failed\n");
 		goto err_trigger_unregister;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
+		dev_err(dev, "unable to register iio device\n");
 		goto err_buffer_cleanup;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		goto err_iio_unregister;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev,
 					 BMG160_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_use_autosuspend(dev);
 
 	return 0;
 
-- 
2.1.4

