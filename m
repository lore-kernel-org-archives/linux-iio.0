Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52449 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab3C2Oy1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 10:54:27 -0400
From: <ludovic.desroches@atmel.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/3] iio: at91_adc: add sleep mode support
Date: Fri, 29 Mar 2013 15:54:12 +0100
Message-ID: <1364568853-18561-3-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com>
References: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

The sleep mode will allow to put the adc in sleep between conversion.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
[ludovic.desroches@atmel.com: correct typo]
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-adc.txt |  1 +
 drivers/iio/adc/at91_adc.c                          | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index fd2d69e..3a05492 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -25,6 +25,7 @@ Optional properties:
   - atmel,adc-use-res: String corresponding to an identifier from
 		       atmel,adc-res-names property. If not specified, the highest
 		       resolution will be used.
+  - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
  
 Optional trigger Nodes:
   - Required properties:
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a7ad3e7..8e38f1c 100644
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
@@ -580,6 +583,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
 	struct resource *res;
+	u32 reg;
 
 	idev = iio_device_alloc(sizeof(struct at91_adc_state));
 	if (idev == NULL) {
@@ -687,16 +691,13 @@ static int at91_adc_probe(struct platform_device *pdev)
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
1.7.11.3

