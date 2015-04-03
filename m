Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 4/6] iio: sx9500: refactor GPIO interrupt code
Date: Fri,  3 Apr 2015 15:47:32 +0300
Message-Id: <1428065254-6444-5-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 13b174c..d1e886c 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -831,34 +831,25 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
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
-	gpio = devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0);
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
 
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
-	ret = gpiod_to_irq(gpio);
-
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
 }
 
 static int sx9500_probe(struct i2c_client *client,
@@ -892,8 +883,7 @@ static int sx9500_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	i2c_set_clientdata(client, indio_dev);
 
-	if (client->irq <= 0)
-		client->irq = sx9500_gpio_probe(client, data);
+	sx9500_gpio_probe(client, data);
 
 	if (client->irq <= 0) {
 		dev_err(&client->dev, "no valid irq found\n");
-- 
1.9.1
