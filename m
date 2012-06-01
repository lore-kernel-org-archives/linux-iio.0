Return-Path: <leed.aguilar@ti.com>
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: Leed Aguilar <leed.aguilar@ti.com>, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3] staging:iio:magnetometer:ak8975: use gpio_request_one api
Date: Fri, 1 Jun 2012 11:36:46 -0400
Message-ID: <1338565006-5682-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Use gpio_request_one api, it looks cleaner.

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/Kconfig  |    2 +-
 drivers/staging/iio/magnetometer/ak8975.c |   10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
index 722c4e1..e81dd9c 100644
--- a/drivers/staging/iio/magnetometer/Kconfig
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -6,7 +6,7 @@ menu "Magnetometer sensors"
 config SENSORS_AK8975
 	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
 	depends on I2C
-	depends on GENERIC_GPIO
+	depends on GPIOLIB
 	help
 	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
 	  Magnetometer.
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index ebc2d08..52833cd 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -487,21 +487,13 @@ static int ak8975_probe(struct i2c_client *client,
 	/* We may not have a GPIO based IRQ to scan, that is fine, we will
 	   poll if so */
 	if (gpio_is_valid(eoc_gpio)) {
-		err = gpio_request(eoc_gpio, "ak_8975");
+		err = gpio_request_one(eoc_gpio, GPIOF_IN, "ak_8975");
 		if (err < 0) {
 			dev_err(&client->dev,
 				"failed to request GPIO %d, error %d\n",
 							eoc_gpio, err);
 			goto exit;
 		}
-
-		err = gpio_direction_input(eoc_gpio);
-		if (err < 0) {
-			dev_err(&client->dev,
-				"Failed to configure input direction for GPIO %d, error %d\n",
-						eoc_gpio, err);
-			goto exit_gpio;
-		}
 	}
 
 	/* Register with IIO */
-- 
1.7.1
