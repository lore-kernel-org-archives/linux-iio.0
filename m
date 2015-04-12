Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23549 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbbDLQxA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 12 Apr 2015 12:53:00 -0400
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH v2 3/3] iio: sx9500: add GPIO reset pin
Date: Sun, 12 Apr 2015 19:52:40 +0300
Message-Id: <1428857560-32566-4-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428857560-32566-1-git-send-email-vlad.dogaru@intel.com>
References: <1428857560-32566-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If a GPIO reset pin is listed in ACPI or Device Tree, use it to reset
the device on initialization.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 63a9dfb..04054ba 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -33,6 +33,7 @@
 #define SX9500_IRQ_NAME			"sx9500_event"
 
 #define SX9500_GPIO_INT			"interrupt"
+#define SX9500_GPIO_RESET		"reset"
 
 /* Register definitions. */
 #define SX9500_REG_IRQ_SRC		0x00
@@ -85,6 +86,7 @@ struct sx9500_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	struct regmap *regmap;
+	struct gpio_desc *gpiod_rst;
 	/*
 	 * Last reading of the proximity status for each channel.  We
 	 * only send an event to user space when this changes.
@@ -831,6 +833,13 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
 	int ret, i;
 	unsigned int val;
 
+	if (data->gpiod_rst) {
+		gpiod_set_value_cansleep(data->gpiod_rst, 0);
+		usleep_range(1000, 2000);
+		gpiod_set_value_cansleep(data->gpiod_rst, 1);
+		usleep_range(1000, 2000);
+	}
+
 	ret = regmap_write(data->regmap, SX9500_REG_IRQ_MSK, 0);
 	if (ret < 0)
 		return ret;
@@ -877,6 +886,13 @@ static void sx9500_gpio_probe(struct i2c_client *client,
 		else
 			client->irq = gpiod_to_irq(gpio);
 	}
+
+	data->gpiod_rst = devm_gpiod_get_index(dev, SX9500_GPIO_RESET,
+					       0, GPIOD_OUT_HIGH);
+	if (IS_ERR(data->gpiod_rst)) {
+		dev_warn(dev, "gpio get reset pin failed\n");
+		data->gpiod_rst = NULL;
+	}
 }
 
 static int sx9500_probe(struct i2c_client *client,
@@ -900,8 +916,6 @@ static int sx9500_probe(struct i2c_client *client,
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
-	sx9500_init_device(indio_dev);
-
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = SX9500_DRIVER_NAME;
 	indio_dev->channels = sx9500_channels;
@@ -912,6 +926,10 @@ static int sx9500_probe(struct i2c_client *client,
 
 	sx9500_gpio_probe(client, data);
 
+	ret = sx9500_init_device(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	if (client->irq <= 0)
 		dev_warn(&client->dev, "no valid irq found\n");
 	else {
-- 
1.9.1

