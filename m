Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59994 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757132AbcJSRHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/13] staging:iio:ad7606: Remove default device configuration from platform data
Date: Wed, 19 Oct 2016 19:06:58 +0200
Message-Id: <1476896828-10544-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

While for some very selected setups it might be useful to be able to
provide default configuration data via the platform data, generally this
becomes very impractical as the number of configuration options increases.
So the general policy is to use the power-on default values of the device
and let the application using the device configure it according to its
needs.

Implement this scheme for the ad7606 driver by removing support for
specifying a default configuration via the platform data.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606.h      |  4 ----
 drivers/staging/iio/adc/ad7606_core.c | 12 ++----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 380c56a..cf6be65 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -15,8 +15,6 @@
 
 /**
  * struct ad7606_platform_data - platform/board specific information
- * @default_os:		default oversampling value {0, 2, 4, 8, 16, 32, 64}
- * @default_range:	default range +/-{5000, 10000} mVolt
  * @gpio_convst:	number of gpio connected to the CONVST pin
  * @gpio_reset:		gpio connected to the RESET pin, if not used set to -1
  * @gpio_range:		gpio connected to the RANGE pin, if not used set to -1
@@ -28,8 +26,6 @@
  */
 
 struct ad7606_platform_data {
-	unsigned int			default_os;
-	unsigned int			default_range;
 	unsigned int			gpio_convst;
 	unsigned int			gpio_reset;
 	unsigned int			gpio_range;
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 1093647..a16c6f5 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -452,16 +452,8 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	st->dev = dev;
 	st->bops = bops;
 	st->base_address = base_address;
-	st->range = pdata->default_range == 10000 ? 10000 : 5000;
-
-	ret = ad7606_oversampling_get_index(pdata->default_os);
-	if (ret < 0) {
-		dev_warn(dev, "oversampling %d is not supported\n",
-			 pdata->default_os);
-		st->oversampling = 0;
-	} else {
-		st->oversampling = pdata->default_os;
-	}
+	st->range = 5000;
+	st->oversampling = 0;
 
 	st->reg = devm_regulator_get(dev, "vcc");
 	if (!IS_ERR(st->reg)) {
-- 
2.1.4

