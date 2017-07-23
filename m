Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 28/45] staging:iio:adc: drop assign iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:10 +0100
Message-Id: <20170723162627.22534-29-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
element will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7192.c    | 2 --
 drivers/staging/iio/adc/ad7280a.c   | 1 -
 drivers/staging/iio/adc/ad7606.c    | 4 ----
 drivers/staging/iio/adc/ad7780.c    | 1 -
 drivers/staging/iio/adc/ad7816.c    | 1 -
 drivers/staging/iio/addac/adt7316.c | 2 --
 6 files changed, 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d11c6de9c777..d577d7b32c71 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -569,7 +569,6 @@ static const struct iio_info ad7192_info = {
 	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
 	.attrs = &ad7192_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad7195_info = {
@@ -578,7 +577,6 @@ static const struct iio_info ad7195_info = {
 	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
 	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec ad7192_channels[] = {
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index f85dde9805e0..b736275c10f5 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -828,7 +828,6 @@ static const struct iio_info ad7280_info = {
 	.read_raw = ad7280_read_raw,
 	.event_attrs = &ad7280_event_attrs_group,
 	.attrs = &ad7280_attrs_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct ad7280_platform_data ad7793_default_pdata = {
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 18f5f139117e..25b9fcd5e3a4 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -373,26 +373,22 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 };
 
 static const struct iio_info ad7606_info_no_os_or_range = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
 };
 
 static const struct iio_info ad7606_info_os_and_range = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os_and_range,
 };
 
 static const struct iio_info ad7606_info_os = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_os,
 };
 
 static const struct iio_info ad7606_info_range = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
 	.attrs = &ad7606_attribute_group_range,
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index dec3ba6eba8a..a7797af579b9 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -155,7 +155,6 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 
 static const struct iio_info ad7780_info = {
 	.read_raw = ad7780_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad7780_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 17d280581e24..bfe180a475ee 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -335,7 +335,6 @@ static const struct attribute_group ad7816_event_attribute_group = {
 static const struct iio_info ad7816_info = {
 	.attrs = &ad7816_attribute_group,
 	.event_attrs = &ad7816_event_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 /*
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index b2bce26499f5..2d33632c00e8 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2087,13 +2087,11 @@ EXPORT_SYMBOL_GPL(adt7316_pm_ops);
 static const struct iio_info adt7316_info = {
 	.attrs = &adt7316_attribute_group,
 	.event_attrs = &adt7316_event_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info adt7516_info = {
 	.attrs = &adt7516_attribute_group,
 	.event_attrs = &adt7516_event_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 /*
-- 
2.13.3
