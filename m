Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 2/2] iio: gyro: bmg160: optimize i2c transfers in trigger handler
Date: Mon, 16 Feb 2015 20:14:10 +0200
Message-Id: <1424110450-16398-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1424110450-16398-1-git-send-email-irina.tirdea@intel.com>
References: <1424110450-16398-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
enable/disable the bus at each i2c transfer and must wait for
the enable/disable to happen before sending the data.

When reading data in the trigger handler, the bmg160 driver does
one i2c transfer for each axis. This has an impact on the frequency
of the gyroscope at high sample rates due to additional delays
introduced by the i2c bus at each transfer.

Reading all axis values in one i2c transfer reduces the delays
introduced by the i2c bus. In case i2c block read is not supported,
fallback to reading each axis as a separate word.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/bmg160.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 6ccf333..9720cd6 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -109,6 +109,8 @@ struct bmg160_data {
 	bool dready_trigger_on;
 	bool motion_trigger_on;
 	int64_t timestamp;
+	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
+			       u8 length, u8 *values);
 };
 
 enum bmg160_axis {
@@ -136,6 +138,23 @@ static const struct {
 			   { 133, BMG160_RANGE_250DPS},
 			   { 66, BMG160_RANGE_125DPS} };
 
+static s32 bmg160_read_block_data(const struct i2c_client *client,
+				  u8 command, u8 length, u8 *values)
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
 static int bmg160_set_mode(struct bmg160_data *data, u8 mode)
 {
 	int ret;
@@ -822,19 +841,14 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmg160_data *data = iio_priv(indio_dev);
-	int bit, ret, i = 0;
+	int ret;
 
 	mutex_lock(&data->mutex);
-	for (bit = 0; bit < AXIS_MAX; bit++)
-		ret = i2c_smbus_read_word_data(data->client,
-					       BMG160_AXIS_TO_REG(bit));
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			goto err;
-		}
-		data->buffer[i++] = ret;
-	}
+	ret = data->read_block_data(data->client, BMG160_REG_XOUT_L,
+				    AXIS_MAX * 2, (u8 *) data->buffer);
 	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		goto err;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   data->timestamp);
@@ -1039,6 +1053,11 @@ static int bmg160_probe(struct i2c_client *client,
 	int ret;
 	const char *name = NULL;
 
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -ENODEV;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -1051,6 +1070,12 @@ static int bmg160_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	if (i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		data->read_block_data = i2c_smbus_read_i2c_block_data;
+	else
+		data->read_block_data = bmg160_read_block_data;
+
 	mutex_init(&data->mutex);
 
 	if (id)
-- 
1.9.1
