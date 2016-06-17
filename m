Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35099 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbcFQPMs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2016 11:12:48 -0400
Received: by mail-lf0-f52.google.com with SMTP id l188so568539lfe.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2016 08:12:47 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4] iio: pressure: bmp280: support optional supply regulators
Date: Fri, 17 Jun 2016 17:12:21 +0200
Message-Id: <1466176341-17442-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
References: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The BMP058/BMP180/BMP280 is supplied with two power sources:
VDDA (analog power) and VDDD (digital power). As these may come
from regulators (as on the APQ8060 Dragonboard) we need the driver
to attempt to fetch and enable these regulators.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index f304ce42aa52..7d4735e28b82 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -23,6 +23,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 /* BMP280 specific registers */
 #define BMP280_REG_TEMP_XLSB		0xFC
@@ -101,6 +102,8 @@ struct bmp280_data {
 	struct mutex lock;
 	struct regmap *regmap;
 	const struct bmp280_chip_info *chip_info;
+	struct regulator *vddd;
+	struct regulator *vdda;
 
 	/* log of base 2 of oversampling rate */
 	u8 oversampling_press;
@@ -871,6 +874,20 @@ static int bmp280_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	/* Optionally bring up regulators */
+	data->vddd = devm_regulator_get_optional(&client->dev, "vddd");
+	if (!IS_ERR(data->vddd)) {
+		ret = regulator_enable(data->vddd);
+		if (ret)
+			dev_err(&client->dev, "failed to enable VDDD\n");
+	}
+	data->vdda = devm_regulator_get_optional(&client->dev, "vdda");
+	if (!IS_ERR(data->vdda)) {
+		ret = regulator_enable(data->vdda);
+		if (ret)
+			dev_err(&client->dev, "failed to enable VDDA\n");
+	}
+
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
 	/* Deassert the signal */
-- 
2.4.11

