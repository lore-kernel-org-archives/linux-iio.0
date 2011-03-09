Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO:DAC: AD5624R: Consistency cleanup - no functional changes
Date: Wed, 9 Mar 2011 16:12:42 +0100
Message-ID: <1299683562-31025-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Consistently use indio_dev and access macro for devdata

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/ad5624r_spi.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 0f97ce0..a945b18 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -77,7 +77,7 @@ static ssize_t ad5624r_write_dac(struct device *dev,
 	long readin;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = indio_dev->dev_data;
+	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strict_strtol(buf, 10, &readin);
@@ -94,7 +94,7 @@ static ssize_t ad5624r_read_powerdown_mode(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = indio_dev->dev_data;
+	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
 
 	char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
 
@@ -106,7 +106,7 @@ static ssize_t ad5624r_write_powerdown_mode(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = indio_dev->dev_data;
+	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 
 	if (sysfs_streq(buf, "1kohm_to_gnd"))
@@ -126,7 +126,7 @@ static ssize_t ad5624r_read_dac_powerdown(struct device *dev,
 					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = indio_dev->dev_data;
+	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	return sprintf(buf, "%d\n",
@@ -140,7 +140,7 @@ static ssize_t ad5624r_write_dac_powerdown(struct device *dev,
 	long readin;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = indio_dev->dev_data;
+	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strict_strtol(buf, 10, &readin);
@@ -165,8 +165,8 @@ static ssize_t ad5624r_show_scale(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
 
@@ -178,8 +178,8 @@ static ssize_t ad5624r_show_name(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
 
 	return sprintf(buf, "%s\n", spi_get_device_id(st->us)->name);
 }
-- 
1.6.0.2
