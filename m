Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33825 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbcFQPMu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2016 11:12:50 -0400
Received: by mail-lf0-f52.google.com with SMTP id j7so596550lfg.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2016 08:12:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4] iio: pressure: bmp280: add reset GPIO line handling
Date: Fri, 17 Jun 2016 17:12:20 +0200
Message-Id: <1466176341-17442-3-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
References: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On the APQ8060 Dragonboard the reset line to the BMP058 pressure
sensor is not deasserted on boot, so the driver needs to handle
this. For a simple GPIO line supplied as a descriptor (from a board
file, device tree or ACPI) this does the trick.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 86dd11edd3c2..f304ce42aa52 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/gpio/consumer.h>
 
 /* BMP280 specific registers */
 #define BMP280_REG_TEMP_XLSB		0xFC
@@ -838,6 +839,7 @@ static int bmp280_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct bmp280_data *data;
 	unsigned int chip_id;
+	struct gpio_desc *gpiod;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -869,6 +871,14 @@ static int bmp280_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	/* Bring chip out of reset if there is an assigned GPIO line */
+	gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
+	/* Deassert the signal */
+	if (!IS_ERR(gpiod)) {
+		dev_info(&client->dev, "release reset\n");
+		gpiod_set_value(gpiod, 0);
+	}
+
 	data->regmap = devm_regmap_init_i2c(client,
 					data->chip_info->regmap_config);
 	if (IS_ERR(data->regmap)) {
-- 
2.4.11

