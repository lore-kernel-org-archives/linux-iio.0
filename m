Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/9 v2] iio: pressure: bmp280: add reset GPIO line handling
Date: Wed, 22 Jun 2016 22:53:33 +0200
Message-Id: <1466628819-29784-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On the APQ8060 Dragonboard the reset line to the BMP058 pressure
sensor is not deasserted on boot, so the driver needs to handle
this. For a simple GPIO line supplied as a descriptor (from a board
file, device tree or ACPI) this does the trick.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 655e888ef8f9..f7fd98e93850 100644
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
