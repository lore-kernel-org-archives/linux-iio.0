Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>, <jic23@cam.ac.uk>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] IIO: DDS: AD9834: Add support for AD9837 and AD9838 DDS devices
Date: Wed, 27 Apr 2011 17:22:36 +0200
Message-ID: <1303917756-18113-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add support for AD9837 and AD9838 DDS devices
Update copyright and license notice
Fix typo

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/Kconfig  |    4 ++--
 drivers/staging/iio/dds/ad9834.c |   31 ++++++++++++++++---------------
 drivers/staging/iio/dds/ad9834.h |    8 +++++---
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/dds/Kconfig
index 06b6f3a..e07431d 100644
--- a/drivers/staging/iio/dds/Kconfig
+++ b/drivers/staging/iio/dds/Kconfig
@@ -21,11 +21,11 @@ config AD9832
 	  module will be called ad9832.

 config AD9834
-	tristate "Analog Devices ad9833/4/ driver"
+	tristate "Analog Devices AD9833/4/7/8 driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices DDS chip
-	  AD9833 and AD9834, provides direct access via sysfs.
+	  AD9833, AD9834, AD9837 and AD9838, provides direct access via sysfs.

 	  To compile this driver as a module, choose M here: the
 	  module will be called ad9834.
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index da5e302..6dbc458 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -1,9 +1,9 @@
 /*
- * AD9834 SPI DAC driver
+ * AD9833/AD9834/AD9837/AD9838 SPI DDS driver
  *
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
+ * Licensed under the GPL-2.
  */

 #include <linux/interrupt.h>
@@ -47,7 +47,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 				       (AD9834_FREQ_BITS / 2)) &
 				       RES_MASK(AD9834_FREQ_BITS / 2)));

-	return spi_sync(st->spi, &st->freq_msg);;
+	return spi_sync(st->spi, &st->freq_msg);
 }

 static int ad9834_write_phase(struct ad9834_state *st,
@@ -148,7 +148,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 	struct ad9834_state *st = dev_info->dev_data;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret = 0;
-	bool is_ad9833 = st->devid == ID_AD9833;
+	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);

 	mutex_lock(&dev_info->mlock);

@@ -156,10 +156,10 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 	case 0:
 		if (sysfs_streq(buf, "sine")) {
 			st->control &= ~AD9834_MODE;
-			if (is_ad9833)
+			if (is_ad9833_7)
 				st->control &= ~AD9834_OPBITEN;
 		} else if (sysfs_streq(buf, "triangle")) {
-			if (is_ad9833) {
+			if (is_ad9833_7) {
 				st->control &= ~AD9834_OPBITEN;
 				st->control |= AD9834_MODE;
 			} else if (st->control & AD9834_OPBITEN) {
@@ -167,7 +167,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 			} else {
 				st->control |= AD9834_MODE;
 			}
-		} else if (is_ad9833 && sysfs_streq(buf, "square")) {
+		} else if (is_ad9833_7 && sysfs_streq(buf, "square")) {
 			st->control &= ~AD9834_MODE;
 			st->control |= AD9834_OPBITEN;
 		} else {
@@ -217,7 +217,7 @@ static ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 	struct ad9834_state *st = iio_dev_get_devdata(dev_info);
 	char *str;

-	if (st->devid == ID_AD9833)
+	if ((st->devid == ID_AD9833) || (st->devid == ID_AD9837))
 		str = "sine triangle square";
 	else if (st->control & AD9834_OPBITEN)
 		str = "sine";
@@ -301,13 +301,12 @@ static mode_t ad9834_attr_is_visible(struct kobject *kobj,

 	mode_t mode = attr->mode;

-	if (st->devid == ID_AD9834)
-		return mode;
-
-	if ((attr == &iio_dev_attr_dds0_out1_enable.dev_attr.attr) ||
+	if (((st->devid == ID_AD9833) || (st->devid == ID_AD9837)) &&
+		((attr == &iio_dev_attr_dds0_out1_enable.dev_attr.attr) ||
 		(attr == &iio_dev_attr_dds0_out1_wavetype.dev_attr.attr) ||
 		(attr ==
-		&iio_dev_attr_dds0_out1_wavetype_available.dev_attr.attr))
+		&iio_dev_attr_dds0_out1_wavetype_available.dev_attr.attr) ||
+		(attr == &iio_dev_attr_dds0_pincontrol_en.dev_attr.attr)))
 		mode = 0;

 	return mode;
@@ -445,6 +444,8 @@ static int __devexit ad9834_remove(struct spi_device *spi)
 static const struct spi_device_id ad9834_id[] = {
 	{"ad9833", ID_AD9833},
 	{"ad9834", ID_AD9834},
+	{"ad9837", ID_AD9837},
+	{"ad9838", ID_AD9838},
 	{}
 };

@@ -472,6 +473,6 @@ static void __exit ad9834_exit(void)
 module_exit(ad9834_exit);

 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD9833/AD9834 DDS");
+MODULE_DESCRIPTION("Analog Devices AD9833/AD9834/AD9837/AD9838 DDS");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("spi:ad9834");
diff --git a/drivers/staging/iio/dds/ad9834.h b/drivers/staging/iio/dds/ad9834.h
index 0fc3b88..2abd635 100644
--- a/drivers/staging/iio/dds/ad9834.h
+++ b/drivers/staging/iio/dds/ad9834.h
@@ -1,9 +1,9 @@
 /*
- * AD9834 SPI DDS driver
+ * AD9833/AD9834/AD9837/AD9838 SPI DDS driver
  *
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
+ * Licensed under the GPL-2.
  */
 #ifndef IIO_DDS_AD9834_H_
 #define IIO_DDS_AD9834_H_
@@ -107,6 +107,8 @@ struct ad9834_platform_data {
 enum ad9834_supported_device_ids {
 	ID_AD9833,
 	ID_AD9834,
+	ID_AD9837,
+	ID_AD9838,
 };

 #endif /* IIO_DDS_AD9834_H_ */
--
1.6.0.2
