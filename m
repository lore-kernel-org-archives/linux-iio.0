Return-Path: <SRS0=vy6h=5P=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: proximity: sx9500: Use devm_gpiod_get()
Date: Sat, 10 Jun 2017 22:08:21 +0300
Message-Id: <20170610190821.53499-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Since index is always 0 replace devm_gpiod_get_index() by devm_gpiod_get().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx9500.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 9ea147f1a50d..f42b3a1c75ff 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -878,8 +878,7 @@ static void sx9500_gpio_probe(struct i2c_client *client,
 
 	dev = &client->dev;
 
-	data->gpiod_rst = devm_gpiod_get_index(dev, SX9500_GPIO_RESET,
-					       0, GPIOD_OUT_HIGH);
+	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET, GPIOD_OUT_HIGH);
 	if (IS_ERR(data->gpiod_rst)) {
 		dev_warn(dev, "gpio get reset pin failed\n");
 		data->gpiod_rst = NULL;
-- 
2.11.0
