Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:37898 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750859Ab2LSS6R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Dec 2012 13:58:17 -0500
Received: from mail644.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id BFFC7108C15B
	for <linux-iio@vger.kernel.org>; Wed, 19 Dec 2012 19:47:38 +0100 (CET)
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-iio@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/3] ARM: AT91: IIO: add sleep mode support
Date: Wed, 19 Dec 2012 19:37:11 +0100
Message-Id: <1355942232-26251-2-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The sleep mode will allow to put the add in sleep between conversion.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 +
 drivers/iio/adc/at91_adc.c                          |   19 ++++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index fd2d69e..efb6f02 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -25,6 +25,7 @@ Optional properties:
   - atmel,adc-use-res: String corresponding to an identifier from
 		       atmel,adc-res-names property. If not specified, the highest
 		       resolution will be used.
+  - atmel,atmel,adc-sleep-mode: Boolean to enable of sleep mode when no conversion
  
 Optional trigger Nodes:
   - Required properties:
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index f175a86..c563488 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -52,6 +52,7 @@ struct at91_adc_state {
 	void __iomem		*reg_base;
 	struct at91_adc_reg_desc *registers;
 	u8			startup_time;
+	bool			sleep_mode;
 	struct iio_trigger	**trig;
 	struct at91_adc_trigger	*trigger_list;
 	u32			trigger_number;
@@ -455,6 +456,8 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	}
 	st->num_channels = prop;
 
+	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
+
 	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
 		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
 		ret = -EINVAL;
@@ -580,6 +583,7 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
 	struct resource *res;
+	u32 reg;
 
 	idev = iio_device_alloc(sizeof(struct at91_adc_state));
 	if (idev == NULL) {
@@ -687,16 +691,13 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	 */
 	ticks = round_up((st->startup_time * adc_clk /
 			  1000000) - 1, 8) / 8;
-
+	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
+	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
 	if (st->low_res)
-		at91_adc_writel(st, AT91_ADC_MR,
-				AT91_ADC_LOWRES |
-				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
-				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
-	else
-		at91_adc_writel(st, AT91_ADC_MR,
-				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
-				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
+		reg |= AT91_ADC_LOWRES;
+	if (st->sleep_mode)
+		reg |= AT91_ADC_SLEEP;
+	at91_adc_writel(st, AT91_ADC_MR, reg);
 
 	/* Setup the ADC channels available on the board */
 	ret = at91_adc_channel_init(idev);
-- 
1.7.10.4

