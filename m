Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbBRMrZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 07:47:25 -0500
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: kernel@pengutronix.de, Alexandre Courbot <acourbot@nvidia.com>,
	Mark Brown <broonie@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH v3] iio: improve usage of gpiod API
Date: Wed, 18 Feb 2015 13:47:11 +0100
Message-Id: <1424263631-18876-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additional
parameter that allows to specify direction and initial value for
outputs.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

Notes:
    Changes since v2, sent with Message-Id:
    1424255921-6429-1-git-send-email-u.kleine-koenig@pengutronix.de
    
     - also fix drivers/iio/accel/mma9553.c

 drivers/iio/accel/bmc150-accel.c | 6 +-----
 drivers/iio/accel/kxcjk-1013.c   | 6 +-----
 drivers/iio/accel/mma9551.c      | 7 ++-----
 drivers/iio/accel/mma9553.c      | 6 +-----
 drivers/iio/gyro/bmg160.c        | 6 +-----
 drivers/iio/imu/kmx61.c          | 6 +-----
 drivers/iio/proximity/sx9500.c   | 6 +-----
 7 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 066d0c04072c..9f208755eb66 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -1176,16 +1176,12 @@ static int bmc150_accel_gpio_probe(struct i2c_client *client,
 	dev = &client->dev;
 
 	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, BMC150_ACCEL_GPIO_NAME, 0);
+	gpio = devm_gpiod_get_index(dev, BMC150_ACCEL_GPIO_NAME, 0, GPIOD_IN);
 	if (IS_ERR(gpio)) {
 		dev_err(dev, "Failed: gpio get index\n");
 		return PTR_ERR(gpio);
 	}
 
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
 	ret = gpiod_to_irq(gpio);
 
 	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 567de269cc00..a98b5d212fb3 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1169,16 +1169,12 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
 	dev = &client->dev;
 
 	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, "kxcjk1013_int", 0);
+	gpio = devm_gpiod_get_index(dev, "kxcjk1013_int", 0, GPIOD_IN);
 	if (IS_ERR(gpio)) {
 		dev_err(dev, "acpi gpio get index failed\n");
 		return PTR_ERR(gpio);
 	}
 
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
 	ret = gpiod_to_irq(gpio);
 
 	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 46c38351c6a3..1277f407cd12 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -418,16 +418,13 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 	struct device *dev = &data->client->dev;
 
 	for (i = 0; i < MMA9551_GPIO_COUNT; i++) {
-		gpio = devm_gpiod_get_index(dev, MMA9551_GPIO_NAME, i);
+		gpio = devm_gpiod_get_index(dev, MMA9551_GPIO_NAME, i,
+					    GPIOD_IN);
 		if (IS_ERR(gpio)) {
 			dev_err(dev, "acpi gpio get index failed\n");
 			return PTR_ERR(gpio);
 		}
 
-		ret = gpiod_direction_input(gpio);
-		if (ret)
-			return ret;
-
 		data->irqs[i] = gpiod_to_irq(gpio);
 		ret = devm_request_threaded_irq(dev, data->irqs[i],
 				NULL, mma9551_event_handler,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index d23ebf192f63..2df1af7d43fc 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1109,16 +1109,12 @@ static int mma9553_gpio_probe(struct i2c_client *client)
 	dev = &client->dev;
 
 	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, MMA9553_GPIO_NAME, 0);
+	gpio = devm_gpiod_get_index(dev, MMA9553_GPIO_NAME, 0, GPIOD_IN);
 	if (IS_ERR(gpio)) {
 		dev_err(dev, "acpi gpio get index failed\n");
 		return PTR_ERR(gpio);
 	}
 
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
 	ret = gpiod_to_irq(gpio);
 
 	dev_dbg(dev, "gpio resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 60451b328242..56d68e1d0987 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -1001,16 +1001,12 @@ static int bmg160_gpio_probe(struct i2c_client *client,
 	dev = &client->dev;
 
 	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, BMG160_GPIO_NAME, 0);
+	gpio = devm_gpiod_get_index(dev, BMG160_GPIO_NAME, 0, GPIOD_IN);
 	if (IS_ERR(gpio)) {
 		dev_err(dev, "acpi gpio get index failed\n");
 		return PTR_ERR(gpio);
 	}
 
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
 	ret = gpiod_to_irq(gpio);
 
 	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 5cc3692acf37..adba9dcae788 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1267,16 +1267,12 @@ static int kmx61_gpio_probe(struct i2c_client *client, struct kmx61_data *data)
 	dev = &client->dev;
 
 	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, KMX61_GPIO_NAME, 0);
+	gpio = devm_gpiod_get_index(dev, KMX61_GPIO_NAME, 0, GPIOD_IN);
 	if (IS_ERR(gpio)) {
 		dev_err(dev, "acpi gpio get index failed\n");
 		return PTR_ERR(gpio);
 	}
 
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
 	ret = gpiod_to_irq(gpio);
 
 	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 74dff4e4a11a..0b4d79490b05 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -618,16 +618,12 @@ static int sx9500_gpio_probe(struct i2c_client *client,
 	dev = &client->dev;
 
 	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0);
+	gpio = devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0, GPIOD_IN);
 	if (IS_ERR(gpio)) {
 		dev_err(dev, "acpi gpio get index failed\n");
 		return PTR_ERR(gpio);
 	}
 
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
 	ret = gpiod_to_irq(gpio);
 
 	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-- 
2.1.4

