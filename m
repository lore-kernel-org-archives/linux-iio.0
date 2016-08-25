Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35186 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbcHYGpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2016 02:45:40 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so2567152pad.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Aug 2016 23:44:56 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 1/4] iio: chemical: vz89x: abstract chip configuration
Date: Wed, 24 Aug 2016 23:44:47 -0700
Message-Id: <1472107490-11924-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
References: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Abstract chip configuration data to allow supporting multiple variants
of the VZ89 chemical sensor line.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 80 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 652649da500f..aa6ebc084e19 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -19,25 +19,45 @@
 #include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
 #define VZ89X_REG_MEASUREMENT		0x09
-#define VZ89X_REG_MEASUREMENT_SIZE	6
+#define VZ89X_REG_MEASUREMENT_RD_SIZE	6
+#define VZ89X_REG_MEASUREMENT_WR_SIZE	3
 
 #define VZ89X_VOC_CO2_IDX		0
 #define VZ89X_VOC_SHORT_IDX		1
 #define VZ89X_VOC_TVOC_IDX		2
 #define VZ89X_VOC_RESISTANCE_IDX	3
 
+enum {
+	VZ89X,
+};
+
+struct vz89x_chip_data;
+
 struct vz89x_data {
 	struct i2c_client *client;
+	const struct vz89x_chip_data *chip;
 	struct mutex lock;
 	int (*xfer)(struct vz89x_data *data, u8 cmd);
 
 	unsigned long last_update;
-	u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
+	u8 buffer[VZ89X_REG_MEASUREMENT_RD_SIZE];
+};
+
+struct vz89x_chip_data {
+	bool (*valid)(struct vz89x_data *data);
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+
+	u8 cmd;
+	u8 read_size;
+	u8 write_size;
 };
 
 static const struct iio_chan_spec vz89x_channels[] = {
@@ -93,16 +113,17 @@ static const struct attribute_group vz89x_attrs_group = {
  * always zero, and by also confirming the VOC_short isn't zero.
  */
 
-static int vz89x_measurement_is_valid(struct vz89x_data *data)
+static bool vz89x_measurement_is_valid(struct vz89x_data *data)
 {
 	if (data->buffer[VZ89X_VOC_SHORT_IDX] == 0)
 		return 1;
 
-	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
+	return !!(data->buffer[data->chip->read_size - 1] > 0);
 }
 
 static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
 {
+	const struct vz89x_chip_data *chip = data->chip;
 	struct i2c_client *client = data->client;
 	struct i2c_msg msg[2];
 	int ret;
@@ -110,12 +131,12 @@ static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
 
 	msg[0].addr = client->addr;
 	msg[0].flags = client->flags;
-	msg[0].len = 3;
+	msg[0].len = chip->write_size;
 	msg[0].buf  = (char *) &buf;
 
 	msg[1].addr = client->addr;
 	msg[1].flags = client->flags | I2C_M_RD;
-	msg[1].len = VZ89X_REG_MEASUREMENT_SIZE;
+	msg[1].len = chip->read_size;
 	msg[1].buf = (char *) &data->buffer;
 
 	ret = i2c_transfer(client->adapter, msg, 2);
@@ -133,7 +154,7 @@ static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
+	for (i = 0; i < data->chip->read_size; i++) {
 		ret = i2c_smbus_read_byte(client);
 		if (ret < 0)
 			return ret;
@@ -145,17 +166,18 @@ static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
 
 static int vz89x_get_measurement(struct vz89x_data *data)
 {
+	const struct vz89x_chip_data *chip = data->chip;
 	int ret;
 
 	/* sensor can only be polled once a second max per datasheet */
 	if (!time_after(jiffies, data->last_update + HZ))
 		return 0;
 
-	ret = data->xfer(data, VZ89X_REG_MEASUREMENT);
+	ret = data->xfer(data, chip->cmd);
 	if (ret < 0)
 		return ret;
 
-	ret = vz89x_measurement_is_valid(data);
+	ret = chip->valid(data);
 	if (ret)
 		return -EAGAIN;
 
@@ -232,11 +254,32 @@ static const struct iio_info vz89x_info = {
 	.driver_module	= THIS_MODULE,
 };
 
+static const struct vz89x_chip_data vz89x_chips[] = {
+	{
+		.valid = vz89x_measurement_is_valid,
+
+		.cmd = VZ89X_REG_MEASUREMENT,
+		.read_size = VZ89X_REG_MEASUREMENT_RD_SIZE,
+		.write_size = VZ89X_REG_MEASUREMENT_WR_SIZE,
+
+		.channels = vz89x_channels,
+		.num_channels = ARRAY_SIZE(vz89x_channels),
+	},
+};
+
+static const struct of_device_id vz89x_dt_ids[] = {
+	{ .compatible = "sgx,vz89x", .data = (void *) VZ89X },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
+
 static int vz89x_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
 	struct iio_dev *indio_dev;
 	struct vz89x_data *data;
+	const struct of_device_id *of_id;
+	int chip_id;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -251,8 +294,15 @@ static int vz89x_probe(struct i2c_client *client,
 	else
 		return -EOPNOTSUPP;
 
+	of_id = of_match_device(vz89x_dt_ids, &client->dev);
+	if (!of_id)
+		chip_id = id->driver_data;
+	else
+		chip_id = (unsigned long)of_id->data;
+
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->chip = &vz89x_chips[chip_id];
 	data->last_update = jiffies - HZ;
 	mutex_init(&data->lock);
 
@@ -261,24 +311,18 @@ static int vz89x_probe(struct i2c_client *client,
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	indio_dev->channels = vz89x_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vz89x_channels);
+	indio_dev->channels = data->chip->channels;
+	indio_dev->num_channels = data->chip->num_channels;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id vz89x_id[] = {
-	{ "vz89x", 0 },
+	{ "vz89x", VZ89X },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vz89x_id);
 
-static const struct of_device_id vz89x_dt_ids[] = {
-	{ .compatible = "sgx,vz89x" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
-
 static struct i2c_driver vz89x_driver = {
 	.driver = {
 		.name	= "vz89x",
-- 
2.7.4

