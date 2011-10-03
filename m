Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40242 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198Ab1JCO7y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2011 10:59:54 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/6] staging:iio:dac/dds/impedance dev_info to indio_dev for consistency
Date: Mon,  3 Oct 2011 16:08:16 +0100
Message-Id: <1317654496-14484-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
References: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We had a random missmatch of these two.  Lets pick the most common
and get rid of the other.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5446.c                |   36 +++++++++---------
 drivers/staging/iio/dac/max517.c                |    8 ++--
 drivers/staging/iio/dds/ad9832.c                |    8 ++--
 drivers/staging/iio/dds/ad9834.c                |   28 +++++++-------
 drivers/staging/iio/impedance-analyzer/ad5933.c |   44 +++++++++++-----------
 5 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 41a8872..dc98867a 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -68,8 +68,8 @@ static ssize_t ad5446_write(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_priv(indio_dev);
 	int ret;
 	long val;
 
@@ -82,11 +82,11 @@ static ssize_t ad5446_write(struct device *dev,
 		goto error_ret;
 	}
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	st->cached_val = val;
 	st->chip_info->store_sample(st, val);
 	ret = spi_sync(st->spi, &st->msg);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 error_ret:
 	return ret ? ret : len;
@@ -98,8 +98,8 @@ static ssize_t ad5446_show_scale(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_priv(indio_dev);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
 
@@ -111,8 +111,8 @@ static ssize_t ad5446_write_powerdown_mode(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_priv(indio_dev);
 
 	if (sysfs_streq(buf, "1kohm_to_gnd"))
 		st->pwr_down_mode = MODE_PWRDWN_1k;
@@ -129,8 +129,8 @@ static ssize_t ad5446_write_powerdown_mode(struct device *dev,
 static ssize_t ad5446_read_powerdown_mode(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_priv(indio_dev);
 
 	char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
 
@@ -141,8 +141,8 @@ static ssize_t ad5446_read_dac_powerdown(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", st->pwr_down);
 }
@@ -151,8 +151,8 @@ static ssize_t ad5446_write_dac_powerdown(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_priv(indio_dev);
 	unsigned long readin;
 	int ret;
 
@@ -163,7 +163,7 @@ static ssize_t ad5446_write_dac_powerdown(struct device *dev,
 	if (readin > 1)
 		ret = -EINVAL;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	st->pwr_down = readin;
 
 	if (st->pwr_down)
@@ -172,7 +172,7 @@ static ssize_t ad5446_write_dac_powerdown(struct device *dev,
 		st->chip_info->store_sample(st, st->cached_val);
 
 	ret = spi_sync(st->spi, &st->msg);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
@@ -201,8 +201,8 @@ static mode_t ad5446_attr_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_priv(indio_dev);
 
 	mode_t mode = attr->mode;
 
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index fb780d0..adfbd20 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -59,8 +59,8 @@ static ssize_t max517_set_value(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count, int channel)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max517_data *data = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max517_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 	u8 outbuf[4]; /* 1x or 2x command + value */
 	int outbuf_size = 0;
@@ -128,8 +128,8 @@ static ssize_t max517_show_scale(struct device *dev,
 				struct device_attribute *attr,
 				char *buf, int channel)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct max517_data *data = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max517_data *data = iio_priv(indio_dev);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (data->vref_mv[channel - 1] * 1000) >> 8;
 
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index e6cfa64..aefcab1 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -77,8 +77,8 @@ static ssize_t ad9832_write(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9832_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad9832_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	long val;
@@ -87,7 +87,7 @@ static ssize_t ad9832_write(struct device *dev,
 	if (ret)
 		goto error_ret;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	switch (this_attr->address) {
 	case AD9832_FREQ0HM:
 	case AD9832_FREQ1HM:
@@ -148,7 +148,7 @@ static ssize_t ad9832_write(struct device *dev,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 error_ret:
 	return ret ? ret : len;
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index a5b5aed..fe46119 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -66,8 +66,8 @@ static ssize_t ad9834_write(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad9834_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	long val;
@@ -76,7 +76,7 @@ static ssize_t ad9834_write(struct device *dev,
 	if (ret)
 		goto error_ret;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	switch (this_attr->address) {
 	case AD9834_REG_FREQ0:
 	case AD9834_REG_FREQ1:
@@ -134,7 +134,7 @@ static ssize_t ad9834_write(struct device *dev,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 error_ret:
 	return ret ? ret : len;
@@ -145,13 +145,13 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 				 const char *buf,
 				 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad9834_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret = 0;
 	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 
 	switch (this_attr->address) {
 	case 0:
@@ -194,7 +194,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
 		ret = spi_sync(st->spi, &st->msg);
 	}
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
@@ -203,8 +203,8 @@ static ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad9834_state *st = iio_priv(indio_dev);
 	char *str;
 
 	if ((st->devid == ID_AD9833) || (st->devid == ID_AD9837))
@@ -225,8 +225,8 @@ static ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad9834_state *st = iio_priv(indio_dev);
 	char *str;
 
 	if (st->control & AD9834_MODE)
@@ -285,8 +285,8 @@ static mode_t ad9834_attr_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad9834_state *st = iio_priv(indio_dev);
 
 	mode_t mode = attr->mode;
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index eab288e..5dd8b65 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -259,8 +259,8 @@ static ssize_t ad5933_show_frequency(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5933_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5933_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	unsigned long long freqreg;
@@ -269,9 +269,9 @@ static ssize_t ad5933_show_frequency(struct device *dev,
 		u8 d8[4];
 	} dat;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	ret = ad5933_i2c_read(st->client, this_attr->address, 3, &dat.d8[1]);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 	if (ret < 0)
 		return ret;
 
@@ -288,8 +288,8 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5933_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5933_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long val;
 	int ret;
@@ -301,9 +301,9 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
 		return -EINVAL;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	ret = ad5933_set_freq(st, this_attr->address, val);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
@@ -322,12 +322,12 @@ static ssize_t ad5933_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5933_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5933_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret = 0, len = 0;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	switch (this_attr->address) {
 	case AD5933_OUT_RANGE:
 		len = sprintf(buf, "%d\n",
@@ -356,7 +356,7 @@ static ssize_t ad5933_show(struct device *dev,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 	return ret ? ret : len;
 }
 
@@ -365,8 +365,8 @@ static ssize_t ad5933_store(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5933_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5933_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long val;
 	int i, ret = 0;
@@ -378,7 +378,7 @@ static ssize_t ad5933_store(struct device *dev,
 			return ret;
 	}
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	switch (this_attr->address) {
 	case AD5933_OUT_RANGE:
 		for (i = 0; i < 4; i++)
@@ -427,7 +427,7 @@ static ssize_t ad5933_store(struct device *dev,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 	return ret ? ret : len;
 }
 
@@ -482,20 +482,20 @@ static const struct attribute_group ad5933_attribute_group = {
 	.attrs = ad5933_attributes,
 };
 
-static int ad5933_read_raw(struct iio_dev *dev_info,
+static int ad5933_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
 			   long m)
 {
-	struct ad5933_state *st = iio_priv(dev_info);
+	struct ad5933_state *st = iio_priv(indio_dev);
 	unsigned short dat;
 	int ret = -EINVAL;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	switch (m) {
 	case 0:
-		if (iio_buffer_enabled(dev_info)) {
+		if (iio_buffer_enabled(indio_dev)) {
 			ret = -EBUSY;
 			goto out;
 		}
@@ -511,7 +511,7 @@ static int ad5933_read_raw(struct iio_dev *dev_info,
 				(u8 *)&dat);
 		if (ret < 0)
 			goto out;
-		mutex_unlock(&dev_info->mlock);
+		mutex_unlock(&indio_dev->mlock);
 		ret = be16_to_cpu(dat);
 		/* Temp in Milli degrees Celsius */
 		if (ret < 8192)
@@ -523,7 +523,7 @@ static int ad5933_read_raw(struct iio_dev *dev_info,
 	}
 
 out:
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 	return ret;
 }
 
-- 
1.7.3.4

