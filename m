Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 47/50] staging:iio:magnetometer:hmc5843: allocate device state with iio_dev.
Date: Fri, 27 May 2011 19:36:27 +0100
Message-Id: <1306521390-24897-48-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   50 ++++++++++++----------------
 1 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index dd9a3bb..b44c273a 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -131,7 +131,6 @@ static const unsigned short normal_i2c[] = { HMC5843_I2C_ADDRESS,
 
 /* Each client has this additional data */
 struct hmc5843_data {
-	struct iio_dev	*indio_dev;
 	struct mutex lock;
 	u8		rate;
 	u8		meas_conf;
@@ -159,7 +158,7 @@ static ssize_t hmc5843_read_measurement(struct device *dev,
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	s16 coordinate_val;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	s32 result;
 
 	mutex_lock(&data->lock);
@@ -202,7 +201,7 @@ static ssize_t hmc5843_show_operating_mode(struct device *dev,
 					char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	return sprintf(buf, "%d\n", data->operating_mode);
 }
 
@@ -213,7 +212,7 @@ static ssize_t hmc5843_set_operating_mode(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned long operating_mode = 0;
 	s32 status;
@@ -278,7 +277,7 @@ static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
 						char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	return sprintf(buf, "%d\n", data->meas_conf);
 }
 
@@ -350,7 +349,7 @@ static ssize_t set_sampling_frequency(struct device *dev,
 
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	unsigned long rate = 0;
 
 	if (strncmp(buf, "0.5" , 3) == 0)
@@ -422,7 +421,7 @@ static ssize_t show_range(struct device *dev,
 {
 	u8 range;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 
 	range = data->range;
 	return sprintf(buf, "%d\n", regval_to_input_field_mg[range]);
@@ -436,7 +435,7 @@ static ssize_t set_range(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	unsigned long range = 0;
 	int error;
 	mutex_lock(&data->lock);
@@ -473,7 +472,7 @@ static ssize_t show_scale(struct device *dev,
 			char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct hmc5843_data *data = indio_dev->dev_data;
+	struct hmc5843_data *data = iio_priv(indio_dev);
 	return strlen(strcpy(buf, regval_to_scale[data->range]));
 }
 static IIO_DEVICE_ATTR(magn_scale,
@@ -538,53 +537,46 @@ static int hmc5843_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct hmc5843_data *data;
+	struct iio_dev *indio_dev;
 	int err = 0;
 
-	data = kzalloc(sizeof(struct hmc5843_data), GFP_KERNEL);
-	if (!data) {
+	indio_dev = iio_allocate_device(sizeof(*data));
+	if (indio_dev == NULL) {
 		err = -ENOMEM;
 		goto exit;
 	}
-
+	data = iio_priv(indio_dev);
 	/* default settings at probe */
 
 	data->meas_conf = CONF_NORMAL;
 	data->range = RANGE_1_0;
 	data->operating_mode = MODE_CONVERSION_CONTINUOUS;
 
-	i2c_set_clientdata(client, data);
+	i2c_set_clientdata(client, indio_dev);
 
 	/* Initialize the HMC5843 chip */
 	hmc5843_init_client(client);
 
-	data->indio_dev = iio_allocate_device(0);
-	if (!data->indio_dev) {
-		err = -ENOMEM;
-		goto exit_free1;
-	}
-	data->indio_dev->info = &hmc5843_info;
-	data->indio_dev->dev.parent = &client->dev;
-	data->indio_dev->dev_data = (void *)(data);
-	data->indio_dev->modes = INDIO_DIRECT_MODE;
-	err = iio_device_register(data->indio_dev);
+	indio_dev->info = &hmc5843_info;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	err = iio_device_register(indio_dev);
 	if (err)
 		goto exit_free2;
 	return 0;
 exit_free2:
-	iio_free_device(data->indio_dev);
-exit_free1:
-	kfree(data);
+	iio_free_device(indio_dev);
 exit:
 	return err;
 }
 
 static int hmc5843_remove(struct i2c_client *client)
 {
-	struct hmc5843_data *data = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	 /*  sleep mode to save power */
 	hmc5843_configure(client, MODE_SLEEP);
-	iio_device_unregister(data->indio_dev);
-	kfree(i2c_get_clientdata(client));
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
-- 
1.7.3.4
