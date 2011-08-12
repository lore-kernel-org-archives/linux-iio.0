Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:40643 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab1HLPrn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 11:47:43 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: [PATCH 01/12] Staging: iio: add some unlocks to raw_read() functions
Date: Fri, 12 Aug 2011 16:55:27 +0100
Message-Id: <1313164538-1769-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

This code was cut and pasted in several places.  It's missing some
unlocks on error.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/staging/iio/accel/adis16203_core.c |    8 ++++++--
 drivers/staging/iio/accel/adis16204_core.c |    8 ++++++--
 drivers/staging/iio/accel/adis16209_core.c |    8 ++++++--
 drivers/staging/iio/accel/adis16240_core.c |    8 ++++++--
 drivers/staging/iio/gyro/adis16260_core.c  |    8 ++++++--
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index bf19888..cf5d15d 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -311,13 +311,17 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16203_addresses[chan->address][0];
 		ret = adis16203_spi_read_reg_16(indio_dev, addr, &val16);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
 			return ret;
+		}
 
 		if (val16 & ADIS16203_ERROR_ACTIVE) {
 			ret = adis16203_check_status(indio_dev);
-			if (ret)
+			if (ret) {
+				mutex_unlock(&indio_dev->mlock);
 				return ret;
+			}
 		}
 		val16 = val16 & ((1 << chan->scan_type.realbits) - 1);
 		if (chan->scan_type.sign == 's')
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index cfd09b3..3e2b626 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -341,13 +341,17 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16204_addresses[chan->address][0];
 		ret = adis16204_spi_read_reg_16(indio_dev, addr, &val16);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
 			return ret;
+		}
 
 		if (val16 & ADIS16204_ERROR_ACTIVE) {
 			ret = adis16204_check_status(indio_dev);
-			if (ret)
+			if (ret) {
+				mutex_unlock(&indio_dev->mlock);
 				return ret;
+			}
 		}
 		val16 = val16 & ((1 << chan->scan_type.realbits) - 1);
 		if (chan->scan_type.sign == 's')
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 55f3a7b..bec1fa8 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -337,13 +337,17 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16209_addresses[chan->address][0];
 		ret = adis16209_spi_read_reg_16(indio_dev, addr, &val16);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
 			return ret;
+		}
 
 		if (val16 & ADIS16209_ERROR_ACTIVE) {
 			ret = adis16209_check_status(indio_dev);
-			if (ret)
+			if (ret) {
+				mutex_unlock(&indio_dev->mlock);
 				return ret;
+			}
 		}
 		val16 = val16 & ((1 << chan->scan_type.realbits) - 1);
 		if (chan->scan_type.sign == 's')
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 4a4eafc..aee8b69 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -370,13 +370,17 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16240_addresses[chan->address][0];
 		ret = adis16240_spi_read_reg_16(indio_dev, addr, &val16);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
 			return ret;
+		}
 
 		if (val16 & ADIS16240_ERROR_ACTIVE) {
 			ret = adis16240_check_status(indio_dev);
-			if (ret)
+			if (ret) {
+				mutex_unlock(&indio_dev->mlock);
 				return ret;
+			}
 		}
 		val16 = val16 & ((1 << chan->scan_type.realbits) - 1);
 		if (chan->scan_type.sign == 's')
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 05797f4..f2d43cf 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -446,13 +446,17 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16260_addresses[chan->address][0];
 		ret = adis16260_spi_read_reg_16(indio_dev, addr, &val16);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
 			return ret;
+		}
 
 		if (val16 & ADIS16260_ERROR_ACTIVE) {
 			ret = adis16260_check_status(indio_dev);
-			if (ret)
+			if (ret) {
+				mutex_unlock(&indio_dev->mlock);
 				return ret;
+			}
 		}
 		val16 = val16 & ((1 << chan->scan_type.realbits) - 1);
 		if (chan->scan_type.sign == 's')
-- 
1.7.3.4

