Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 45/50] staging:iio:magnetometer:ak8975: allocate chip state with iio_dev.
Date: Fri, 27 May 2011 19:36:25 +0100
Message-Id: <1306521390-24897-46-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Here the ordering is a little tricky, so to keep changes minimal, a copy of the gpio
number is introduced.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/magnetometer/ak8975.c |   91 +++++++++++++----------------
 1 files changed, 40 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 700f96c..33919e8 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -89,7 +89,6 @@
  */
 struct ak8975_data {
 	struct i2c_client	*client;
-	struct iio_dev		*indio_dev;
 	struct attribute_group	attrs;
 	struct mutex		lock;
 	u8			asa[3];
@@ -221,7 +220,7 @@ static ssize_t show_mode(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ak8975_data *data = indio_dev->dev_data;
+	struct ak8975_data *data = iio_priv(indio_dev);
 
 	return sprintf(buf, "%lu\n", data->mode);
 }
@@ -234,7 +233,7 @@ static ssize_t store_mode(struct device *dev, struct device_attribute *devattr,
 			  const char *buf, size_t count)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ak8975_data *data = indio_dev->dev_data;
+	struct ak8975_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 	unsigned long oval;
 	int ret;
@@ -310,7 +309,7 @@ static ssize_t show_scale(struct device *dev, struct device_attribute *devattr,
 			  char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ak8975_data *data = indio_dev->dev_data;
+	struct ak8975_data *data = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(devattr);
 
 	return sprintf(buf, "%ld\n", data->raw_to_gauss[this_attr->address]);
@@ -376,7 +375,7 @@ static ssize_t show_raw(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ak8975_data *data = indio_dev->dev_data;
+	struct ak8975_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(devattr);
 	u16 meas_reg;
@@ -483,46 +482,41 @@ static int ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ak8975_data *data;
+	struct iio_dev *indio_dev;
+	int eoc_gpio;
 	int err;
 
-	/* Allocate our device context. */
-	data = kzalloc(sizeof(struct ak8975_data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "Memory allocation fails\n");
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	i2c_set_clientdata(client, data);
-	data->client = client;
-
-	mutex_init(&data->lock);
-
 	/* Grab and set up the supplied GPIO. */
-	data->eoc_irq = client->irq;
-	data->eoc_gpio = irq_to_gpio(client->irq);
+	eoc_gpio = irq_to_gpio(client->irq);
 
 	/* We may not have a GPIO based IRQ to scan, that is fine, we will
 	   poll if so */
-	if (data->eoc_gpio > 0) {
-		err = gpio_request(data->eoc_gpio, "ak_8975");
+	if (eoc_gpio > 0) {
+		err = gpio_request(eoc_gpio, "ak_8975");
 		if (err < 0) {
 			dev_err(&client->dev,
 				"failed to request GPIO %d, error %d\n",
-							data->eoc_gpio, err);
-			goto exit_free;
+							eoc_gpio, err);
+			goto exit;
 		}
 
-		err = gpio_direction_input(data->eoc_gpio);
+		err = gpio_direction_input(eoc_gpio);
 		if (err < 0) {
 			dev_err(&client->dev,
 				"Failed to configure input direction for GPIO %d, error %d\n",
-						data->eoc_gpio, err);
+						eoc_gpio, err);
 			goto exit_gpio;
 		}
 	} else
-		data->eoc_gpio = 0;	/* No GPIO available */
+		eoc_gpio = 0;	/* No GPIO available */
 
+	/* Register with IIO */
+	indio_dev = iio_allocate_device(sizeof(*data));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto exit_gpio;
+	}
+	data = iio_priv(indio_dev);
 	/* Perform some basic start-of-day setup of the device. */
 	err = ak8975_setup(client);
 	if (err < 0) {
@@ -530,46 +524,41 @@ static int ak8975_probe(struct i2c_client *client,
 		goto exit_gpio;
 	}
 
-	/* Register with IIO */
-	data->indio_dev = iio_allocate_device(0);
-	if (data->indio_dev == NULL) {
-		err = -ENOMEM;
-		goto exit_gpio;
-	}
-
-	data->indio_dev->dev.parent = &client->dev;
-	data->indio_dev->info = &ak8975_info;
-	data->indio_dev->dev_data = (void *)(data);
-	data->indio_dev->modes = INDIO_DIRECT_MODE;
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+	data->eoc_irq = client->irq;
+	data->eoc_gpio = eoc_gpio;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ak8975_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	err = iio_device_register(data->indio_dev);
+	err = iio_device_register(indio_dev);
 	if (err < 0)
 		goto exit_free_iio;
 
 	return 0;
 
 exit_free_iio:
-	iio_free_device(data->indio_dev);
+	iio_free_device(indio_dev);
 exit_gpio:
-	if (data->eoc_gpio)
-		gpio_free(data->eoc_gpio);
-exit_free:
-	kfree(data);
+	if (eoc_gpio)
+		gpio_free(eoc_gpio);
 exit:
 	return err;
 }
 
 static int ak8975_remove(struct i2c_client *client)
 {
-	struct ak8975_data *data = i2c_get_clientdata(client);
-
-	iio_device_unregister(data->indio_dev);
-	iio_free_device(data->indio_dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ak8975_data *data = iio_priv(indio_dev);
+	int eoc_gpio = data->eoc_gpio;
 
-	if (data->eoc_gpio)
-		gpio_free(data->eoc_gpio);
+	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
-	kfree(data);
+	if (eoc_gpio)
+		gpio_free(eoc_gpio);
 
 	return 0;
 }
-- 
1.7.3.4
