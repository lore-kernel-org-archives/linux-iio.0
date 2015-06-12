Return-Path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: kernel@pengutronix.de,
	Alexandre Courbot <gnurou@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: stk3310: use flags argument of devm_gpiod_get
Date: Fri, 12 Jun 2015 09:51:46 +0200
Message-Id: <1434095506-1581-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additional
parameter that allows to specify direction and initial value for output.

Simplify driver accordingly. Furthermore this is one caller less that
stops us making the flags argument to gpiod_get*() mandatory.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch applies to next and is only necessary on top of 3dd477acbdd1
(iio: light: Add threshold interrupt support for STK3310) which
currently sits in next.

Note I plan to make the flags parameter mandatory for 4.3. So unless
this change gets into 4.2, would it be ok to let it go in via the gpio
tree?

Best regards
Uwe

 drivers/iio/light/stk3310.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e79b9d89b024..504d1e9b4c02 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -488,16 +488,12 @@ static int stk3310_gpio_probe(struct i2c_client *client)
 	dev = &client->dev;
 
 	/* gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, STK3310_GPIO, 0);
+	gpio = devm_gpiod_get_index(dev, STK3310_GPIO, 0, GPIOD_IN);
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
