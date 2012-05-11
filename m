Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 19/24] staging:iio:imu: Use dev_to_iio_dev()
Date: Fri, 11 May 2012 14:58:42 +0200
Message-Id: <1336741127-29552-19-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-1-git-send-email-lars@metafoo.de>
References: <1336741127-29552-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Replace open-coded instances of getting a iio_dev struct from a device struct
with dev_to_iio_dev().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 5015f82..1f6bd85 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -179,7 +179,7 @@ static ssize_t adis16400_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	int ret, len = 0;
 	ret = adis16400_get_freq(indio_dev);
 	if (ret < 0)
@@ -225,7 +225,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16400_state *st = iio_priv(indio_dev);
 	long val;
 	int ret;
@@ -279,7 +279,7 @@ static ssize_t adis16400_write_reset(struct device *dev,
 	if (ret < 0)
 		return ret;
 	if (val) {
-		ret = adis16400_reset(dev_get_drvdata(dev));
+		ret = adis16400_reset(dev_to_iio_dev(dev));
 		if (ret < 0)
 			return ret;
 	}
-- 
1.7.10
