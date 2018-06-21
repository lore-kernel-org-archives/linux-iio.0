Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36769 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFUGfH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jun 2018 02:35:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so1017018pfi.3
        for <linux-iio@vger.kernel.org>; Wed, 20 Jun 2018 23:35:07 -0700 (PDT)
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, daniel.baluta@gmail.com,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [RFC 3/3] iio: imu: bme680: Add ACPI support
Date: Thu, 21 Jun 2018 12:04:37 +0530
Message-Id: <1529562877-9357-4-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support to probe the bme680 sensor on the i2c bus using
ACPI.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/iio/imu/bme680/bme680_core.c | 15 +++++++++++++++
 drivers/iio/imu/bme680/bme680_i2c.c  |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iio/imu/bme680/bme680_core.c b/drivers/iio/imu/bme680/bme680_core.c
index 05712de..a891b1f 100644
--- a/drivers/iio/imu/bme680/bme680_core.c
+++ b/drivers/iio/imu/bme680/bme680_core.c
@@ -3,6 +3,7 @@
  *
  * IIO core driver - I2C & SPI bus support
  */
+#include <linux/acpi.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -445,6 +446,17 @@ static int bme680_chip_init(struct bme680_data *data, bool use_spi)
 	return 0;
 }
 
+static const char *bme680_match_acpi_device(struct device *dev)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return NULL;
+
+	return dev_name(dev);
+}
+
 static const struct bme680_chip_info bme680_chip_info = {
 	.oversampling_temp_avail = bme680_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bme680_oversampling_avail),
@@ -480,6 +492,9 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;
 
+	if (!name && ACPI_HANDLE(dev))
+		name = bme680_match_acpi_device(dev);
+
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
 	indio_dev->channels = bme680_channels;
diff --git a/drivers/iio/imu/bme680/bme680_i2c.c b/drivers/iio/imu/bme680/bme680_i2c.c
index 1c8223e..2807085 100644
--- a/drivers/iio/imu/bme680/bme680_i2c.c
+++ b/drivers/iio/imu/bme680/bme680_i2c.c
@@ -3,6 +3,7 @@
  *	- 0x76 if SDO is pulled to GND
  *	- 0x77 if SDO is pulled to VDDIO
  */
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -41,6 +42,11 @@ static const struct i2c_device_id bme680_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
 
+static const struct acpi_device_id bme680_acpi_match[] = {
+	{"BME0680", 0},
+	{},
+};
+
 static struct i2c_driver bme680_i2c_driver = {
 	.driver = {
 		.name = "bme680_i2c",
-- 
2.7.4

