Return-Path: <SRS0=lwIE=YC=analog.com=Michael.Hennerich@kernel.org>
From: <michael.hennerich@analog.com>
To: <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] iio: dac: ad5592r: Add ACPI support
Date: Mon, 19 Dec 2016 13:10:38 +0100
Message-ID: <1482149439-16327-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds the ACPI/PNP ID. The AD5592/3 driver core is already
designed around the unified device property API.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/dac/ad5592r.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index 6eed5b7..6a12a3c 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 
 #define AD5592R_GPIO_READBACK_EN	BIT(10)
 #define AD5592R_LDAC_READBACK_EN	BIT(6)
@@ -148,10 +149,17 @@ static const struct of_device_id ad5592r_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad5592r_of_match);
 
+static const struct acpi_device_id ad5592r_acpi_match[] = {
+	{"ADS5592", },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ad5592r_acpi_match);
+
 static struct spi_driver ad5592r_spi_driver = {
 	.driver = {
 		.name = "ad5592r",
 		.of_match_table = of_match_ptr(ad5592r_of_match),
+		.acpi_match_table = ACPI_PTR(ad5592r_acpi_match),
 	},
 	.probe = ad5592r_spi_probe,
 	.remove = ad5592r_spi_remove,
-- 
2.7.4
