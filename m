Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:9921 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdFVMtl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Jun 2017 08:49:41 -0400
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH] iio: adc: at91-sama5d2_adc: add support for suspend/resume functionality
Date: Thu, 22 Jun 2017 15:46:33 +0300
Message-ID: <1498135593-14017-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added support for suspend/resume functionality for the ADC IP
in sama5d2 SoC.
In order to enter Suspend to ram mode (backup + self refresh mode for
memory), in which the ADC IP is no longer powered, we need to reset the
pins to default state, for the scenario when they are also used for I2C
bus to communicate with the PMIC.
On resume, we need to reconfigure the ADC IP registers and reconfigure the
trigger registers in the case when the suspend procedure is done while
sysfs has the buffer and trigger enabled.
In the case the suspend happens exactly during a software triggered
conversion, the request will time out, because we reset and power down
the ADC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 91 +++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 1773a5d..3e775c7 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -576,6 +576,20 @@ static const struct iio_info at91_adc_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static void at91_adc_hw_init(struct at91_adc_state *st)
+{
+	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
+	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
+	/*
+	 * Transfer field must be set to 2 according to the datasheet and
+	 * allows different analog settings for each channel.
+	 */
+	at91_adc_writel(st, AT91_SAMA5D2_MR,
+			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
+
+	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
+}
+
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -694,16 +708,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 		goto vref_disable;
 	}
 
-	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
-	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
-	/*
-	 * Transfer field must be set to 2 according to the datasheet and
-	 * allows different analog settings for each channel.
-	 */
-	at91_adc_writel(st, AT91_SAMA5D2_MR,
-			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
-
-	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
+	at91_adc_hw_init(st);
 
 	ret = clk_prepare_enable(st->per_clk);
 	if (ret)
@@ -759,6 +764,71 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int at91_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev =
+			platform_get_drvdata(to_platform_device(dev));
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	/*
+	 * Do a sofware reset of the ADC before we go to suspend.
+	 * this will ensure that all pins are free from being muxed by the ADC
+	 * and can be used by for other devices.
+	 * Otherwise, ADC will hog them and we can't go to suspend mode.
+	 */
+	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
+
+	clk_disable_unprepare(st->per_clk);
+	regulator_disable(st->vref);
+	regulator_disable(st->reg);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int at91_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev =
+			platform_get_drvdata(to_platform_device(dev));
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		goto resume_failed;
+
+	ret = regulator_enable(st->reg);
+	if (ret)
+		goto resume_failed;
+
+	ret = regulator_enable(st->vref);
+	if (ret)
+		goto reg_disable_resume;
+
+	ret = clk_prepare_enable(st->per_clk);
+	if (ret)
+		goto vref_disable_resume;
+
+	at91_adc_hw_init(st);
+
+	/* reconfiguring trigger hardware state */
+	if (iio_buffer_enabled(indio_dev))
+		at91_adc_configure_trigger(st->trig, true);
+
+	return 0;
+
+vref_disable_resume:
+	regulator_disable(st->vref);
+reg_disable_resume:
+	regulator_disable(st->reg);
+resume_failed:
+	dev_err(&indio_dev->dev, "failed to resume\n");
+	return ret;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
+
 static const struct of_device_id at91_adc_dt_match[] = {
 	{
 		.compatible = "atmel,sama5d2-adc",
@@ -774,6 +844,7 @@ static struct platform_driver at91_adc_driver = {
 	.driver = {
 		.name = "at91-sama5d2_adc",
 		.of_match_table = at91_adc_dt_match,
+		.pm = &at91_adc_pm_ops,
 	},
 };
 module_platform_driver(at91_adc_driver)
-- 
2.7.4

