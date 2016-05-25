Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35600 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbcEYE32 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 00:29:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id f144so4148789pfa.2
        for <linux-iio@vger.kernel.org>; Tue, 24 May 2016 21:29:27 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 1/3] iio: chemical: atlas-ph-sensor: reorg driver to allow multiple chips
Date: Tue, 24 May 2016 21:29:18 -0700
Message-Id: <1464150560-1186-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1464150560-1186-1-git-send-email-mranostay@gmail.com>
References: <1464150560-1186-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 145 ++++++++++++++++++++-------------
 1 file changed, 90 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 62b37cd..e85477c 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -24,6 +24,7 @@
 #include <linux/irq_work.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -43,20 +44,25 @@
 
 #define ATLAS_REG_PWR_CONTROL		0x06
 
-#define ATLAS_REG_CALIB_STATUS		0x0d
-#define ATLAS_REG_CALIB_STATUS_MASK	0x07
-#define ATLAS_REG_CALIB_STATUS_LOW	BIT(0)
-#define ATLAS_REG_CALIB_STATUS_MID	BIT(1)
-#define ATLAS_REG_CALIB_STATUS_HIGH	BIT(2)
+#define ATLAS_REG_PH_CALIB_STATUS	0x0d
+#define ATLAS_REG_PH_CALIB_STATUS_MASK	0x07
+#define ATLAS_REG_PH_CALIB_STATUS_LOW	BIT(0)
+#define ATLAS_REG_PH_CALIB_STATUS_MID	BIT(1)
+#define ATLAS_REG_PH_CALIB_STATUS_HIGH	BIT(2)
 
-#define ATLAS_REG_TEMP_DATA		0x0e
+#define ATLAS_REG_PH_TEMP_DATA		0x0e
 #define ATLAS_REG_PH_DATA		0x16
 
 #define ATLAS_PH_INT_TIME_IN_US		450000
 
+enum {
+	ATLAS_PH_SM,
+};
+
 struct atlas_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
+	struct atlas_device *chip;
 	struct regmap *regmap;
 	struct irq_work work;
 
