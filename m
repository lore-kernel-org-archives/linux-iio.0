Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25576 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932399AbcDKOYq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 11 Apr 2016 10:24:46 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v3 1/2] ti-adc081c: Add support for adc101c and adc121c
Date: Mon, 11 Apr 2016 17:24:26 +0300
Message-Id: <879d0c2afc33e22efbfbc8746bb3dd1ca96394cd.1460384543.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460384543.git.leonard.crestez@intel.com>
References: <cover.1460384543.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460384543.git.leonard.crestez@intel.com>
References: <cover.1460384543.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These chips have an almost identical interface but support a different
number of value bits. Datasheet links for comparison:

 * http://www.ti.com/lit/ds/symlink/adc081c021.pdf
 * http://www.ti.com/lit/ds/symlink/adc101c021.pdf
 * http://www.ti.com/lit/ds/symlink/adc121c021.pdf

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/adc/Kconfig      |  6 +++---
 drivers/iio/adc/ti-adc081c.c | 51 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5937030..25378c5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -385,11 +385,11 @@ config ROCKCHIP_SARADC
 	  module will be called rockchip_saradc.
 
 config TI_ADC081C
-	tristate "Texas Instruments ADC081C021/027"
+	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
 	depends on I2C
 	help
-	  If you say yes here you get support for Texas Instruments ADC081C021
-	  and ADC081C027 ADC chips.
+	  If you say yes here you get support for Texas Instruments ADC081C,
+	  ADC101C and ADC121C ADC chips.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-adc081c.
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index ecbc121..b977340 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -1,9 +1,21 @@
 /*
+ * TI ADC081C/ADC101C/ADC121C 8/10/12-bit ADC driver
+ *
  * Copyright (C) 2012 Avionic Design GmbH
+ * Copyright (C) 2016 Intel
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * Datasheets:
+ *	http://www.ti.com/lit/ds/symlink/adc081c021.pdf
+ *	http://www.ti.com/lit/ds/symlink/adc101c021.pdf
+ *	http://www.ti.com/lit/ds/symlink/adc121c021.pdf
+ *
+ * The devices have a very similar interface and differ mostly in the number of
+ * bits handled. For the 8-bit and 10-bit models the least-significant 4 or 2
+ * bits of value registers are reserved.
  */
 
 #include <linux/err.h>
@@ -17,6 +29,9 @@
 struct adc081c {
 	struct i2c_client *i2c;
 	struct regulator *ref;
+
+	/* 8, 10 or 12 */
+	int bits;
 };
 
 #define REG_CONV_RES 0x00
@@ -34,7 +49,7 @@ static int adc081c_read_raw(struct iio_dev *iio,
 		if (err < 0)
 			return err;
 
-		*value = (err >> 4) & 0xff;
+		*value = (err & 0xFFF) >> (12 - adc->bits);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -43,7 +58,7 @@ static int adc081c_read_raw(struct iio_dev *iio,
 			return err;
 
 		*value = err / 1000;
-		*shift = 8;
+		*shift = adc->bits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -60,6 +75,28 @@ static const struct iio_chan_spec adc081c_channel = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 };
 
+struct adcxx1c_model {
+	int bits;
+};
+
+#define ADCxx1C_MODEL(_bits)						\
+	{								\
+		.bits = (_bits),					\
+	}
+
+/* Model ids are indexes in _models array */
+enum adcxx1c_model_id {
+	ADC081C = 0,
+	ADC101C = 1,
+	ADC121C = 2,
+};
+
+static struct adcxx1c_model adcxx1c_models[] = {
+	ADCxx1C_MODEL( 8),
+	ADCxx1C_MODEL(10),
+	ADCxx1C_MODEL(12),
+};
+
 static const struct iio_info adc081c_info = {
 	.read_raw = adc081c_read_raw,
 	.driver_module = THIS_MODULE,
@@ -70,6 +107,7 @@ static int adc081c_probe(struct i2c_client *client,
 {
 	struct iio_dev *iio;
 	struct adc081c *adc;
+	struct adcxx1c_model *model = &adcxx1c_models[id->driver_data];
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
@@ -81,6 +119,7 @@ static int adc081c_probe(struct i2c_client *client,
 
 	adc = iio_priv(iio);
 	adc->i2c = client;
+	adc->bits = model->bits;
 
 	adc->ref = devm_regulator_get(&client->dev, "vref");
 	if (IS_ERR(adc->ref))
@@ -124,7 +163,9 @@ static int adc081c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adc081c_id[] = {
-	{ "adc081c", 0 },
+	{ "adc081c", ADC081C },
+	{ "adc101c", ADC101C },
+	{ "adc121c", ADC121C },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
@@ -132,6 +173,8 @@ MODULE_DEVICE_TABLE(i2c, adc081c_id);
 #ifdef CONFIG_OF
 static const struct of_device_id adc081c_of_match[] = {
 	{ .compatible = "ti,adc081c" },
+	{ .compatible = "ti,adc101c" },
+	{ .compatible = "ti,adc121c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc081c_of_match);
@@ -149,5 +192,5 @@ static struct i2c_driver adc081c_driver = {
 module_i2c_driver(adc081c_driver);
 
 MODULE_AUTHOR("Thierry Reding <thierry.reding@avionic-design.de>");
-MODULE_DESCRIPTION("Texas Instruments ADC081C021/027 driver");
+MODULE_DESCRIPTION("Texas Instruments ADC081C/ADC101C/ADC121C driver");
 MODULE_LICENSE("GPL v2");
-- 
2.5.5

