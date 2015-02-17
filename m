Return-Path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel@pengutronix.de,
	Alexandre Courbot <acourbot@nvidia.com>,
	Mark Brown <broonie@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: improve usage of gpiod API
Date: Tue, 17 Feb 2015 10:21:21 +0100
Message-Id: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additional
parameter that allows to specify direction and initial value for
outputs.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/bmc150-accel.c | 6 +-----
 drivers/iio/accel/kxcjk-1013.c   | 6 +-----
 drivers/iio/gyro/bmg160.c        | 6 +-----
 3 files changed, 3 insertions(+), 15 deletions(-)

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
index da2fe93739a2..d0a140fd7a9e 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1155,16 +1155,12 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
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
-- 
2.1.4