@@ -84,9 +90,10 @@ static const struct regmap_config atlas_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static const struct iio_chan_spec atlas_channels[] = {
+static const struct iio_chan_spec atlas_ph_channels[] = {
 	{
 		.type = IIO_PH,
+		.address = ATLAS_REG_PH_DATA,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 0,
@@ -100,7 +107,7 @@ static const struct iio_chan_spec atlas_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 	{
 		.type = IIO_TEMP,
-		.address = ATLAS_REG_TEMP_DATA,
+		.address = ATLAS_REG_PH_TEMP_DATA,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.output = 1,
@@ -108,6 +115,52 @@ static const struct iio_chan_spec atlas_channels[] = {
 	},
 };
 
+static int atlas_check_ph_calibration(struct atlas_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, ATLAS_REG_PH_CALIB_STATUS, &val);
+	if (ret)
+		return ret;
+
+	if (!(val & ATLAS_REG_PH_CALIB_STATUS_MASK)) {
+		dev_warn(dev, "device has not been calibrated\n");
+		return 0;
+	}
+
+	if (!(val & ATLAS_REG_PH_CALIB_STATUS_LOW))
+		dev_warn(dev, "device missing low point calibration\n");
+
+	if (!(val & ATLAS_REG_PH_CALIB_STATUS_MID))
+		dev_warn(dev, "device missing mid point calibration\n");
+
+	if (!(val & ATLAS_REG_PH_CALIB_STATUS_HIGH))
+		dev_warn(dev, "device missing high point calibration\n");
+
+	return 0;
+}
+
+struct atlas_device {
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	int data_reg;
+
+	int (*calibration)(struct atlas_data *data);
+	int delay;
+};
+
+static struct atlas_device atlas_devices[] = {
+	[ATLAS_PH_SM] = {
+				.channels = atlas_ph_channels,
+				.num_channels = 3,
+				.data_reg = ATLAS_REG_PH_DATA,
+				.calibration = &atlas_check_ph_calibration,
+				.delay = ATLAS_PH_INT_TIME_IN_US,
+	},
+};
+
 static int atlas_set_powermode(struct atlas_data *data, int on)
 {
 	return regmap_write(data->regmap, ATLAS_REG_PWR_CONTROL, on);
@@ -178,8 +231,9 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, ATLAS_REG_PH_DATA,
-			      (u8 *) &data->buffer, sizeof(data->buffer[0]));
+	ret = regmap_bulk_read(data->regmap, data->chip->data_reg,
+			      (u8 *) &data->buffer,
+			      sizeof(__be32) * (data->chip->num_channels - 2));
 
 	if (!ret)
 		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
@@ -200,7 +254,7 @@ static irqreturn_t atlas_interrupt_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int atlas_read_ph_measurement(struct atlas_data *data, __be32 *val)
+static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
 {
 	struct device *dev = &data->client->dev;
 	int suspended = pm_runtime_suspended(dev);
@@ -213,11 +267,9 @@ static int atlas_read_ph_measurement(struct atlas_data *data, __be32 *val)
 	}
 
 	if (suspended)
-		usleep_range(ATLAS_PH_INT_TIME_IN_US,
-			     ATLAS_PH_INT_TIME_IN_US + 100000);
+		usleep_range(data->chip->delay, data->chip->delay + 100000);
 
-	ret = regmap_bulk_read(data->regmap, ATLAS_REG_PH_DATA,
-			      (u8 *) val, sizeof(*val));
+	ret = regmap_bulk_read(data->regmap, reg, (u8 *) val, sizeof(*val));
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -247,7 +299,8 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 			if (iio_buffer_enabled(indio_dev))
 				ret = -EBUSY;
 			else
-				ret = atlas_read_ph_measurement(data, &reg);
+				ret = atlas_read_measurement(data,
+							chan->address, &reg);
 
 			mutex_unlock(&indio_dev->mlock);
 			break;
@@ -303,37 +356,24 @@ static const struct iio_info atlas_info = {
 	.write_raw = atlas_write_raw,
 };
 
-static int atlas_check_calibration(struct atlas_data *data)
-{
-	struct device *dev = &data->client->dev;
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(data->regmap, ATLAS_REG_CALIB_STATUS, &val);
-	if (ret)
-		return ret;
-
-	if (!(val & ATLAS_REG_CALIB_STATUS_MASK)) {
-		dev_warn(dev, "device has not been calibrated\n");
-		return 0;
-	}
-
-	if (!(val & ATLAS_REG_CALIB_STATUS_LOW))
-		dev_warn(dev, "device missing low point calibration\n");
-
-	if (!(val & ATLAS_REG_CALIB_STATUS_MID))
-		dev_warn(dev, "device missing mid point calibration\n");
-
-	if (!(val & ATLAS_REG_CALIB_STATUS_HIGH))
-		dev_warn(dev, "device missing high point calibration\n");
+static const struct i2c_device_id atlas_id[] = {
+	{ "atlas-ph-sm", ATLAS_PH_SM},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, atlas_id);
 
-	return 0;
+static const struct of_device_id atlas_dt_ids[] = {
+	{ .compatible = "atlas,ph-sm", .data = (void *)ATLAS_PH_SM, },
+	{ }
 };
+MODULE_DEVICE_TABLE(of, atlas_dt_ids);
 
 static int atlas_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
 	struct atlas_data *data;
+	struct atlas_device *chip;
+	const struct of_device_id *of_id;
 	struct iio_trigger *trig;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -342,10 +382,16 @@ static int atlas_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
+	of_id = of_match_device(atlas_dt_ids, &client->dev);
+	if (!of_id)
+		chip = &atlas_devices[id->driver_data];
+	else
+		chip = &atlas_devices[(unsigned long)of_id->data];
+
 	indio_dev->info = &atlas_info;
 	indio_dev->name = ATLAS_DRV_NAME;
-	indio_dev->channels = atlas_channels;
-	indio_dev->num_channels = ARRAY_SIZE(atlas_channels);
+	indio_dev->channels = chip->channels;
+	indio_dev->num_channels = chip->num_channels;
 	indio_dev->modes = INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE;
 	indio_dev->dev.parent = &client->dev;
 
@@ -358,6 +404,7 @@ static int atlas_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	data->trig = trig;
+	data->chip = chip;
 	trig->dev.parent = indio_dev->dev.parent;
 	trig->ops = &atlas_interrupt_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
@@ -379,7 +426,7 @@ static int atlas_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	ret = atlas_check_calibration(data);
+	ret = chip->calibration(data);
 	if (ret)
 		return ret;
 
@@ -480,18 +527,6 @@ static const struct dev_pm_ops atlas_pm_ops = {
 			   atlas_runtime_resume, NULL)
 };
 
-static const struct i2c_device_id atlas_id[] = {
-	{ "atlas-ph-sm", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, atlas_id);
-
-static const struct of_device_id atlas_dt_ids[] = {
-	{ .compatible = "atlas,ph-sm" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, atlas_dt_ids);
-
 static struct i2c_driver atlas_driver = {
 	.driver = {
 		.name	= ATLAS_DRV_NAME,
-- 
2.7.4

