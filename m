Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33008 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbLBFr0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 00:47:26 -0500
Received: by pabfh17 with SMTP id fh17so30724553pab.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2015 21:47:26 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 1/1] iio: chemical: vz89x: rework i2c transfer reading
Date: Tue,  1 Dec 2015 21:47:20 -0800
Message-Id: <1449035240-31044-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1449035240-31044-1-git-send-email-mranostay@gmail.com>
References: <1449035240-31044-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add an optimized i2c transfer reading function, and fallback
to racey smbus transfers if client->adapter doesn't support this.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 11e59a5..b8b8049 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -34,8 +34,9 @@
 struct vz89x_data {
 	struct i2c_client *client;
 	struct mutex lock;
-	unsigned long last_update;
+	int (*xfer)(struct vz89x_data *data, u8 cmd);
 
+	unsigned long last_update;
 	u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
 };
 
@@ -100,27 +101,60 @@ static int vz89x_measurement_is_valid(struct vz89x_data *data)
 	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
 }
 
-static int vz89x_get_measurement(struct vz89x_data *data)
+static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
 {
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2];
 	int ret;
-	int i;
+	u8 buf[3] = { cmd, 0, 0};
 
-	/* sensor can only be polled once a second max per datasheet */
-	if (!time_after(jiffies, data->last_update + HZ))
-		return 0;
+	msg[0].addr = client->addr;
+	msg[0].flags = client->flags;
+	msg[0].len = 3;
+	msg[0].buf  = (char *) &buf;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = client->flags | I2C_M_RD;
+	msg[1].len = VZ89X_REG_MEASUREMENT_SIZE;
+	msg[1].buf = (char *) &data->buffer;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
 
-	ret = i2c_smbus_write_word_data(data->client,
-					VZ89X_REG_MEASUREMENT, 0);
+	return (ret == 2) ? 0 : ret;
+}
+
+static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+	int i;
+
+	ret = i2c_smbus_write_word_data(client, cmd, 0);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
-		ret = i2c_smbus_read_byte(data->client);
+		ret = i2c_smbus_read_byte(client);
 		if (ret < 0)
 			return ret;
 		data->buffer[i] = ret;
 	}
 
+	return 0;
+}
+
+static int vz89x_get_measurement(struct vz89x_data *data)
+{
+	int ret;
+
+	/* sensor can only be polled once a second max per datasheet */
+	if (!time_after(jiffies, data->last_update + HZ))
+		return 0;
+
+	ret = data->xfer(data, VZ89X_REG_MEASUREMENT);
+	if (ret < 0)
+		return ret;
+
 	ret = vz89x_measurement_is_valid(data);
 	if (ret)
 		return -EAGAIN;
@@ -204,15 +238,19 @@ static int vz89x_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct vz89x_data *data;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
-				     I2C_FUNC_SMBUS_BYTE))
-		return -ENODEV;
-
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
-
 	data = iio_priv(indio_dev);
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		data->xfer = vz89x_i2c_xfer;
+	else if (i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
+		data->xfer = vz89x_smbus_xfer;
+	else
+		return -ENOTSUPP;
+
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	data->last_update = jiffies - HZ;
-- 
1.9.1

