Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43363 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab3ISTgH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 19 Sep 2013 15:36:07 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 09/15] staging:iio:hmc5843: Add trigger handling
Date: Thu, 19 Sep 2013 21:35:54 +0200
Message-Id: <1379619360-8150-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v2 (thanks to Jonathan Cameron):
* drop dynamic buffer allocation, buffer is in hmc5842_data
* grab timestamp near data acquisition
* restrict available scan masks (only read all axis)

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 71 ++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index d2a5da1..41e2dc8 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -23,6 +23,9 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/delay.h>
 
 #define HMC5843_CONFIG_REG_A			0x00
@@ -174,6 +177,7 @@ struct hmc5843_data {
 	u8 operating_mode;
 	u8 range;
 	const struct hmc5843_chip_info *variant;
+	s16 buffer[8]; /* 3x 16-bit channels + padding + 64-bit timestamp */
 };
 
 /* The lower two bits contain the current conversion mode */
@@ -452,7 +456,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return hmc5843_read_measurement(data, chan->address, val);
+		return hmc5843_read_measurement(data, chan->scan_index, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = data->variant->regval_to_nanoscale[data->range];
@@ -508,6 +512,38 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static irqreturn_t hmc5843_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct hmc5843_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = hmc5843_wait_measurement(data);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		goto done;
+	}
+
+	ret = i2c_smbus_read_i2c_block_data(data->client,
+		HMC5843_DATA_OUT_MSB_REGS, 3 * sizeof(s16),
+			(u8 *) data->buffer);
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		goto done;
+
+	if (indio_dev->scan_timestamp)
+		*(s64 *)((u8 *)data->buffer + ALIGN(6, sizeof(s64)))
+			= iio_get_time_ns();
+	iio_push_to_buffers(indio_dev, data->buffer);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 #define HMC5843_CHANNEL(axis, idx)					\
 	{								\
 		.type = IIO_MAGN,					\
@@ -517,13 +553,15 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
 			BIT(IIO_CHAN_INFO_CALIBSCALE),			\
-		.address = idx						\
+		.scan_index = idx,					\
+		.scan_type = IIO_ST('s', 16, 16, IIO_BE),		\
 	}
 
 static const struct iio_chan_spec hmc5843_channels[] = {
 	HMC5843_CHANNEL(X, 0),
 	HMC5843_CHANNEL(Y, 1),
 	HMC5843_CHANNEL(Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 /* Beware: Y and Z are exchanged on HMC5883 */
@@ -531,6 +569,7 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 	HMC5843_CHANNEL(X, 0),
 	HMC5843_CHANNEL(Z, 1),
 	HMC5843_CHANNEL(Y, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static struct attribute *hmc5843_attributes[] = {
@@ -582,12 +621,14 @@ static const struct iio_info hmc5843_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const unsigned long hmc5843_scan_masks[] = {0x7, 0};
+
 static int hmc5843_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct hmc5843_data *data;
 	struct iio_dev *indio_dev;
-	int err = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL)
@@ -605,20 +646,34 @@ static int hmc5843_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->variant->channels;
-	indio_dev->num_channels = 3;
+	indio_dev->num_channels = 4;
+	indio_dev->available_scan_masks = hmc5843_scan_masks;
 
 	hmc5843_init(data);
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		return err;
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+		hmc5843_trigger_handler, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto buffer_cleanup;
 
 	return 0;
+
+buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+	return ret;
 }
 
 static int hmc5843_remove(struct i2c_client *client)
 {
-	iio_device_unregister(i2c_get_clientdata(client));
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+
 	 /*  sleep mode to save power */
 	hmc5843_configure(client, HMC5843_MODE_SLEEP);
 
-- 
1.8.4

