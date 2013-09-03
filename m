Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33386 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759212Ab3ICBFd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:33 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 11/18] staging:iio:hmc5843: Add trigger handling
Date: Tue,  3 Sep 2013 03:05:13 +0200
Message-Id: <1378170320-27538-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   84 +++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 8a152c7..131ab8d 100644
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
@@ -73,6 +76,9 @@ enum hmc5843_ids {
 #define HMC5843_MEAS_CONF_NOT_USED		0x03
 #define HMC5843_MEAS_CONF_MASK			0x03
 
+/* 3 16-bit channels + padding + timestamp = 16 bytes */
+#define HMC5843_BUFFER_SIZE 16
+
 /* Scaling factors: 10000000/Gain */
 static const int hmc5843_regval_to_nanoscale[] = {
 	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
@@ -174,6 +180,7 @@ struct hmc5843_data {
 	u8 operating_mode;
 	u8 range;
 	const struct hmc5843_chip_info *variant;
+	u16 *buffer;
 };
 
 /* The lower two bits contain the current conversion mode */
@@ -453,7 +460,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return hmc5843_read_measurement(data, chan->address, val);
+		return hmc5843_read_measurement(data, chan->scan_index, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = data->variant->regval_to_nanoscale[data->range];
@@ -509,6 +516,47 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static irqreturn_t hmc5843_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct hmc5843_data *data = iio_priv(indio_dev);
+	s64 time_ns = iio_get_time_ns();
+	int len = 0;
+	int i, j = 0;
+	s16 values[3];
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
+		HMC5843_DATA_OUT_MSB_REGS, sizeof(values), (u8 *) values);
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		goto done;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+		indio_dev->masklength) {
+		data->buffer[j++] = sign_extend32(be16_to_cpu(values[i]), 15);
+		len += 2;
+	}
+
+	if (indio_dev->scan_timestamp)
+		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
+			= time_ns;
+	iio_push_to_buffers(indio_dev, (u8 *)data->buffer);
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
@@ -518,13 +566,15 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
 			BIT(IIO_CHAN_INFO_CALIBSCALE),			\
-		.address = idx						\
+		.scan_index = idx,					\
+		.scan_type = IIO_ST('s', 16, 16, 0),			\
 	}
 
 static const struct iio_chan_spec hmc5843_channels[] = {
 	HMC5843_CHANNEL(X, 0),
 	HMC5843_CHANNEL(Y, 1),
 	HMC5843_CHANNEL(Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 /* Beware: Y and Z are exchanged on HMC5883 */
@@ -532,6 +582,7 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 	HMC5843_CHANNEL(X, 0),
 	HMC5843_CHANNEL(Z, 1),
 	HMC5843_CHANNEL(Y, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static struct attribute *hmc5843_attributes[] = {
@@ -588,7 +639,7 @@ static int hmc5843_probe(struct i2c_client *client,
 {
 	struct hmc5843_data *data;
 	struct iio_dev *indio_dev;
-	int err = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL)
@@ -598,6 +649,10 @@ static int hmc5843_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	data->variant = &hmc5843_chip_info_tbl[id->driver_data];
+	data->buffer = devm_kzalloc(&client->dev, HMC5843_BUFFER_SIZE,
+		GFP_KERNEL);
+	if (data->buffer == NULL)
+		return -ENOMEM;
 	mutex_init(&data->lock);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -606,20 +661,33 @@ static int hmc5843_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->variant->channels;
-	indio_dev->num_channels = 3;
+	indio_dev->num_channels = 4;
 
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
1.7.9.5

