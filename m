Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:41999 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750859Ab2LSS6T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Dec 2012 13:58:19 -0500
Received: from mail644.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id D2AA9108C176
	for <linux-iio@vger.kernel.org>; Wed, 19 Dec 2012 19:47:38 +0100 (CET)
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-iio@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 3/3] ARM: AT91: IIO: fix missing Sample and Hold time
Date: Wed, 19 Dec 2012 19:37:12 +0100
Message-Id: <1355942232-26251-3-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On the at91_adc a minimal Sample and Hold Time is necessary for the ADC to
guarantee the best converted final value between two channels selection.
This time has to be programmed through the bitfield SHTIM in the
Mode Register ADC_MR.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 +
 drivers/iio/adc/at91_adc.c                          |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index efb6f02..dd2ca90 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -26,6 +26,7 @@ Optional properties:
 		       atmel,adc-res-names property. If not specified, the highest
 		       resolution will be used.
   - atmel,atmel,adc-sleep-mode: Boolean to enable of sleep mode when no conversion
+  - atmel,adc-sample-hold-time: Sample and Hold Time
  
 Optional trigger Nodes:
   - Required properties:
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index c563488..9481375 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -52,6 +52,7 @@ struct at91_adc_state {
 	void __iomem		*reg_base;
 	struct at91_adc_reg_desc *registers;
 	u8			startup_time;
+	u8			sample_hold_time;
 	bool			sleep_mode;
 	struct iio_trigger	**trig;
 	struct at91_adc_trigger	*trigger_list;
@@ -465,6 +466,9 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	}
 	st->startup_time = prop;
 
+	prop = 0;
+	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
+	st->sample_hold_time = prop;
 
 	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
 		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
@@ -578,7 +582,7 @@ static const struct iio_info at91_adc_info = {
 
 static int __devinit at91_adc_probe(struct platform_device *pdev)
 {
-	unsigned int prsc, mstrclk, ticks, adc_clk;
+	unsigned int prsc, mstrclk, ticks, adc_clk, shtim;
 	int ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
@@ -691,12 +695,21 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	 */
 	ticks = round_up((st->startup_time * adc_clk /
 			  1000000) - 1, 8) / 8;
+	/*
+	 * a minimal Sample and Hold Time is necessary for the ADC to guarantee
+	 * the best converted final value between two channels selection
+	 * The formula thus is : Sample and Hold Time = (shtim + 1) / ADCClock
+	 */
+	shtim = round_up((st->sample_hold_time * adc_clk /
+			  1000000) - 1, 1);
+
 	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
 	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
 	if (st->low_res)
 		reg |= AT91_ADC_LOWRES;
 	if (st->sleep_mode)
 		reg |= AT91_ADC_SLEEP;
+	reg |= AT91_ADC_SHTIM_(shtim) & AT91_ADC_SHTIM;
 	at91_adc_writel(st, AT91_ADC_MR, reg);
 
 	/* Setup the ADC channels available on the board */
-- 
1.7.10.4

