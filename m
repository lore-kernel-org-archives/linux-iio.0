Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2on0064.outbound.protection.outlook.com ([207.46.100.64]:35283
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751674AbbKRKvf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Nov 2015 05:51:35 -0500
From: Dragos Bogdan <dragos.bogdan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v2] staging:iio:ad7780: Switch to the gpio descriptor interface
Date: Wed, 18 Nov 2015 12:35:34 +0200
Message-ID: <1447842934-5355-1-git-send-email-dragos.bogdan@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the gpiod interface for the powerdown_gpio instead of the deprecated
old non-descriptor interface.

The powerdown pin can be tied high, so the gpio is optional.
Remove the gpio_pdrst platform_data member since the new interface is
used.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
---
Changes since first version:
Remove <linux/gpio.h> include since it is no longer needed.
---
 drivers/staging/iio/adc/ad7780.c | 27 +++++++++++----------------
 drivers/staging/iio/adc/ad7780.h |  1 -
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 618b41f..98b5fc4 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -15,7 +15,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/sched.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
@@ -42,7 +42,7 @@ struct ad7780_chip_info {
 struct ad7780_state {
 	const struct ad7780_chip_info	*chip_info;
 	struct regulator		*reg;
-	int				powerdown_gpio;
+	struct gpio_desc		*powerdown_gpio;
 	unsigned int	gain;
 	u16				int_vref_mv;
 
@@ -77,8 +77,7 @@ static int ad7780_set_mode(struct ad_sigma_delta *sigma_delta,
 		break;
 	}
 
-	if (gpio_is_valid(st->powerdown_gpio))
-		gpio_set_value(st->powerdown_gpio, val);
+	gpiod_set_value(st->powerdown_gpio, val);
 
 	return 0;
 }
@@ -205,18 +204,14 @@ static int ad7780_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->info = &ad7780_info;
 
-	if (pdata && gpio_is_valid(pdata->gpio_pdrst)) {
-		ret = devm_gpio_request_one(&spi->dev,
-					    pdata->gpio_pdrst,
-					    GPIOF_OUT_INIT_LOW,
-					    "AD7780 /PDRST");
-		if (ret) {
-			dev_err(&spi->dev, "failed to request GPIO PDRST\n");
-			goto error_disable_reg;
-		}
-		st->powerdown_gpio = pdata->gpio_pdrst;
-	} else {
-		st->powerdown_gpio = -1;
+	st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
+						     "powerdown",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(st->powerdown_gpio)) {
+		ret = PTR_ERR(st->powerdown_gpio);
+		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
+			ret);
+		goto error_disable_reg;
 	}
 
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7780.h b/drivers/staging/iio/adc/ad7780.h
index 67e511c..46f61c9 100644
--- a/drivers/staging/iio/adc/ad7780.h
+++ b/drivers/staging/iio/adc/ad7780.h
@@ -24,7 +24,6 @@
 
 struct ad7780_platform_data {
 	u16				vref_mv;
-	int				gpio_pdrst;
 };
 
 #endif /* IIO_ADC_AD7780_H_ */
-- 
2.1.4

