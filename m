Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler
Date: Mon, 16 Feb 2015 20:21:49 +0200
Message-Id: <1424110909-16878-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Adriana Reus <adriana.reus@intel.com>

Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
enable/disable the bus at each i2c transfer and must wait for
the enable/disable to happen before sending the data.

When reading data in the trigger handler, the kxcjk-1013 accel driver
does one i2c transfer for each axis. This has an impact on the
frequency of the accelerometer at high sample rates due to additional
delays introduced by the i2c bus at each transfer.

Reading all axis values in one i2c transfer reduces the delays
introduced by the i2c bus. In case i2c block read is not supported,
fallback to reading each axis as a separate word.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 44 +++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 5f27787..bfa2899 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -109,6 +109,8 @@ struct kxcjk1013_data {
 	int64_t timestamp;
 	enum kx_chipset chipset;
 	bool is_smo8500_device;
+	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
+			       u8 length, u8 *values);
 };
 
 enum kxcjk1013_axis {
@@ -216,6 +218,23 @@ static const struct {
 				 {800, 0, 0x06},
 				 {1600, 0, 0x06} };
 
+static s32 kxcjk1013_read_block_data(const struct i2c_client *client,
+				     u8 command, u8 length, u8 *values)
+{
+	s32 data;
+	u8 i;
+
+	for (i = 0; i < length; i += 2) {
+		data = i2c_smbus_read_word_data(client, command + i);
+		if (data < 0)
+			return data;
+
+		values[i] = data & 0xFF;
+		values[i+1] = data >> 8;
+	}
+	return i;
+}
+
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode mode)
 {
@@ -955,18 +974,14 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
-	int bit, ret, i = 0;
+	int ret;
 
 	mutex_lock(&data->mutex);
-	for (bit = 0; bit < AXIS_MAX; bit++) {
-		ret = kxcjk1013_get_acc_reg(data, bit);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			goto err;
-		}
-		data->buffer[i++] = ret;
-	}
+	ret = data->read_block_data(data->client, KXCJK1013_REG_XOUT_L,
+				    AXIS_MAX * 2, (u8 *) data->buffer);
 	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		goto err;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   data->timestamp);
@@ -1196,6 +1211,11 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	const char *name;
 	int ret;
 
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -ENODEV;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -1204,6 +1224,12 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
+	if (i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		data->read_block_data = i2c_smbus_read_i2c_block_data;
+	else
+		data->read_block_data = kxcjk1013_read_block_data;
+
 	pdata = dev_get_platdata(&client->dev);
 	if (pdata)
 		data->active_high_intr = pdata->active_high_intr;
-- 
1.9.1
