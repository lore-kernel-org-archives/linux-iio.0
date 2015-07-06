Return-Path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	kernel@pengutronix.de,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH gpio-for-next 04/10] iio: magn: bmc150: use flags argument of devm_gpiod_get
Date: Mon,  6 Jul 2015 11:09:44 +0200
Message-Id: <1436173790-29963-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20150706090759.GS11824@pengutronix.de>
References: <20150706090759.GS11824@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additional
parameter that allows to specify direction and initial value for output.

Simplify driver accordingly. Furthermore this is one caller less that
stops us making the flags argument to gpiod_get*() mandatory.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/magnetometer/bmc150_magn.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d4c178869991..187a31fdc35a 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -839,16 +839,12 @@ static int bmc150_magn_gpio_probe(struct i2c_client *client)
 	dev = &client->dev;
 
 	/* data ready GPIO interrupt pin */
-	gpio = devm_gpiod_get_index(dev, BMC150_MAGN_GPIO_INT, 0);
+	gpio = devm_gpiod_get_index(dev, BMC150_MAGN_GPIO_INT, 0, GPIOD_IN);
 	if (IS_ERR(gpio)) {
 		dev_err(dev, "ACPI GPIO get index failed\n");
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
