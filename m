Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:37994 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752515Ab1A2Pgv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jan 2011 10:36:51 -0500
From: stigge@antcom.de
To: linux-iio@vger.kernel.org, greg@kroah.com
Cc: Roland Stigge <stigge@antcom.de>
Subject: [PATCH] max517.c: Fix client obtainment by using iio_dev_get_devdata()
Date: Sat, 29 Jan 2011 16:36:46 +0100
Message-Id: <1296315406-28392-1-git-send-email-stigge@antcom.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

max517.c: Fix client obtainment by using iio_dev_get_devdata()

This patch uses dev_get_drvdata() and iio_dev_get_devdata() instead of
to_i2c_client() (broken!) to obtain i2c_client data.

Further, some minor typo fixes are included.

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 4974e70..7071f71 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -45,6 +45,7 @@ enum max517_device_ids {
 
 struct max517_data {
 	struct iio_dev		*indio_dev;
+	struct i2c_client	*client;
 	unsigned short		vref_mv[2];
 };
 
@@ -57,7 +58,9 @@ static ssize_t max517_set_value(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count, int channel)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max517_data *data = iio_dev_get_devdata(dev_info);
+	struct i2c_client *client = data->client;
 	u8 outbuf[4]; /* 1x or 2x command + value */
 	int outbuf_size = 0;
 	int res;
@@ -147,7 +150,7 @@ static ssize_t max517_show_scale2(struct device *dev,
 }
 static IIO_DEVICE_ATTR(out2_scale, S_IRUGO, max517_show_scale2, NULL, 0);
 
-/* On MAX517 variant, we have two outputs */
+/* On MAX517 variant, we have one output */
 static struct attribute *max517_attributes[] = {
 	&iio_dev_attr_out1_raw.dev_attr.attr,
 	&iio_dev_attr_out1_scale.dev_attr.attr,
@@ -158,7 +161,7 @@ static struct attribute_group max517_attribute_group = {
 	.attrs = max517_attributes,
 };
 
-/* On MAX518 and MAX518 variant, we have two outputs */
+/* On MAX518 and MAX519 variant, we have two outputs */
 static struct attribute *max518_attributes[] = {
 	&iio_dev_attr_out1_raw.dev_attr.attr,
 	&iio_dev_attr_out1_scale.dev_attr.attr,
@@ -201,6 +204,8 @@ static int max517_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
+	data->client = client;
+
 	data->indio_dev = iio_allocate_device();
 	if (data->indio_dev == NULL) {
 		err = -ENOMEM;
