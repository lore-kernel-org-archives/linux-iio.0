Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: proximity: lidar: optimize i2c transactions
Date: Tue, 17 Nov 2015 22:11:27 -0800
Message-Id: <1447827087-4755-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Optimize device tranactions using i2c transfers versus multiple
possibly racey i2c_smbus_* function calls, and only one tranaction
for distance measurement.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++-----------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index e015a89..1df1a2f 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -36,8 +36,7 @@
 #define LIDAR_REG_STATUS_INVALID	BIT(3)
 #define LIDAR_REG_STATUS_READY		BIT(0)
 
-#define LIDAR_REG_DATA_HBYTE	0x0f
-#define LIDAR_REG_DATA_LBYTE	0x10
+#define LIDAR_REG_DATA		0x8f
 #define LIDAR_REG_PWR_CONTROL	0x65
 
 #define LIDAR_DRV_NAME "lidar"
@@ -64,9 +63,10 @@ static const struct iio_chan_spec lidar_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int lidar_read_byte(struct lidar_data *data, int reg)
+static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
 {
 	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2];
 	int ret;
 
 	/*
@@ -74,17 +74,31 @@ static int lidar_read_byte(struct lidar_data *data, int reg)
 	 * so in turn i2c_smbus_read_byte_data cannot be used
 	 */
 
-	ret = i2c_smbus_write_byte(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "cannot write addr value");
-		return ret;
-	}
+	msg[0].addr = client->addr;
+	msg[0].flags = client->flags | I2C_M_STOP;
+	msg[0].len = 1;
+	msg[0].buf  = (char *) &reg;
 
-	ret = i2c_smbus_read_byte(client);
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
+static int lidar_read_byte(struct lidar_data *data, u8 reg)
+{
+	int ret;
+	u8 val;
+
+	ret = lidar_i2c_xfer(data, reg, &val, 1);
 	if (ret < 0)
-		dev_err(&client->dev, "cannot read data value");
+		return ret;
 
-	return ret;
+	return val;
 }
 
 static inline int lidar_write_control(struct lidar_data *data, int val)
@@ -100,22 +114,12 @@ static inline int lidar_write_power(struct lidar_data *data, int val)
 
 static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
 {
-	int ret;
-	int val;
-
-	ret = lidar_read_byte(data, LIDAR_REG_DATA_HBYTE);
-	if (ret < 0)
-		return ret;
-	val = ret << 8;
+	int ret = lidar_i2c_xfer(data, LIDAR_REG_DATA, (u8 *) reg, 2);
 
-	ret = lidar_read_byte(data, LIDAR_REG_DATA_LBYTE);
-	if (ret < 0)
-		return ret;
-
-	val |= ret;
-	*reg = val;
+	if (!ret)
+		*reg = be16_to_cpu(*reg);
 
-	return 0;
+	return ret;
 }
 
 static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
-- 
1.9.1
