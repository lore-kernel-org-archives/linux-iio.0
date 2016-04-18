Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 2/2] iio: humidity: Add triggered buffer support for AM2315
Date: Mon, 18 Apr 2016 12:42:23 +0300
Message-Id: <1460972543-27175-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1460972543-27175-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1460972543-27175-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/humidity/am2315.c | 83 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index c374078..2fbef6a 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -15,8 +15,11 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define AM2315_REG_HUM_MSB			0x00
 #define AM2315_REG_HUM_LSB			0x01
@@ -26,24 +29,43 @@
 #define AM2315_FUNCTION_READ			0x03
 #define AM2315_HUM_OFFSET			0
 #define AM2315_TEMP_OFFSET			2
+#define AM2315_ALL_CHANNEL_MASK			GENMASK(1, 0)
 
 #define AM2315_DRIVER_NAME			"am2315"
 
 struct am2315_data {
 	struct i2c_client *client;
+	struct mutex lock;
+	s16 buffer[8]; /* 2x16-bit channels + 2x16 padding + 4x16 timestamp */
 };
 
 static const struct iio_chan_spec am2315_channels[] = {
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE)
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE)
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+
 	},
+		IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 /* CRC calculation algorithm, as specified in the datasheet (page 13). */
@@ -109,6 +131,43 @@ static int am2315_read_data(struct i2c_client *client, u8 *rx_buf)
 	return ret;
 }
 
+static irqreturn_t am2315_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct am2315_data *data = iio_priv(indio_dev);
+	int ret;
+	int bit;
+	int i;
+	u8 rx_buf[8];
+
+	mutex_lock(&data->lock);
+	ret = am2315_read_data(data->client, rx_buf);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		goto err;
+	}
+	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
+		data->buffer[0] = (rx_buf[2] << 8) | rx_buf[3];
+		data->buffer[1] = (rx_buf[4] << 8) | rx_buf[5];
+	} else {
+		i = 0;
+		for_each_set_bit(bit, indio_dev->active_scan_mask,
+				 indio_dev->masklength) {
+			data->buffer[i] = (rx_buf[(bit * 2) + 2] << 8) |
+					   rx_buf[(bit * 2) + 3];
+			i++;
+		}
+	}
+	mutex_unlock(&data->lock);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+					   pf->timestamp);
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int am2315_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -151,6 +210,7 @@ static const struct iio_info am2315_info = {
 static int am2315_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	int ret;
 	struct iio_dev *indio_dev;
 	struct am2315_data *data;
 
@@ -163,6 +223,7 @@ static int am2315_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	i2c_set_clientdata(client, indio_dev);
+	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &am2315_info;
@@ -171,7 +232,22 @@ static int am2315_probe(struct i2c_client *client,
 	indio_dev->channels = am2315_channels;
 	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
 
-	return iio_device_register(indio_dev);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+					 am2315_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto err_buffer_cleanup;
+
+	return 0;
+
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+	return ret;
 }
 
 static int am2315_remove(struct i2c_client *client)
@@ -179,6 +255,7 @@ static int am2315_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 
 	return 0;
 }
-- 
1.9.1
