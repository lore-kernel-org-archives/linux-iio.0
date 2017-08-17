Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:58106 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbdHQWKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 18:10:02 -0400
Date: Fri, 18 Aug 2017 00:10:11 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, hdegoede@redhat.com, wsa@the-dreams.de,
        chris.packham@alliedtelesis.co.nz, jelle@vdwaa.nl,
        devicetree@vger.kernel.org
Subject: [PATCH v4 5/5] iio: srf08: add support for srf02 in i2c mode
Message-ID: <20170817221011.GA4847@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

srf02 added with support for i2c interface

Attributes for setting max range or sensitivity are omitted for the case of
srf02 type sensor, because they are not supported by the hardware.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig |  8 ++---
 drivers/iio/proximity/srf08.c | 81 +++++++++++++++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index df33ccc0d035..ae070950f920 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -57,12 +57,12 @@ config SX9500
 	  module will be called sx9500.
 
 config SRF08
-	tristate "Devantech SRF08/SRF10 ultrasonic ranger sensor"
+	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
 	depends on I2C
 	help
-	  Say Y here to build a driver for Devantech SRF08/SRF10 ultrasonic
-	  ranger sensor. This driver can be used to measure the distance
-	  of objects.
+	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
+	  ultrasonic ranger sensors with i2c interface.
+	  This driver can be used to measure the distance of objects.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf08.
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 1f9b03944da4..9380d545aab1 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -1,17 +1,18 @@
 /*
  * srf08.c - Support for Devantech SRFxx ultrasonic ranger
  *           with i2c interface
- * actually supported are srf08, srf10
+ * actually supported are srf02, srf08, srf10
  *
- * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
+ * Copyright (c) 2016, 2017 Andreas Klinger <ak@it-klinger.de>
  *
  * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
+ * the GNU General Public License. See the file COPYING in the main
  * directory of this archive for more details.
  *
  * For details about the device see:
  * http://www.robot-electronics.co.uk/htm/srf08tech.html
  * http://www.robot-electronics.co.uk/htm/srf10tech.htm
+ * http://www.robot-electronics.co.uk/htm/srf02tech.htm
  */
 
 #include <linux/err.h>
@@ -36,9 +37,8 @@
 
 #define SRF08_CMD_RANGING_CM	0x51	/* Ranging Mode - Result in cm */
 
-#define SRF08_DEFAULT_RANGE	6020	/* default value of Range in mm */
-
 enum srf08_sensor_type {
+	SRF02,
 	SRF08,
 	SRF10,
 	SRF_MAX_TYPE
@@ -48,6 +48,9 @@ struct srf08_chip_info {
 	const int		*sensitivity_avail;
 	int			num_sensitivity_avail;
 	int			sensitivity_default;
+
+	/* default value of Range in mm */
+	int			range_default;
 };
 
 struct srf08_data {
@@ -83,6 +86,14 @@ struct srf08_data {
  * But with ADC's this term is already used differently and that's why it
  * is called "Sensitivity" here.
  */
+static const struct srf08_chip_info srf02_chip_info = {
+	.sensitivity_avail	= NULL,
+	.num_sensitivity_avail	= 0,
+	.sensitivity_default	= 0,
+
+	.range_default		= 0,
+};
+
 static const int srf08_sensitivity_avail[] = {
 	 94,  97, 100, 103, 107, 110, 114, 118,
 	123, 128, 133, 139, 145, 152, 159, 168,
@@ -94,6 +105,8 @@ static const struct srf08_chip_info srf08_chip_info = {
 	.sensitivity_avail	= srf08_sensitivity_avail,
 	.num_sensitivity_avail	= ARRAY_SIZE(srf08_sensitivity_avail),
 	.sensitivity_default	= 1025,
+
+	.range_default		= 6020,
 };
 
 static const int srf10_sensitivity_avail[] = {
@@ -106,6 +119,8 @@ static const struct srf08_chip_info srf10_chip_info = {
 	.sensitivity_avail	= srf10_sensitivity_avail,
 	.num_sensitivity_avail	= ARRAY_SIZE(srf10_sensitivity_avail),
 	.sensitivity_default	= 700,
+
+	.range_default		= 6020,
 };
 
 static int srf08_read_ranging(struct srf08_data *data)
@@ -424,6 +439,15 @@ static const struct iio_info srf08_info = {
 	.driver_module = THIS_MODULE,
 };
 
+/*
+ * srf02 don't have an adjustable range or sensitivity,
+ * so we don't need attributes at all
+ */
+static const struct iio_info srf02_info = {
+	.read_raw = srf08_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int srf08_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
@@ -447,11 +471,17 @@ static int srf08_probe(struct i2c_client *client,
 	data->sensor_type = (enum srf08_sensor_type)id->driver_data;
 
 	switch (data->sensor_type) {
+	case SRF02:
+		data->chip_info = &srf02_chip_info;
+		indio_dev->info = &srf02_info;
+		break;
 	case SRF08:
 		data->chip_info = &srf08_chip_info;
+		indio_dev->info = &srf08_info;
 		break;
 	case SRF10:
 		data->chip_info = &srf10_chip_info;
+		indio_dev->info = &srf08_info;
 		break;
 	default:
 		return -EINVAL;
@@ -460,7 +490,6 @@ static int srf08_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &srf08_info;
 	indio_dev->channels = srf08_channels;
 	indio_dev->num_channels = ARRAY_SIZE(srf08_channels);
 
@@ -473,24 +502,39 @@ static int srf08_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/*
-	 * set default values of device here
-	 * these register values cannot be read from the hardware
-	 * therefore set driver specific default values
-	 */
-	ret = srf08_write_range_mm(data, SRF08_DEFAULT_RANGE);
-	if (ret < 0)
-		return ret;
+	if (data->chip_info->range_default) {
+		/*
+		 * set default range of device in mm here
+		 * these register values cannot be read from the hardware
+		 * therefore set driver specific default values
+		 *
+		 * srf02 don't have a default value so it'll be omitted
+		 */
+		ret = srf08_write_range_mm(data,
+					data->chip_info->range_default);
+		if (ret < 0)
+			return ret;
+	}
 
-	ret = srf08_write_sensitivity(data,
+	if (data->chip_info->sensitivity_default) {
+		/*
+		 * set default sensitivity of device here
+		 * these register values cannot be read from the hardware
+		 * therefore set driver specific default values
+		 *
+		 * srf02 don't have a default value so it'll be omitted
+		 */
+		ret = srf08_write_sensitivity(data,
 				data->chip_info->sensitivity_default);
-	if (ret < 0)
-		return ret;
+		if (ret < 0)
+			return ret;
+	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct of_device_id of_srf08_match[] = {
+	{ .compatible = "devantech,srf02", (void *)SRF02},
 	{ .compatible = "devantech,srf08", (void *)SRF08},
 	{ .compatible = "devantech,srf10", (void *)SRF10},
 	{},
@@ -499,6 +543,7 @@ static const struct of_device_id of_srf08_match[] = {
 MODULE_DEVICE_TABLE(of, of_srf08_match);
 
 static const struct i2c_device_id srf08_id[] = {
+	{ "srf02", SRF02 },
 	{ "srf08", SRF08 },
 	{ "srf10", SRF10 },
 	{ }
@@ -516,5 +561,5 @@ static struct i2c_driver srf08_driver = {
 module_i2c_driver(srf08_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("Devantech SRF08/SRF10 ultrasonic ranger driver");
+MODULE_DESCRIPTION("Devantech SRF02/SRF08/SRF10 i2c ultrasonic ranger driver");
 MODULE_LICENSE("GPL");
-- 
2.1.4


-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
