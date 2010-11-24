Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49884 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0KXSl1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2010 13:41:27 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, matthias.bgg@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:gyro:adis16260 add support for adis16251
Date: Wed, 24 Nov 2010 18:48:00 +0000
Message-Id: <1290624481-5522-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1290624481-5522-1-git-send-email-jic23@cam.ac.uk>
References: <1290624481-5522-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Difference I know of based on datasheet and comparison of existing driver:
 * Different time base for sampling frequency
 * Different range of sampling frequency
 * Different scale for gyro (currently only one is supported by either driver)

This patch handles all of these.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260.h      |   12 ++++++-
 drivers/staging/iio/gyro/adis16260_core.c |   49 +++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index e45af81..1572556 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -84,10 +84,20 @@
 
 /**
  * struct adis16160_chip_info - variant specific information
- * @memcheck: if the part supports the memory check test
+ * @slowtimebase:	lower base for frequency calculation
+ * @fasttimebase:	high base for frequency calculation
+ * @memcheck:		if the part supports the memory check test
+ * @gyroscale:		multiplier to be passed directly to userspace
+ * @min_sampling_frequency: minimum supported sampling frequency
+ * @max_sampling_frequency: maximum supported sampling frequency
  **/
 struct adis16260_chip_info {
+	unsigned int slowtimebase;
+	unsigned int fasttimebase;
 	unsigned memcheck:1;
+	const char *gyroscale;
+	const char *min_sampling_frequency;
+	const char *max_sampling_frequency;
 };
 
 /**
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index c7753db..cf85cb1 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -31,14 +31,33 @@
 enum adis16260_variants {
 	adis16260,
 	adis16250,
+	adis16251,
 };
 
 static const struct adis16260_chip_info adis16260_chips[] = {
 	[adis16260] = {
+		.slowtimebase = 66,
+		.fasttimebase = 2048,
 		.memcheck = 1,
+		.gyroscale = "0.00127862821",
+		.min_sampling_frequency = "256",
+		.max_sampling_frequency = "2048",
 	},
 	[adis16250] = {
+		.slowtimebase = 66,
+		.fasttimebase = 2048,
 		.memcheck = 0,
+		.gyroscale = "0.00127862821",
+		.min_sampling_frequency = "256",
+		.max_sampling_frequency = "2048",
+	},
+	[adis16251] = {
+		.slowtimebase = 8,
+		.fasttimebase = 256,
+		.memcheck = 0,
+		.gyroscale = "0.0018315",
+		.min_sampling_frequency = "0.129",
+		.max_sampling_frequency = "256",
 	},
 };
 
@@ -256,6 +275,8 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
 	int ret, len = 0;
 	u16 t;
 	int sps;
@@ -264,12 +285,26 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 			&t);
 	if (ret)
 		return ret;
-	sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
+	sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ?
+		st->info->slowtimebase :
+		st->info->fasttimebase;
 	sps /= (t & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
 	len = sprintf(buf, "%d SPS\n", sps);
 	return len;
 }
 
+static ssize_t adis16260_get_samp_freq_av(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+
+	return sprintf(buf, "%s %s\n",
+		       st->info->min_sampling_frequency,
+		       st->info->max_sampling_frequency);
+}
+
 static ssize_t adis16260_write_frequency(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -287,7 +322,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 
 	mutex_lock(&indio_dev->mlock);
 
-	t = (2048 / val);
+	t = (st->info->fasttimebase / val);
 	if (t > 0)
 		t--;
 	t &= ADIS16260_SMPL_PRD_DIV_MASK;
@@ -316,7 +351,7 @@ static ssize_t adis16260_read_gyro_scale(struct device *dev,
 	if (st->negate)
 		ret = sprintf(buf, "-");
 	/* Take the iio_dev status lock */
-	ret += sprintf(buf + ret, "%s\n", "0.00127862821");
+	ret += sprintf(buf + ret, "%s\n", st->info->gyroscale);
 
 	return ret;
 }
@@ -490,9 +525,10 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16260_read_frequency,
 		adis16260_write_frequency);
 
-static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
+static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
+		       adis16260_get_samp_freq_av, NULL, 0);
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("256 2048");
+static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
 
 static IIO_CONST_ATTR_NAME("adis16260");
 
@@ -542,7 +578,7 @@ static ADIS16260_GYRO_ATTR_SET(_Z);
 		&iio_dev_attr_in1_raw.dev_attr.attr,			\
 		&iio_const_attr_in1_scale.dev_attr.attr,		\
 		&iio_dev_attr_sampling_frequency.dev_attr.attr,		\
-		&iio_const_attr_sampling_frequency_available.dev_attr.attr, \
+		&iio_dev_attr_sampling_frequency_available.dev_attr.attr, \
 		&iio_dev_attr_reset.dev_attr.attr,			\
 		&iio_const_attr_name.dev_attr.attr,			\
 		NULL							\
@@ -711,6 +747,7 @@ static const struct spi_device_id adis16260_id[] = {
 	{"adis16265", adis16260},
 	{"adis16250", adis16250},
 	{"adis16255", adis16250},
+	{"adis16251", adis16251},
 	{}
 };
 
-- 
1.7.2.2

