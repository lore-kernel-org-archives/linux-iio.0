Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36671 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbdKWVe7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Nov 2017 16:34:59 -0500
Received: from clara (unknown [IPv6:2001:4d48:ad54:2f00:f66d:4ff:fe8f:8038])
        (Authenticated sender: luke@lukeross.name)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 115EEC5A5C
        for <linux-iio@vger.kernel.org>; Thu, 23 Nov 2017 22:34:57 +0100 (CET)
Message-ID: <1511472897.17498.11.camel@lukeross.name>
Subject: [PATCH] Linx 820 Windows tablet has a da280 mapped via ACPI
From: Luke Ross <luke@lukeross.name>
To: linux-iio@vger.kernel.org
Date: Thu, 23 Nov 2017 21:34:57 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds an ACPI table to the driver and the ACPI ID of the sensor
on the tablet.

Signed-off-by: Luke Ross <luke@lukeross.name>
---
 drivers/iio/accel/da280.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 6c214783241c..d4b555203427 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/acpi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/byteorder/generic.h>
@@ -25,7 +26,7 @@
 #define DA280_MODE_ENABLE		0x1e
 #define DA280_MODE_DISABLE		0x9e
 
-enum { da226, da280 };
+enum da280_chipset { da226, da280 };
 
 /*
  * a value of + or -4096 corresponds to + or - 1G
@@ -91,12 +92,24 @@ static const struct iio_info da280_info = {
 	.read_raw	= da280_read_raw,
 };
 
+static enum da280_chipset da280_match_acpi_device(struct device *dev)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return -EINVAL;
+
+	return (enum da280_chipset) id->driver_data;
+}
+
 static int da280_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	int ret;
 	struct iio_dev *indio_dev;
 	struct da280_data *data;
+	enum da280_chipset chip;
 
 	ret = i2c_smbus_read_byte_data(client, DA280_REG_CHIP_ID);
 	if (ret != DA280_CHIP_ID)
@@ -114,7 +127,14 @@ static int da280_probe(struct i2c_client *client,
 	indio_dev->info = &da280_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = da280_channels;
-	if (id->driver_data == da226) {
+
+	if (ACPI_HANDLE(&client->dev)) {
+		chip = da280_match_acpi_device(&client->dev);
+	} else {
+		chip = id->driver_data;
+	}
+
+	if (chip == da226) {
 		indio_dev->name = "da226";
 		indio_dev->num_channels = 2;
 	} else {
@@ -158,6 +178,12 @@ static int da280_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
 
+static const struct acpi_device_id da280_acpi_match[] = {
+	{"MIRAACC", da280},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
+
 static const struct i2c_device_id da280_i2c_id[] = {
 	{ "da226", da226 },
 	{ "da280", da280 },
@@ -168,6 +194,7 @@ MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
 static struct i2c_driver da280_driver = {
 	.driver = {
 		.name = "da280",
+		.acpi_match_table = ACPI_PTR(da280_acpi_match),
 		.pm = &da280_pm_ops,
 	},
 	.probe		= da280_probe,
-- 
2.15.0

