Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:adis16220: Use kobj_to_dev instead of open-coding it
Date: Tue,  7 Aug 2012 09:55:42 +0200
Message-Id: <1344326142-19297-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Needs the latest staging-next of today to compile.

 drivers/staging/iio/accel/adis16220_core.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 575f1af..c31e1ec 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -372,8 +372,7 @@ static ssize_t adis16220_accel_bin_read(struct file *filp, struct kobject *kobj,
 					loff_t off,
 					size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(kobj_to_dev(kobj));
 
 	return adis16220_capture_buffer_read(indio_dev, buf,
 					off, count,
@@ -394,8 +393,7 @@ static ssize_t adis16220_adc1_bin_read(struct file *filp, struct kobject *kobj,
 				char *buf, loff_t off,
 				size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(kobj_to_dev(kobj));
 
 	return adis16220_capture_buffer_read(indio_dev, buf,
 					off, count,
@@ -416,8 +414,7 @@ static ssize_t adis16220_adc2_bin_read(struct file *filp, struct kobject *kobj,
 				char *buf, loff_t off,
 				size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(kobj_to_dev(kobj));
 
 	return adis16220_capture_buffer_read(indio_dev, buf,
 					off, count,
-- 
1.7.10.4
