Return-Path: <error27@gmail.com>
Date: Sat, 30 Jul 2011 11:45:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Frysinger <vapier@gentoo.org>,
	"open list:STAGING - INDUSTR..." <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	kernel-janitors@vger.kernel.org
Subject: [patch] Staging: iio: add some unlocks to raw_read() functions
Message-ID: <20110730084509.GD5575@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This code was cut and pasted in several places.  It's missing some
unlocks on error.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index b6e0d84..30be963 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -312,13 +312,17 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
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
index 61c2442..eb68367 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -342,13 +342,17 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
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
index 238438e..39a6136 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -338,13 +338,17 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
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
index 3abac95..d1f5305 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -371,13 +371,17 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
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
index 02de650..429c252 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -447,13 +447,17 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
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
