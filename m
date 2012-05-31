Return-Path: <leed.aguilar@ti.com>
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: Leed Aguilar <leed.aguilar@ti.com>, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2] staging:iio:magnetometer:ak8975: use gpio_request_one api
Date: Thu, 31 May 2012 09:17:11 -0400
Message-ID: <1338470231-19272-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Use gpio_request_one api, it looks cleaner.

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/ak8975.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

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
