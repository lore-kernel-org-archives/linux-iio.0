Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/6] staging:iio:accel:sca3000 dev_info to indio_dev renaming.
Date: Mon,  3 Oct 2011 16:08:14 +0100
Message-Id: <1317654496-14484-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
References: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Again, there is a mix of the two names for the struct iio_dev.
Lets pick one and run with it.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_core.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 5592b24..f2cdb1f 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -268,8 +268,8 @@ static ssize_t sca3000_show_rev(struct device *dev,
 				char *buf)
 {
 	int len = 0, ret;
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_REVID, 1);
@@ -296,8 +296,8 @@ sca3000_show_available_measurement_modes(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int len = 0;
 
 	len += sprintf(buf + len, "0 - normal mode");
@@ -328,8 +328,8 @@ sca3000_show_measurement_mode(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int len = 0, ret;
 
 	mutex_lock(&st->lock);
@@ -379,8 +379,8 @@ sca3000_store_measurement_mode(struct device *dev,
 			       const char *buf,
 			       size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	int mask = 0x03;
 	long val;
-- 
1.7.3.4
