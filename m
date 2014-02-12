Return-Path: <Paul.Cercueil@analog.com>
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>, Paul
 Cercueil <paul.cercueil@analog.com>
Subject: [PATCH 1/3] iio: ad5064: Explicitly configure whether to use external supply
Date: Wed, 12 Feb 2014 13:01:56 +0100
Message-ID: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Previously the driver would revert to internal supply if the
external supply couldn't be found. This had multiple problems:
- it caused silently ignored errors when a regulator was intended
  to be supplied, but was not specified correctly.
- if CONFIG_REGULATOR is disabled, regulator_get() will always
  return a dummy regulator, which caused a device to always use
  the external vref mode, even though there is none.

This patch addresses the issue by adding a platform data structure,
containing a boolean field use_external_ref. If the platform data
structure is present and if that boolean is set, the external vref
is used; otherwise the internal vref is used.

In the case where an external vref is wanted but regulator_get()
fails, the driver no longer reverts to using the internal vref,
but returns an error instead.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
---
 drivers/iio/dac/ad5064.c             |   26 +++++++++++++++++---------
 include/linux/platform_data/ad5064.h |   21 +++++++++++++++++++++
 2 files changed, 38 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/platform_data/ad5064.h

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index f03b92f..fbb836a 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -2,7 +2,7 @@
  * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R,
  * AD5648, AD5666, AD5668, AD5669R Digital to analog converters driver
  *
- * Copyright 2011 Analog Devices Inc.
+ * Copyright 2011, 2014 Analog Devices Inc.
  *
  * Licensed under the GPL-2.
  */
@@ -21,6 +21,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include <linux/platform_data/ad5064.h>
+
 #define AD5064_MAX_DAC_CHANNELS			8
 #define AD5064_MAX_VREFS			4
 
@@ -441,6 +443,7 @@ static const char * const ad5064_vref_name(struct ad5064_state *st,
 static int ad5064_probe(struct device *dev, enum ad5064_type type,
 			const char *name, ad5064_write_func write)
 {
+	struct ad5064_platform_data *pdata = dev->platform_data;
 	struct iio_dev *indio_dev;
 	struct ad5064_state *st;
 	unsigned int midscale;
@@ -461,11 +464,20 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	for (i = 0; i < ad5064_num_vref(st); ++i)
 		st->vref_reg[i].supply = ad5064_vref_name(st, i);
 
-	ret = devm_regulator_bulk_get(dev, ad5064_num_vref(st),
-		st->vref_reg);
-	if (ret) {
-		if (!st->chip_info->internal_vref)
+	if (pdata && pdata->use_external_ref) {
+		ret = devm_regulator_bulk_get(dev, ad5064_num_vref(st),
+					st->vref_reg);
+		if (ret)
 			return ret;
+		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
+		if (ret)
+			return ret;
+	} else {
+		if (!st->chip_info->internal_vref) {
+			dev_err(dev, "No vref available\n");
+			return -ENXIO;
+		}
+
 		st->use_internal_vref = true;
 		ret = ad5064_write(st, AD5064_CMD_CONFIG, 0,
 			AD5064_CONFIG_INT_VREF_ENABLE, 0);
@@ -474,10 +486,6 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 				ret);
 			return ret;
 		}
-	} else {
-		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
-		if (ret)
-			return ret;
 	}
 
 	indio_dev->dev.parent = dev;
diff --git a/include/linux/platform_data/ad5064.h b/include/linux/platform_data/ad5064.h
new file mode 100644
index 0000000..8a87a94
--- /dev/null
+++ b/include/linux/platform_data/ad5064.h
@@ -0,0 +1,21 @@
+/*
+ * Analog Devices AD5064 DAC driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef __IIO_ADC_AD5064_H__
+#define __IIO_ADC_AD5064_H__
+
+/**
+ * struct ad5064_platform_data - AD5064 platform data
+ * @use_external_ref: If set to true use an external voltage reference connected
+ * to the VREF pin, otherwise use the internal reference derived from Vdd.
+ */
+struct ad5064_platform_data {
+	bool use_external_ref;
+};
+
+#endif
-- 
1.7.10.4
