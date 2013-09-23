Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51051 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3IWOgv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 10:36:51 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	linux-input@vger.kernel.org
Subject: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock handling
Date: Mon, 23 Sep 2013 16:36:30 +0200
Message-Id: <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The delay units inside the LRADC depend on the presence of a 2 kHz clock.
This change enables the clock to be able to use the delay unit for the
touchscreen part of the driver.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx23.dtsi        | 1 +
 arch/arm/boot/dts/imx28.dtsi        | 1 +
 drivers/staging/iio/adc/mxs-lradc.c | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 28b5ce2..07caf76 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -430,6 +430,7 @@
 				reg = <0x80050000 0x2000>;
 				interrupts = <36 37 38 39 40 41 42 43 44>;
 				status = "disabled";
+				clocks = <&clks 26>;
 			};
 
 			spdif@80054000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7363fde..175deef 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -902,6 +902,7 @@
 				interrupts = <10 14 15 16 17 18 19
 						20 21 22 23 24 25>;
 				status = "disabled";
+				clocks = <&clks 41>;
 			};
 
 			spdif: spdif@80054000 {
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index a08c173..00b61ac 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -35,6 +35,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/clk.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -134,6 +135,8 @@ struct mxs_lradc {
 	void __iomem		*base;
 	int			irq[13];
 
+	struct clk		*clk;
+
 	uint32_t		*buffer;
 	struct iio_trigger	*trig;
 
@@ -928,6 +931,9 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
+	lradc->clk = devm_clk_get(&pdev->dev, NULL);
+	clk_prepare_enable(lradc->clk);
+
 	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
 
 	/* Check if touchscreen is enabled in DT. */
@@ -1020,6 +1026,7 @@ static int mxs_lradc_remove(struct platform_device *pdev)
 	iio_triggered_buffer_cleanup(iio);
 	mxs_lradc_trigger_remove(iio);
 
+	clk_disable_unprepare(lradc->clk);
 	return 0;
 }
 
-- 
1.8.4.rc3

