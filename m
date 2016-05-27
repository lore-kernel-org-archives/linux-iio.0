Return-Path: <dan@emutex.com>
From: Dan O'Donovan <dan@emutex.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Dan O'Donovan <dan@emutex.com>
Subject: [PATCH] iio: adc: ti-adc081c: add ACPI device ID matching
Date: Fri, 27 May 2016 18:37:30 +0100
Message-Id: <1464370650-6257-1-git-send-email-dan@emutex.com>
List-ID: <linux-iio@vger.kernel.org>

Add ACPI device ID matching for TI ADC081C/ADC101C/ADC121C ADCs.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/iio/adc/ti-adc081c.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 9fd032d..f8807ad 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -22,6 +22,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -149,12 +150,24 @@ static int adc081c_probe(struct i2c_client *client,
 {
 	struct iio_dev *iio;
 	struct adc081c *adc;
-	struct adcxx1c_model *model = &adcxx1c_models[id->driver_data];
+	struct adcxx1c_model *model;
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
+	if (ACPI_COMPANION(&client->dev)) {
+		const struct acpi_device_id *ad_id;
+
+		ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
+					  &client->dev);
+		if (!ad_id)
+			return -ENODEV;
+		model = &adcxx1c_models[ad_id->driver_data];
+	} else {
+		model = &adcxx1c_models[id->driver_data];
+	}
+
 	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
 	if (!iio)
 		return -ENOMEM;
@@ -231,10 +244,21 @@ static const struct of_device_id adc081c_of_match[] = {
 MODULE_DEVICE_TABLE(of, adc081c_of_match);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id adc081c_acpi_match[] = {
+	{ "ADC081C", ADC081C },
+	{ "ADC101C", ADC101C },
+	{ "ADC121C", ADC121C },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
+#endif
+
 static struct i2c_driver adc081c_driver = {
 	.driver = {
 		.name = "adc081c",
 		.of_match_table = of_match_ptr(adc081c_of_match),
+		.acpi_match_table = ACPI_PTR(adc081c_acpi_match),
 	},
 	.probe = adc081c_probe,
 	.remove = adc081c_remove,
-- 
2.1.4
