Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33452 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbbLACQv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2015 21:16:51 -0500
Received: by pabfh17 with SMTP id fh17so210407788pab.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2015 18:16:51 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 1/1] iio: proximity: lidar: optimize i2c transactions
Date: Mon, 30 Nov 2015 18:16:49 -0800
Message-Id: <1448936209-31656-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1448936209-31656-1-git-send-email-mranostay@gmail.com>
References: <1448936209-31656-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Optimize device tranactions using i2c transfers versus multiple
possibly racey i2c_smbus_* function calls, and only one transaction
for distance measurement. Falls back to smbus method if i2c
functionality isn't available.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 95 +++++++++++++++++------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 32f24f1..1cdcc5a 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -36,8 +36,10 @@
 #define LIDAR_REG_STATUS_INVALID	BIT(3)
 #define LIDAR_REG_STATUS_READY		BIT(0)
 
-#define LIDAR_REG_DATA_HBYTE	0x0f
-#define LIDAR_REG_DATA_LBYTE	0x10
+#define LIDAR_REG_DATA_HBYTE		0x0f
+#define LIDAR_REG_DATA_LBYTE		0x10
+#define LIDAR_REG_DATA_WORD_READ	BIT(7)
+
 #define LIDAR_REG_PWR_CONTROL	0x65
 
 #define LIDAR_DRV_NAME "lidar"
@@ -46,6 +48,9 @@ struct lidar_data {
 	struct iio_dev *indio_dev;
 	struct i2c_client *client;
 
+	int (*xfer)(struct lidar_data *data, u8 reg, u8 *val, int len);
+	int i2c_enabled;
+
 	u16 buffer[8]; /* 2 byte distance + 8 byte timestamp */
 };
 
@@ -64,7 +69,28 @@ static const struct iio_chan_spec lidar_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int lidar_read_byte(struct lidar_data *data, int reg)
+static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2];
+	int ret;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = client->flags | I2C_M_STOP;
+	msg[0].len = 1;
+	msg[0].buf  = (char *) &reg;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = client->flags | I2C_M_RD;
+	msg[1].len = len;
+	msg[1].buf = (char *) val;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+
+	return (ret == len) ? 0 : ret;
+}
+
+static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
 {
 	struct i2c_client *client = data->client;
 	int ret;
@@ -74,17 +100,35 @@ static int lidar_read_byte(struct lidar_data *data, int reg)
 	 * so in turn i2c_smbus_read_byte_data cannot be used
 	 */
 
-	ret = i2c_smbus_write_byte(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "cannot write addr value");
-		return ret;
+	while (len--) {
+		ret = i2c_smbus_write_byte(client, reg++);
+		if (ret < 0) {
+			dev_err(&client->dev, "cannot write addr value");
+			return ret;
+		}
+
+		ret = i2c_smbus_read_byte(client);
+		if (ret < 0) {
+			dev_err(&client->dev, "cannot read data value");
+			return ret;
+		}
+
+		*(val++) = ret;
 	}
 
-	ret = i2c_smbus_read_byte(client);
+	return 0;
+}
+
+static int lidar_read_byte(struct lidar_data *data, u8 reg)
+{
+	int ret;
+	u8 val;
+
+	ret = data->xfer(data, reg, &val, 1);
 	if (ret < 0)
-		dev_err(&client->dev, "cannot read data value");
+		return ret;
 
-	return ret;
+	return val;
 }
 
 static inline int lidar_write_control(struct lidar_data *data, int val)
@@ -100,22 +144,14 @@ static inline int lidar_write_power(struct lidar_data *data, int val)
 
 static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
 {
-	int ret;
-	int val;
-
-	ret = lidar_read_byte(data, LIDAR_REG_DATA_HBYTE);
-	if (ret < 0)
-		return ret;
-	val = ret << 8;
+	int ret = data->xfer(data, LIDAR_REG_DATA_HBYTE |
+			(data->i2c_enabled ? LIDAR_REG_DATA_WORD_READ : 0),
+			(u8 *) reg, 2);
 
-	ret = lidar_read_byte(data, LIDAR_REG_DATA_LBYTE);
-	if (ret < 0)
-		return ret;
+	if (!ret)
+		*reg = be16_to_cpu(*reg);
 
-	val |= ret;
-	*reg = val;
-
-	return 0;
+	return ret;
 }
 
 static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
@@ -237,6 +273,16 @@ static int lidar_probe(struct i2c_client *client,
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
+	data = iio_priv(indio_dev);
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		data->xfer = lidar_i2c_xfer;
+		data->i2c_enabled = 1;
+	} else if (i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
+		data->xfer = lidar_smbus_xfer;
+	else
+		return -ENOTSUPP;
 
 	indio_dev->info = &lidar_info;
 	indio_dev->name = LIDAR_DRV_NAME;
@@ -244,7 +290,6 @@ static int lidar_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(lidar_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
 	data->client = client;
-- 
1.9.1

