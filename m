Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36147 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754313AbdBPKC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2017 05:02:57 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 4/4] iio: accel: adxl345: Add ACPI support
Date: Thu, 16 Feb 2017 18:02:07 +0800
Message-Id: <1487239327-21406-5-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow probing the adxl345 on both I2C and SPI protocols using ACPI.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/iio/accel/adxl345_i2c.c | 9 +++++++++
 drivers/iio/accel/adxl345_spi.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index b114eb0..13080ff 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -12,6 +12,7 @@
  * 0x53 (ALT ADDRESS pin grounded)
  */
 
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -54,9 +55,17 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
+static const struct acpi_device_id adxl345_acpi_id[] = {
+	{ "ADX0345", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, adxl345_acpi_id);
+
 static struct i2c_driver adxl345_i2c_driver = {
 	.driver = {
 		.name	= "adxl345_i2c",
+		.acpi_match_table = ACPI_PTR(adxl345_acpi_id),
 	},
 	.probe		= adxl345_i2c_probe,
 	.remove		= adxl345_i2c_remove,
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 5fcd1fa..3f2a1db 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -10,6 +10,7 @@
  * SPI driver for ADXL345
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
@@ -59,9 +60,17 @@ static const struct spi_device_id adxl345_spi_id[] = {
 
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
+static const struct acpi_device_id adxl345_acpi_id[] = {
+	{ "ADX0345", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, adxl345_acpi_id);
+
 static struct spi_driver adxl345_spi_driver = {
 	.driver = {
 		.name	= "adxl345_spi",
+		.acpi_match_table = ACPI_PTR(adxl345_acpi_id),
 	},
 	.probe		= adxl345_spi_probe,
 	.remove		= adxl345_spi_remove,
-- 
2.7.4

