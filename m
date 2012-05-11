Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/24] staging:iio:gyro: Use dev_to_iio_dev()
Date: Fri, 11 May 2012 14:58:40 +0200
Message-Id: <1336741127-29552-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-1-git-send-email-lars@metafoo.de>
References: <1336741127-29552-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Replace open-coded instances of getting a iio_dev struct from a device struct
with dev_to_iio_dev().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index d7979cf..ec765f9 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -149,7 +149,7 @@ static ssize_t adis16260_read_frequency_available(struct device *dev,
 						  struct device_attribute *attr,
 						  char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16260_state *st = iio_priv(indio_dev);
 	if (spi_get_device_id(st->us)->driver_data)
 		return sprintf(buf, "%s\n", "0.129 ~ 256");
@@ -161,7 +161,7 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16260_state *st = iio_priv(indio_dev);
 	int ret, len = 0;
 	u16 t;
@@ -186,7 +186,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16260_state *st = iio_priv(indio_dev);
 	long val;
 	int ret;
@@ -237,7 +237,7 @@ static ssize_t adis16260_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	if (len < 1)
 		return -EINVAL;
 	switch (buf[0]) {
-- 
1.7.10
