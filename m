Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4] iio: pressure: bmp280: support device tree initialization
Date: Fri, 17 Jun 2016 17:12:19 +0200
Message-Id: <1466176341-17442-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
References: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This adds device tree support to the BMP058, BMP180 and BMP280
pressure sensors. Tested on the Qualcomm APQ8060 Dragonboard:

iio:device1$ cat in_temp_input
26700
iio:device1$ cat in_pressure_input
99.185000000

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 2f1498e12bb2..86dd11edd3c2 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -899,6 +900,17 @@ static const struct acpi_device_id bmp280_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
 
+#ifdef CONFIG_OF
+static const struct of_device_id bmp280_of_match[] = {
+	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
+	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
+	{ .compatible = "bosch,bmp058", .data = (void *)BMP180_CHIP_ID },
+};
+MODULE_DEVICE_TABLE(of, bmp280_of_match);
+#else
+#define bmp280_of_match NULL
+#endif
+
 static const struct i2c_device_id bmp280_id[] = {
 	{"bmp280", BMP280_CHIP_ID },
 	{"bmp180", BMP180_CHIP_ID },
@@ -911,6 +923,7 @@ static struct i2c_driver bmp280_driver = {
 	.driver = {
 		.name	= "bmp280",
 		.acpi_match_table = ACPI_PTR(bmp280_acpi_match),
+		.of_match_table = of_match_ptr(bmp280_of_match),
 	},
 	.probe		= bmp280_probe,
 	.id_table	= bmp280_id,
-- 
2.4.11
