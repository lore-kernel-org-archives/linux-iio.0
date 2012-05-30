Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/8] staging:iio:gyro:adis16260 drop sysfs interface for manual device reset.
Date: Wed, 30 May 2012 20:41:00 +0100
Message-Id: <1338406866-3833-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-1-git-send-email-jic23@kernel.org>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

There is no reason for userspace to do this, so lets
drop this abi.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/gyro/adis16260_core.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index ec765f9..a19bf44 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -233,22 +233,6 @@ static int adis16260_reset(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static ssize_t adis16260_write_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	if (len < 1)
-		return -EINVAL;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return adis16260_reset(indio_dev);
-	}
-	return -EINVAL;
-}
-
 int adis16260_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret;
@@ -375,8 +359,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16260_read_frequency,
 		adis16260_write_frequency);
 
-static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
-
 static IIO_DEVICE_ATTR(sampling_frequency_available,
 		       S_IRUGO, adis16260_read_frequency_available, NULL, 0);
 
@@ -604,7 +586,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 static struct attribute *adis16260_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.10.2
