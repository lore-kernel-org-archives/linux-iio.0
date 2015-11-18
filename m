Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: chemical: vz89x: rework i2c transfer reading
Date: Tue, 17 Nov 2015 17:49:49 -0800
Message-Id: <1447811389-28509-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove racey i2c_smbus_read_byte() calls in measurement
reading function with an single i2c_transfer.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 11e59a5..c03f988 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -100,27 +100,40 @@ static int vz89x_measurement_is_valid(struct vz89x_data *data)
 	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
 }
 
+static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2];
+	int ret;
+	u8 buf[3] = { cmd, 0, 0};
+
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
+
+	return (ret == VZ89X_REG_MEASUREMENT_SIZE) ? 0 : ret;
+}
+
 static int vz89x_get_measurement(struct vz89x_data *data)
 {
 	int ret;
-	int i;
 
 	/* sensor can only be polled once a second max per datasheet */
 	if (!time_after(jiffies, data->last_update + HZ))
 		return 0;
 
-	ret = i2c_smbus_write_word_data(data->client,
-					VZ89X_REG_MEASUREMENT, 0);
+	ret = vz89x_i2c_xfer(data, VZ89X_REG_MEASUREMENT);
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
-		ret = i2c_smbus_read_byte(data->client);
-		if (ret < 0)
-			return ret;
-		data->buffer[i] = ret;
-	}
-
 	ret = vz89x_measurement_is_valid(data);
 	if (ret)
 		return -EAGAIN;
-- 
1.9.1
