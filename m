Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 4/4] staging: iio: dac: Cleanup style - no functional changes
Date: Fri, 19 Nov 2010 15:16:46 +0100
Message-ID: <1290176206-10769-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1290176206-10769-1-git-send-email-michael.hennerich@analog.com>
References: <1290176206-10769-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Stick to the 80 character line limit at least for code

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5624r_spi.c |   67 +++++++++++++++++----------------
 1 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index b7c1661..2b1c6dd 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -57,9 +57,8 @@ static int ad5624r_spi_write(struct spi_device *spi,
 }

 static ssize_t ad5624r_write_dac(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				 struct device_attribute *attr,
+				 const char *buf, size_t len)
 {
 	long readin;
 	int ret;
@@ -72,13 +71,12 @@ static ssize_t ad5624r_write_dac(struct device *dev,
 		return ret;

 	ret = ad5624r_spi_write(st->us, AD5624R_CMD_WRITE_INPUT_N_UPDATE_N,
-			this_attr->address, readin, st->data_len);
+				this_attr->address, readin, st->data_len);
 	return ret ? ret : len;
 }

 static ssize_t ad5624r_read_ldac_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5624r_state *st = indio_dev->dev_data;
@@ -87,9 +85,8 @@ static ssize_t ad5624r_read_ldac_mode(struct device *dev,
 }

 static ssize_t ad5624r_write_ldac_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
 {
 	long readin;
 	int ret;
@@ -100,15 +97,16 @@ static ssize_t ad5624r_write_ldac_mode(struct device *dev,
 	if (ret)
 		return ret;

-	ret = ad5624r_spi_write(st->us, AD5624R_CMD_LDAC_SETUP, 0, readin & 0xF, 16);
+	ret = ad5624r_spi_write(st->us, AD5624R_CMD_LDAC_SETUP, 0,
+				readin & 0xF, 16);
 	st->ldac_mode = readin & 0xF;

 	return ret ? ret : len;
 }

 static ssize_t ad5624r_read_dac_power_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5624r_state *st = indio_dev->dev_data;
@@ -118,9 +116,8 @@ static ssize_t ad5624r_read_dac_power_mode(struct device *dev,
 }

 static ssize_t ad5624r_write_dac_power_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	long readin;
 	int ret;
@@ -133,7 +130,8 @@ static ssize_t ad5624r_write_dac_power_mode(struct device *dev,
 		return ret;

 	ret = ad5624r_spi_write(st->us, AD5624R_CMD_POWERDOWN_DAC, 0,
-			((readin & 0x3) << 4) | (1 << this_attr->address), 16);
+				((readin & 0x3) << 4) |
+				(1 << this_attr->address), 16);

 	st->dac_power_mode[this_attr->address] = readin & 0x3;

@@ -141,8 +139,8 @@ static ssize_t ad5624r_write_dac_power_mode(struct device *dev,
 }

 static ssize_t ad5624r_read_internal_ref_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5624r_state *st = indio_dev->dev_data;
@@ -151,9 +149,8 @@ static ssize_t ad5624r_read_internal_ref_mode(struct device *dev,
 }

 static ssize_t ad5624r_write_internal_ref_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	long readin;
 	int ret;
@@ -164,7 +161,8 @@ static ssize_t ad5624r_write_internal_ref_mode(struct device *dev,
 	if (ret)
 		return ret;

-	ret = ad5624r_spi_write(st->us, AD5624R_CMD_INTERNAL_REFER_SETUP, 0, !!readin, 16);
+	ret = ad5624r_spi_write(st->us, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
+				!!readin, 16);

 	st->internal_ref = !!readin;

@@ -177,17 +175,22 @@ static IIO_DEV_ATTR_OUT_RAW(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
 static IIO_DEV_ATTR_OUT_RAW(3, ad5624r_write_dac, AD5624R_ADDR_DAC3);

 static IIO_DEVICE_ATTR(ldac_mode, S_IRUGO | S_IWUSR, ad5624r_read_ldac_mode,
-		ad5624r_write_ldac_mode, 0);
-static IIO_DEVICE_ATTR(internal_ref, S_IRUGO | S_IWUSR, ad5624r_read_internal_ref_mode,
-		ad5624r_write_internal_ref_mode, 0);
+		       ad5624r_write_ldac_mode, 0);
+static IIO_DEVICE_ATTR(internal_ref, S_IRUGO | S_IWUSR,
+		       ad5624r_read_internal_ref_mode,
+		       ad5624r_write_internal_ref_mode, 0);

 #define IIO_DEV_ATTR_DAC_POWER_MODE(_num, _show, _store, _addr)			\
 	IIO_DEVICE_ATTR(dac_power_mode_##_num, S_IRUGO | S_IWUSR, _show, _store, _addr)

-static IIO_DEV_ATTR_DAC_POWER_MODE(0, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 0);
-static IIO_DEV_ATTR_DAC_POWER_MODE(1, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 1);
-static IIO_DEV_ATTR_DAC_POWER_MODE(2, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 2);
-static IIO_DEV_ATTR_DAC_POWER_MODE(3, ad5624r_read_dac_power_mode, ad5624r_write_dac_power_mode, 3);
+static IIO_DEV_ATTR_DAC_POWER_MODE(0, ad5624r_read_dac_power_mode,
+				   ad5624r_write_dac_power_mode, 0);
+static IIO_DEV_ATTR_DAC_POWER_MODE(1, ad5624r_read_dac_power_mode,
+				   ad5624r_write_dac_power_mode, 1);
+static IIO_DEV_ATTR_DAC_POWER_MODE(2, ad5624r_read_dac_power_mode,
+				   ad5624r_write_dac_power_mode, 2);
+static IIO_DEV_ATTR_DAC_POWER_MODE(3, ad5624r_read_dac_power_mode,
+				   ad5624r_write_dac_power_mode, 3);

 static struct attribute *ad5624r_attributes[] = {
 	&iio_dev_attr_out0_raw.dev_attr.attr,
@@ -272,9 +275,9 @@ static const struct spi_device_id ad5624r_id[] = {

 static struct spi_driver ad5624r_driver = {
 	.driver = {
-		.name = "ad5624r",
-		.owner = THIS_MODULE,
-	},
+		   .name = "ad5624r",
+		   .owner = THIS_MODULE,
+		   },
 	.probe = ad5624r_probe,
 	.remove = __devexit_p(ad5624r_remove),
 	.id_table = ad5624r_id,
--
1.6.0.2
