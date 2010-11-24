Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	matthias.bgg@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/3] staging:iio:gyro:adis16260 Make memory test dependant on being adis1626x
Date: Wed, 24 Nov 2010 18:47:59 +0000
Message-Id: <1290624481-5522-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1290624481-5522-1-git-send-email-jic23@cam.ac.uk>
References: <1290624481-5522-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Careful reading of datasheet as part of adding adis16251 support.
The adis16250 and adis16255 drivers don't support this functionality.
It is undocumented what will happen if the test is performed, but I suspect
the test bit just happens to be zero.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260.h      |   10 ++++++
 drivers/staging/iio/gyro/adis16260_core.c |   44 ++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index c1fd4364..e45af81 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -83,6 +83,14 @@
 #define ADIS16260_SPI_FAST	(u32)(2000 * 1000)
 
 /**
+ * struct adis16160_chip_info - variant specific information
+ * @memcheck: if the part supports the memory check test
+ **/
+struct adis16260_chip_info {
+	unsigned memcheck:1;
+};
+
+/**
  * struct adis16260_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
@@ -94,6 +102,7 @@
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
  * @negate:		negate the scale parameter
+ * @info:		chip variant specific info
  **/
 struct adis16260_state {
 	struct spi_device		*us;
@@ -105,6 +114,7 @@ struct adis16260_state {
 	u8				*rx;
 	struct mutex			buf_lock;
 	unsigned			negate:1;
+	const struct adis16260_chip_info	*info;
 };
 
 int adis16260_set_irq(struct device *dev, bool enable);
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 045e27d..c7753db 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -28,6 +28,20 @@
 
 #define DRIVER_NAME		"adis16260"
 
+enum adis16260_variants {
+	adis16260,
+	adis16250,
+};
+
+static const struct adis16260_chip_info adis16260_chips[] = {
+	[adis16260] = {
+		.memcheck = 1,
+	},
+	[adis16250] = {
+		.memcheck = 0,
+	},
+};
+
 static int adis16260_check_status(struct device *dev);
 
 /**
@@ -371,16 +385,19 @@ static int adis16260_stop_device(struct device *dev)
 
 static int adis16260_self_test(struct device *dev)
 {
-	int ret;
-	ret = adis16260_spi_write_reg_16(dev,
-			ADIS16260_MSC_CTRL,
-			ADIS16260_MSC_CTRL_MEM_TEST);
-	if (ret) {
-		dev_err(dev, "problem starting self test");
-		goto err_ret;
-	}
-
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	int ret = 0;
+	if (st->info->memcheck) {
+		ret = adis16260_spi_write_reg_16(dev,
+						 ADIS16260_MSC_CTRL,
+						 ADIS16260_MSC_CTRL_MEM_TEST);
+		if (ret) {
+			dev_err(dev, "problem starting self test");
+			goto err_ret;
+		}
 	adis16260_check_status(dev);
+	}
 
 err_ret:
 	return ret;
@@ -549,6 +566,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 		ret =  -ENOMEM;
 		goto error_ret;
 	}
+	st->info = &adis16260_chips[spi_get_device_id(spi)->driver_data];
 	if (pd)
 		st->negate = pd->negate;
 	/* this is only used for removal purposes */
@@ -689,10 +707,10 @@ err_ret:
  * support for the on chip filtering.
  */
 static const struct spi_device_id adis16260_id[] = {
-	{"adis16260", 0},
-	{"adis16265", 0},
-	{"adis16250", 0},
-	{"adis16255", 0},
+	{"adis16260", adis16260},
+	{"adis16265", adis16260},
+	{"adis16250", adis16250},
+	{"adis16255", adis16250},
 	{}
 };
 
-- 
1.7.2.2
