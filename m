Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 26/50] staging:iio:dac:max517: allocate chip state with iio_dev and use iio_priv to access it.
Date: Fri, 27 May 2011 19:36:06 +0100
Message-Id: <1306521390-24897-27-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/max517.c |   42 +++++++++++++------------------------
 1 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 881768d..ed5d351 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -59,7 +59,7 @@ static ssize_t max517_set_value(struct device *dev,
 				 const char *buf, size_t count, int channel)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max517_data *data = iio_dev_get_devdata(dev_info);
+	struct max517_data *data = iio_priv(dev_info);
 	struct i2c_client *client = data->client;
 	u8 outbuf[4]; /* 1x or 2x command + value */
 	int outbuf_size = 0;
@@ -127,7 +127,7 @@ static ssize_t max517_show_scale(struct device *dev,
 				char *buf, int channel)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max517_data *data = iio_dev_get_devdata(dev_info);
+	struct max517_data *data = iio_priv(dev_info);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (data->vref_mv[channel - 1] * 1000) >> 8;
 
@@ -195,7 +195,7 @@ static const struct iio_info max517_info = {
 };
 
 static const struct iio_info max518_info = {
-	.attrs = &max517_attribute_group,
+	.attrs = &max518_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -203,35 +203,28 @@ static int max517_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct max517_data *data;
+	struct iio_dev *indio_dev;
 	struct max517_platform_data *platform_data = client->dev.platform_data;
 	int err;
 
-	data = kzalloc(sizeof(struct max517_data), GFP_KERNEL);
-	if (!data) {
+	indio_dev = iio_allocate_device(sizeof(*data));
+	if (indio_dev == NULL) {
 		err = -ENOMEM;
 		goto exit;
 	}
-
-	i2c_set_clientdata(client, data);
-
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	data->indio_dev = iio_allocate_device(0);
-	if (data->indio_dev == NULL) {
-		err = -ENOMEM;
-		goto exit_free_data;
-	}
-
 	/* establish that the iio_dev is a child of the i2c device */
-	data->indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.parent = &client->dev;
 
 	/* reduced attribute set for MAX517 */
 	if (id->driver_data == ID_MAX517)
-		data->indio_dev->info = &max517_info;
+		indio_dev->info = &max517_info;
 	else
-		data->indio_dev->info = &max518_info;
-	data->indio_dev->dev_data = (void *)(data);
-	data->indio_dev->modes = INDIO_DIRECT_MODE;
+		indio_dev->info = &max518_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/*
 	 * Reference voltage on MAX518 and default is 5V, else take vref_mv
@@ -244,7 +237,7 @@ static int max517_probe(struct i2c_client *client,
 		data->vref_mv[1] = platform_data->vref_mv[1];
 	}
 
-	err = iio_device_register(data->indio_dev);
+	err = iio_device_register(indio_dev);
 	if (err)
 		goto exit_free_device;
 
@@ -253,19 +246,14 @@ static int max517_probe(struct i2c_client *client,
 	return 0;
 
 exit_free_device:
-	iio_free_device(data->indio_dev);
-exit_free_data:
-	kfree(data);
+	iio_free_device(indio_dev);
 exit:
 	return err;
 }
 
 static int max517_remove(struct i2c_client *client)
 {
-	struct max517_data *data = i2c_get_clientdata(client);
-
-	iio_free_device(data->indio_dev);
-	kfree(data);
+	iio_free_device(i2c_get_clientdata(client));
 
 	return 0;
 }
-- 
1.7.3.4
