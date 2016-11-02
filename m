Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52280 "EHLO
        eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbcKBCkj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2016 22:40:39 -0400
From: Wenyou Yang <wenyou.yang@atmel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        <linux-iio@vger.kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v1] iio: adc: at91: add suspend and resume callback
Date: Wed, 2 Nov 2016 10:40:16 +0800
Message-ID: <1478054417-7520-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add suspend/resume callback, support the pinctrl sleep state when
the system suspend as well.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 drivers/iio/adc/at91_adc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index bbdac07..ffa81a1 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -30,6 +30,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/pinctrl/consumer.h>
 
 /* Registers */
 #define AT91_ADC_CR		0x00		/* Control Register */
@@ -1347,6 +1348,39 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int at91_adc_suspend(struct device *dev)
+{
+	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
+	struct at91_adc_state *st = iio_priv(idev);
+
+	pinctrl_pm_select_sleep_state(dev);
+	clk_disable_unprepare(st->clk);
+
+	return 0;
+}
+
+static int at91_adc_resume(struct device *dev)
+{
+	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
+	struct at91_adc_state *st = iio_priv(idev);
+
+	clk_prepare_enable(st->clk);
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops at91_adc_pm_ops = {
+	.suspend = at91_adc_suspend,
+	.resume = at91_adc_resume,
+};
+
+#define AT91_ADC_PM_OPS (&at91_adc_pm_ops)
+#else
+#define AT91_ADC_PM_OPS NULL
+#endif
+
 static struct at91_adc_caps at91sam9260_caps = {
 	.calc_startup_ticks = calc_startup_ticks_9260,
 	.num_channels = 4,
@@ -1441,6 +1475,7 @@ static struct platform_driver at91_adc_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
+		.pm = AT91_ADC_PM_OPS,
 	},
 };
 
-- 
2.7.4

