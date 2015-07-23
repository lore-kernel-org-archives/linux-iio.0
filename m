Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:35195 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbbGWPtj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 11:49:39 -0400
Received: from mrelay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id EC4B349651A
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 17:22:34 +0200 (CEST)
Received: from mfilter49-d.gandi.net (mfilter49-d.gandi.net [217.70.178.180])
	by mrelay2-d.mail.gandi.net (Postfix) with ESMTP id 1544AC5A50
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 17:22:34 +0200 (CEST)
Received: from mrelay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter49-d.gandi.net (mfilter49-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id mIp607ydep39 for <linux-iio@vger.kernel.org>;
	Thu, 23 Jul 2015 17:22:32 +0200 (CEST)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by mrelay2-d.mail.gandi.net (Postfix) with ESMTPSA id 586FFC5A48
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 17:22:32 +0200 (CEST)
Message-ID: <1437664867.2863.13.camel@hadess.net>
Subject: [PATCH 2/2] iio:accel:bmc150-accel: Use the chip ID to detect
 sensor variant
From: Bastien Nocera <hadess@hadess.net>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 23 Jul 2015 17:21:07 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Instead of using the I2C or ACPI ID to determine which variant of
the chipset to use, determine that from the chip ID.

Under Windows, the same driver is used for those variants and, despite
incorrect ACPI data, it is able to load and operate the accelerometer.

Fixes the accelerometer failing with:
bmc150_accel i2c-BMA250E:00: Invalid chip f8
on the WinBook TW100

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/iio/accel/bmc150-accel.c | 46 +++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 2ec9b56..7df221c 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -151,6 +151,7 @@ struct bmc150_scale_info {
 };
 
 struct bmc150_accel_chip_info {
+	const char *name;
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
@@ -1061,6 +1062,7 @@ enum {
 
 static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 	[bmc150] = {
+		.name = "BMC150A",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
@@ -1070,6 +1072,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	[bmi055] = {
+		.name = "BMI055A",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
@@ -1079,6 +1082,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	[bma255] = {
+		.name = "BMA0255",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
@@ -1088,6 +1092,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {76590, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	[bma250e] = {
+		.name = "BMA250E",
 		.chip_id = 0xF9,
 		.channels = bma250e_accel_channels,
 		.num_channels = ARRAY_SIZE(bma250e_accel_channels),
@@ -1097,6 +1102,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	[bma222e] = {
+		.name = "BMA222E",
 		.chip_id = 0xF8,
 		.channels = bma222e_accel_channels,
 		.num_channels = ARRAY_SIZE(bma222e_accel_channels),
@@ -1106,6 +1112,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	[bma280] = {
+		.name = "BMA0280",
 		.chip_id = 0xFB,
 		.channels = bma280_accel_channels,
 		.num_channels = ARRAY_SIZE(bma280_accel_channels),
@@ -1344,20 +1351,6 @@ static irqreturn_t bmc150_accel_irq_handler(int irq, void *private)
 	return IRQ_NONE;
 }
 
-static const char *bmc150_accel_match_acpi_device(struct device *dev, int *data)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-
-	if (!id)
-		return NULL;
-
-	*data = (int) id->driver_data;
-
-	return dev_name(dev);
-}
-
 static int bmc150_accel_gpio_probe(struct i2c_client *client,
 					struct bmc150_accel_data *data)
 {
@@ -1554,7 +1547,7 @@ static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
 
 static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 {
-	int ret;
+	int ret, i;
 
 	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
 	if (ret < 0) {
@@ -1564,8 +1557,15 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 	}
 
 	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
-	if (ret != data->chip_info->chip_id) {
-		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
+	for (i = 0; i < ARRAY_SIZE(bmc150_accel_chip_info_tbl); i++) {
+		if (bmc150_accel_chip_info_tbl[i].chip_id == ret) {
+			data->chip_info = &bmc150_accel_chip_info_tbl[i];
+			break;
+		}
+	}
+
+	if (!data->chip_info) {
+		dev_err(&data->client->dev, "Unsupported chip %x\n", ret);
 		return -ENODEV;
 	}
 
@@ -1618,7 +1618,6 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
 	const char *name = NULL;
-	int chip_id = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -1628,15 +1627,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	if (id) {
+	if (id)
 		name = id->name;
-		chip_id = id->driver_data;
-	}
-
-	if (ACPI_HANDLE(&client->dev))
-		name = bmc150_accel_match_acpi_device(&client->dev, &chip_id);
-
-	data->chip_info = &bmc150_accel_chip_info_tbl[chip_id];
 
 	ret = bmc150_accel_chip_init(data);
 	if (ret < 0)
@@ -1647,7 +1639,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
-	indio_dev->name = name;
+	indio_dev->name = name ? name : data->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
 
-- 
2.4.3
