Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 2/2] iio: humidity: Add triggered buffer support for AM2315
Date: Mon, 18 Apr 2016 17:50:44 +0300
Message-Id: <1460991044-8484-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1460991044-8484-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1460991044-8484-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/humidity/am2315.c | 81 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index d392fc8..3be6d20 100644
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
@@ -26,12 +29,14 @@
 #define AM2315_FUNCTION_READ			0x03
 #define AM2315_HUM_OFFSET			2
 #define AM2315_TEMP_OFFSET			4
+#define AM2315_ALL_CHANNEL_MASK			GENMASK(1, 0)
 
 #define AM2315_DRIVER_NAME			"am2315"
 
 struct am2315_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	s16 buffer[8]; /* 2x16-bit channels + 2x16 padding + 4x16 timestamp */
 };
 
 struct am2315_sensor_data {
@@ -43,13 +48,28 @@ static const struct iio_chan_spec am2315_channels[] = {
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
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 /* CRC calculation algorithm, as specified in the datasheet (page 13). */
@@ -134,6 +154,44 @@ exit_unlock:
 	return ret;
 }
 
+static irqreturn_t am2315_trigger_handler(int irq, void *p)
+{
+	int i;
+	int ret;
+	int bit;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct am2315_data *data = iio_priv(indio_dev);
+	struct am2315_sensor_data sensor_data;
+
+	ret = am2315_read_data(data, &sensor_data);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		goto err;
+	}
+
+	mutex_lock(&data->lock);
+	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
+		data->buffer[0] = sensor_data.hum_data;
+		data->buffer[1] = sensor_data.temp_data;
+	} else {
+		i = 0;
+		for_each_set_bit(bit, indio_dev->active_scan_mask,
+				 indio_dev->masklength) {
+			data->buffer[i] = (bit ? sensor_data.temp_data :
+						 sensor_data.hum_data);
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
@@ -166,6 +224,7 @@ static const struct iio_info am2315_info = {
 static int am2315_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	int ret;
 	struct iio_dev *indio_dev;
 	struct am2315_data *data;
 
@@ -187,7 +246,22 @@ static int am2315_probe(struct i2c_client *client,
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
@@ -195,6 +269,7 @@ static int am2315_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 
 	return 0;
 }
-- 
1.9.1
