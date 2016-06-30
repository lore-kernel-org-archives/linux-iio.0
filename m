Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34466 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbcF3BtK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 21:49:10 -0400
Received: by mail-lf0-f46.google.com with SMTP id h129so45219794lfh.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2016 18:49:09 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/10 v4] iio: pressure: bmp280: add reset GPIO line handling
Date: Thu, 30 Jun 2016 03:48:47 +0200
Message-Id: <1467251334-30594-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On the APQ8060 Dragonboard the reset line to the BMP085 pressure
sensor is not deasserted on boot, so the driver needs to handle
this. For a simple GPIO line supplied as a descriptor (from a board
file, device tree or ACPI) this does the trick.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Fix BMP058->BMP085 in commit message
ChangeLog v2->v3:
- None, just rebasing/resending
---
 drivers/iio/pressure/bmp280.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index fa76f5851245..1618968f8889 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/gpio/consumer.h>
 
 /* BMP280 specific registers */
 #define BMP280_REG_HUMIDITY_LSB		0xFE
@@ -1024,6 +1025,7 @@ static int bmp280_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct bmp280_data *data;
 	unsigned int chip_id;
+	struct gpio_desc *gpiod;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -1063,6 +1065,14 @@ static int bmp280_probe(struct i2c_client *client,
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

