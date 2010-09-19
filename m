Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/10] staging:iio:sca3000 add _type attributes for all scan elements
Date: Sun, 19 Sep 2010 18:04:29 +0100
Message-Id: <1284915874-24911-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
References: <1284915874-24911-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_ring.c |   46 +++++++++++++----------------
 1 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index c93f85c..15b91e1 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -145,7 +145,10 @@ static ssize_t sca3000_show_ring_bpse(struct device *dev,
 	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
 	if (ret)
 		goto error_ret;
-	len = sprintf(buf, "%d\n", (rx[1] & SCA3000_RING_BUF_8BIT) ? 8 : 11);
+	if (rx[1] & SCA3000_RING_BUF_8BIT)
+		len = sprintf(buf, "s8/8\n");
+	else
+		len = sprintf(buf, "s11/16\n");
 	kfree(rx);
 error_ret:
 	mutex_unlock(&st->lock);
@@ -169,30 +172,23 @@ static ssize_t sca3000_store_ring_bpse(struct device *dev,
 	struct sca3000_state *st = indio_dev->dev_data;
 	int ret;
 	u8 *rx;
-	long val;
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		return ret;
 
 	mutex_lock(&st->lock);
 
 	ret = sca3000_read_data(st, SCA3000_REG_ADDR_MODE, &rx, 1);
-	if (!ret)
-		switch (val) {
-		case 8:
-			ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-						rx[1] | SCA3000_RING_BUF_8BIT);
-			st->bpse = 8;
-			break;
-		case 11:
-			ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-						rx[1] & ~SCA3000_RING_BUF_8BIT);
-			st->bpse = 11;
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
+	if (ret)
+		goto error_ret;
+	if (strncmp(buf, "s8/8", 4) == 0) {
+		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
+					rx[1] | SCA3000_RING_BUF_8BIT);
+		st->bpse = 8;
+	} else if (strncmp(buf, "s11/16", 5) == 0) {
+		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
+					rx[1] & ~SCA3000_RING_BUF_8BIT);
+		st->bpse = 11;
+	} else
+		ret = -EINVAL;
+error_ret:
 	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
@@ -201,8 +197,8 @@ static ssize_t sca3000_store_ring_bpse(struct device *dev,
 static IIO_SCAN_EL_C(accel_x, 0, 0, 0, NULL);
 static IIO_SCAN_EL_C(accel_y, 1, 0, 0, NULL);
 static IIO_SCAN_EL_C(accel_z, 2, 0, 0, NULL);
-static IIO_CONST_ATTR(accel_precision_available, "8 11");
-static IIO_DEVICE_ATTR(accel_precision,
+static IIO_CONST_ATTR(accel_type_available, "s8/8 s11/16");
+static IIO_DEVICE_ATTR(accel_type,
 		       S_IRUGO | S_IWUSR,
 		       sca3000_show_ring_bpse,
 		       sca3000_store_ring_bpse,
@@ -212,8 +208,8 @@ static struct attribute *sca3000_scan_el_attrs[] = {
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
 	&iio_scan_el_accel_z.dev_attr.attr,
-	&iio_const_attr_accel_precision_available.dev_attr.attr,
-	&iio_dev_attr_accel_precision.dev_attr.attr,
+	&iio_const_attr_accel_type_available.dev_attr.attr,
+	&iio_dev_attr_accel_type.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.2.2
