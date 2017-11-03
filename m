Return-Path: <SRS0=1Hpq=CB=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] iio: proximity: sx9500: Set IRQ pin to direction-input if necessary
Date: Fri,  3 Nov 2017 15:03:38 +0200
Message-Id: <20171103130340.42459-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

With the new more strict ACPI gpio code the DSDT's IoRestriction flags
are honored on gpiod_get(), but in some DSDT's it is wrong, so explicitly
call gpiod_direction_input() on the IRQ GPIO if necessary.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx9500.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index eb687b3dd442..3cf054155779 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
@@ -892,8 +893,13 @@ static void sx9500_gpio_probe(struct i2c_client *client,
 		gpiod_int = devm_gpiod_get(dev, "interrupt", GPIOD_IN);
 		if (IS_ERR(gpiod_int))
 			dev_err(dev, "gpio get irq failed\n");
-		else
+		else {
+			if (gpiod_get_direction(gpiod_int) != GPIOF_DIR_IN) {
+				dev_warn(dev, FW_BUG "IRQ GPIO not in input mode, fixing\n");
+				gpiod_direction_input(gpiod_int);
+			}
 			client->irq = gpiod_to_irq(gpiod_int);
+		}
 	}
 
 	data->gpiod_rst = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-- 
2.14.2
