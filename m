Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36438 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbcHWDpE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2016 23:45:04 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so9107871pab.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Aug 2016 20:45:03 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 1/3] iio: chemical: vz89x: abstract chip configuration
Date: Mon, 22 Aug 2016 20:44:52 -0700
Message-Id: <1471923894-12194-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
References: <1471923894-12194-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Abstract chip configuration data to allow supporting multiple variants
of the VZ89 chemical sensor line.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 652649da500f..f498228e044d 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -31,12 +31,21 @@
 #define VZ89X_VOC_TVOC_IDX		2
 #define VZ89X_VOC_RESISTANCE_IDX	3
 
+enum {
+	VZ89X,
+};
+
 struct vz89x_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	int (*xfer)(struct vz89x_data *data, u8 cmd);
+	int (*valid)(struct vz89x_data *data);
 
 	unsigned long last_update;
+	u8 cmd;
+	u8 write_size;
+	u8 read_size;
+
 	u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
 };
 
@@ -98,7 +107,7 @@ static int vz89x_measurement_is_valid(struct vz89x_data *data)
 	if (data->buffer[VZ89X_VOC_SHORT_IDX] == 0)
 		return 1;
 
-	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
+	return !!(data->buffer[data->read_size - 1] > 0);
 }
 
 static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
@@ -110,12 +119,12 @@ static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
 
 	msg[0].addr = client->addr;
 	msg[0].flags = client->flags;
-	msg[0].len = 3;
+	msg[0].len = data->write_size;
 	msg[0].buf  = (char *) &buf;
 
 	msg[1].addr = client->addr;
 	msg[1].flags = client->flags | I2C_M_RD;
-	msg[1].len = VZ89X_REG_MEASUREMENT_SIZE;
+	msg[1].len = data->read_size;
 	msg[1].buf = (char *) &data->buffer;
 
 	ret = i2c_transfer(client->adapter, msg, 2);
@@ -133,7 +142,7 @@ static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
+	for (i = 0; i < data->read_size; i++) {
 		ret = i2c_smbus_read_byte(client);
 		if (ret < 0)
 			return ret;
@@ -151,11 +160,11 @@ static int vz89x_get_measurement(struct vz89x_data *data)
 	if (!time_after(jiffies, data->last_update + HZ))
 		return 0;
 
-	ret = data->xfer(data, VZ89X_REG_MEASUREMENT);
+	ret = data->xfer(data, data->cmd);
 	if (ret < 0)
 		return ret;
 
-	ret = vz89x_measurement_is_valid(data);
+	ret = data->valid(data);
 	if (ret)
 		return -EAGAIN;
 
@@ -254,6 +263,10 @@ static int vz89x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	data->last_update = jiffies - HZ;
+	data->cmd = VZ89X_REG_MEASUREMENT;
+	data->write_size = 3;
+	data->read_size = VZ89X_REG_MEASUREMENT_SIZE;
+	data->valid = &vz89x_measurement_is_valid;
 	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
@@ -268,13 +281,13 @@ static int vz89x_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id vz89x_id[] = {
-	{ "vz89x", 0 },
+	{ "vz89x", VZ89X },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vz89x_id);
 
 static const struct of_device_id vz89x_dt_ids[] = {
-	{ .compatible = "sgx,vz89x" },
+	{ .compatible = "sgx,vz89x", .data = (void *) VZ89X },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
-- 
2.7.4

