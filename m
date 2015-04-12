Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38312 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbbDLQw6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 12 Apr 2015 12:52:58 -0400
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH v2 2/3] iio: sx9500: refactor GPIO interrupt code
Date: Sun, 12 Apr 2015 19:52:39 +0300
Message-Id: <1428857560-32566-3-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428857560-32566-1-git-send-email-vlad.dogaru@intel.com>
References: <1428857560-32566-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 9a8cad8..63a9dfb 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -859,30 +859,24 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int sx9500_gpio_probe(struct i2c_client *client,
-			     struct sx9500_data *data)
+static void sx9500_gpio_probe(struct i2c_client *client,
+			      struct sx9500_data *data)
 {
 	struct device *dev;
 	struct gpio_desc *gpio;
-	int ret;
 
 	if (!client)
-		return -EINVAL;
+		return;
 
 	dev = &client->dev;
 
-	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0, GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "acpi gpio get index failed\n");
-		return PTR_ERR(gpio);
+	if (client->irq <= 0) {
+		gpio = devm_gpiod_get_index(dev, SX9500_GPIO_INT, 0, GPIOD_IN);
+		if (IS_ERR(gpio))
+			dev_err(dev, "gpio get irq failed\n");
+		else
+			client->irq = gpiod_to_irq(gpio);
 	}
-
-	ret = gpiod_to_irq(gpio);
-
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
 }
 
 static int sx9500_probe(struct i2c_client *client,
@@ -916,8 +910,7 @@ static int sx9500_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	i2c_set_clientdata(client, indio_dev);
 
-	if (client->irq <= 0)
-		client->irq = sx9500_gpio_probe(client, data);
+	sx9500_gpio_probe(client, data);
 
 	if (client->irq <= 0)
 		dev_warn(&client->dev, "no valid irq found\n");
-- 
1.9.1

