Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36812 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab3IXHt2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 03:49:28 -0400
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock handling
Date: Tue, 24 Sep 2013 09:50:54 +0200
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	marex@denx.de, jic23@cam.ac.uk, linux-input@vger.kernel.org
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-2-git-send-email-jbe@pengutronix.de> <52405A7F.1050801@freescale.com>
In-Reply-To: <52405A7F.1050801@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309240950.54789.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Fabio,

On Monday 23 September 2013 17:13:03 Fabio Estevam wrote:
> On 09/23/2013 11:36 AM, Juergen Beisert wrote:
> > +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	clk_prepare_enable(lradc->clk);
>
> clk_prepare_enable() may fail, so better check its return value.

Thanks for the comment. Better this way?

commit 825c5bb787a0dc9d25d480178e117be08810639c
Author: Juergen Beisert <jbe@pengutronix.de>
Date:   Mon Sep 23 16:10:56 2013 +0200

    Staging/iio/adc/touchscreen/MXS: add proper clock handling
    
    The delay units inside the LRADC depend on the presence of a 2 kHz clock.
    This change enables the clock to be able to use the delay unit for the
    touchscreen part of the driver.
    
    Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

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
index a08c173..eaca1ae 100644
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
 
@@ -928,6 +931,17 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
+	lradc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(lradc->clk)) {
+		dev_err(dev, "Failed to get the delay unit clock\n");
+		return PTR_ERR(lradc->clk);
+	}
+	ret = clk_prepare_enable(lradc->clk);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable the delay unit clock\n");
+		return ret;
+	}
+
 	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
 
 	/* Check if touchscreen is enabled in DT. */
@@ -1020,6 +1034,7 @@ static int mxs_lradc_remove(struct platform_device *pdev)
 	iio_triggered_buffer_cleanup(iio);
 	mxs_lradc_trigger_remove(iio);
 
+	clk_disable_unprepare(lradc->clk);
 	return 0;
 }
 
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
