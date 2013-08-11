Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:10708 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab3HKLH3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Aug 2013 07:07:29 -0400
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask in MR for different IP
Date: Sun, 11 Aug 2013 19:04:29 +0800
Message-Id: <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For at91 boards, there are different IPs for adc. Different IPs has different
STARTUP & PRESCAL mask in ADC_MR.

This patch introduce the multiple compatible string for those different IPs.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v1 --> v2:
  1. use multiple compatible string for different IPs instead of use run-time
     IP check of hardware register.
  2. rebase on top of linus' master tree.

 .../devicetree/bindings/arm/atmel-adc.txt          |    3 +-
 arch/arm/mach-at91/include/mach/at91_adc.h         |    7 ++--
 drivers/iio/adc/at91_adc.c                         |   34 ++++++++++++++++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index 16769d9..6e60781 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -1,7 +1,8 @@
 * AT91's Analog to Digital Converter (ADC)
 
 Required properties:
-  - compatible: Should be "atmel,at91sam9260-adc"
+  - compatible: Should be "atmel,<chip>-adc"
+    <chip> can be "at91sam9260", "at91sam9g45" or "at91sam9x5"
   - reg: Should contain ADC registers location and length
   - interrupts: Should contain the IRQ line for the ADC
   - atmel,adc-channel-base: Offset of the first channel data register
diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
index 8e7ed5c..f00926a 100644
--- a/arch/arm/mach-at91/include/mach/at91_adc.h
+++ b/arch/arm/mach-at91/include/mach/at91_adc.h
@@ -28,9 +28,12 @@
 #define			AT91_ADC_TRGSEL_EXTERNAL	(6 << 1)
 #define		AT91_ADC_LOWRES		(1 << 4)	/* Low Resolution */
 #define		AT91_ADC_SLEEP		(1 << 5)	/* Sleep Mode */
-#define		AT91_ADC_PRESCAL	(0x3f << 8)	/* Prescalar Rate Selection */
+#define		AT91_ADC_PRESCAL_9260	(0x3f << 8)	/* Prescalar Rate Selection */
+#define		AT91_ADC_PRESCAL_9G45	(0xff << 8)
 #define			AT91_ADC_PRESCAL_(x)	((x) << 8)
-#define		AT91_ADC_STARTUP	(0x1f << 16)	/* Startup Up Time */
+#define		AT91_ADC_STARTUP_9260	(0x1f << 16)	/* Startup Up Time */
+#define		AT91_ADC_STARTUP_9G45	(0x7f << 16)
+#define		AT91_ADC_STARTUP_9X5	(0xf << 16)
 #define			AT91_ADC_STARTUP_(x)	((x) << 16)
 #define		AT91_ADC_SHTIM		(0xf  << 24)	/* Sample & Hold Time */
 #define			AT91_ADC_SHTIM_(x)	((x) << 24)
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9cf8ab5..b41eb60 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -39,6 +39,11 @@
 #define at91_adc_writel(st, reg, val) \
 	(writel_relaxed(val, st->reg_base + reg))
 
+struct at91_adc_caps {
+	u32	mr_prescal_mask;
+	u32	mr_startup_mask;
+};
+
 struct at91_adc_state {
 	struct clk		*adc_clk;
 	u16			*buffer;
@@ -62,6 +67,7 @@ struct at91_adc_state {
 	u32			res;		/* resolution used for convertions */
 	bool			low_res;	/* the resolution corresponds to the lowest one */
 	wait_queue_head_t	wq_data_avail;
+	struct at91_adc_caps	*caps;
 };
 
 static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
@@ -429,6 +435,8 @@ ret:
 	return ret;
 }
 
+static const struct of_device_id at91_adc_dt_ids[];
+
 static int at91_adc_probe_dt(struct at91_adc_state *st,
 			     struct platform_device *pdev)
 {
@@ -441,6 +449,9 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	if (!node)
 		return -EINVAL;
 
+	st->caps = (struct at91_adc_caps *)
+		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
+
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
 	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
@@ -704,8 +715,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 	shtim = round_up((st->sample_hold_time * adc_clk_khz /
 			  1000) - 1, 1);
 
-	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
-	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
+	reg = AT91_ADC_PRESCAL_(prsc) & st->caps->mr_prescal_mask;
+	reg |= AT91_ADC_STARTUP_(ticks) & st->caps->mr_startup_mask;
 	if (st->low_res)
 		reg |= AT91_ADC_LOWRES;
 	if (st->sleep_mode)
@@ -776,8 +787,25 @@ static int at91_adc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
+static struct at91_adc_caps at91sam9260_caps = {
+	.mr_prescal_mask = AT91_ADC_PRESCAL_9260,
+	.mr_startup_mask = AT91_ADC_STARTUP_9260,
+};
+
+static struct at91_adc_caps at91sam9g45_caps = {
+	.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
+	.mr_startup_mask = AT91_ADC_STARTUP_9G45,
+};
+
+static struct at91_adc_caps at91sam9x5_caps = {
+	.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,	/* same as 9G45 */
+	.mr_startup_mask = AT91_ADC_STARTUP_9X5,
+};
+
 static const struct of_device_id at91_adc_dt_ids[] = {
-	{ .compatible = "atmel,at91sam9260-adc" },
+	{ .compatible = "atmel,at91sam9260-adc", .data = &at91sam9260_caps },
+	{ .compatible = "atmel,at91sam9g45-adc", .data = &at91sam9g45_caps },
+	{ .compatible = "atmel,at91sam9x5-adc", .data = &at91sam9x5_caps },
 	{},
 };
 MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
-- 
1.7.10

