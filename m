Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:41903 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbcKLKVr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 05:21:47 -0500
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH] iio: twl4030-madc: convert to DT only
Date: Sat, 12 Nov 2016 12:21:36 +0200
Message-ID: <1478946096-1314-1-git-send-email-Nicolae_Rosia@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All users are DT only and it makes no sense to keep dead code.
twl4030_madc_platform_data is unused and can now be removed
from include/i2c/twl.h

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/iio/adc/Kconfig        |  1 +
 drivers/iio/adc/twl4030-madc.c | 14 ++++----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 99c0514..e7cd9b1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -528,6 +528,7 @@ config TI_AM335X_ADC
 config TWL4030_MADC
 	tristate "TWL4030 MADC (Monitoring A/D Converter)"
 	depends on TWL4030_CORE
+	depends on OF
 	help
 	  This driver provides support for Triton TWL4030-MADC. The
 	  driver supports both RT and SW conversion methods.
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 0c74869..885dbf2 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -745,14 +745,13 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
 static int twl4030_madc_probe(struct platform_device *pdev)
 {
 	struct twl4030_madc_data *madc;
-	struct twl4030_madc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	int irq, ret;
 	u8 regval;
 	struct iio_dev *iio_dev = NULL;
 
-	if (!pdata && !np) {
-		dev_err(&pdev->dev, "neither platform data nor Device Tree node available\n");
+	if (!np) {
+		dev_err(&pdev->dev, "no DT info\n");
 		return -EINVAL;
 	}
 
@@ -778,11 +777,8 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	 * the OMAP. The other one can be connected to the other processor such
 	 * as modem. Hence two separate ISR and IMR registers.
 	 */
-	if (pdata)
-		madc->use_second_irq = (pdata->irq_line != 1);
-	else
-		madc->use_second_irq = of_property_read_bool(np,
-				       "ti,system-uses-second-madc-irq");
+	madc->use_second_irq = of_property_read_bool(np,
+			       "ti,system-uses-second-madc-irq");
 
 	madc->imr = madc->use_second_irq ? TWL4030_MADC_IMR2 :
 					   TWL4030_MADC_IMR1;
@@ -903,13 +899,11 @@ static int twl4030_madc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id twl_madc_of_match[] = {
 	{ .compatible = "ti,twl4030-madc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, twl_madc_of_match);
-#endif
 
 static struct platform_driver twl4030_madc_driver = {
 	.probe = twl4030_madc_probe,
-- 
2.5.5

