Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:48522 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3H0L35 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2013 07:29:57 -0400
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com,
	Josh Wu <josh.wu@atmel.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 2/6] iio: at91: introduce the multiple compatible string for different IPs.
Date: Tue, 27 Aug 2013 19:28:48 +0800
Message-Id: <1377602932-1899-3-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As use the multiple compatible string, we can remove hardware register in dt.

CC: devicetree@vger.kernel.org
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 .../devicetree/bindings/arm/atmel-adc.txt          |    7 +-
 arch/arm/mach-at91/include/mach/at91_adc.h         |    9 +++
 drivers/iio/adc/at91_adc.c                         |   79 ++++++++++----------
 3 files changed, 52 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index 16769d9..723c205 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -1,18 +1,15 @@
 * AT91's Analog to Digital Converter (ADC)
 
 Required properties:
-  - compatible: Should be "atmel,at91sam9260-adc"
+  - compatible: Should be "atmel,<chip>-adc"
+    <chip> can be "at91sam9260", "at91sam9g45" or "at91sam9x5"
   - reg: Should contain ADC registers location and length
   - interrupts: Should contain the IRQ line for the ADC
-  - atmel,adc-channel-base: Offset of the first channel data register
   - atmel,adc-channels-used: Bitmask of the channels muxed and enable for this
     device
-  - atmel,adc-drdy-mask: Mask of the DRDY interruption in the ADC
   - atmel,adc-num-channels: Number of channels available in the ADC
   - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
     defined in the datasheet
-  - atmel,adc-status-register: Offset of the Interrupt Status Register
-  - atmel,adc-trigger-register: Offset of the Trigger Register
   - atmel,adc-vref: Reference voltage in millivolts for the conversions
   - atmel,adc-res: List of resolution in bits supported by the ADC. List size
 		   must be two at least.
diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
index 8e7ed5c..bea1a20 100644
--- a/arch/arm/mach-at91/include/mach/at91_adc.h
+++ b/arch/arm/mach-at91/include/mach/at91_adc.h
@@ -48,6 +48,9 @@
 #define		AT91_ADC_ENDRX		(1 << 18)	/* End of RX Buffer */
 #define		AT91_ADC_RXFUFF		(1 << 19)	/* RX Buffer Full */
 
+#define AT91_ADC_SR_9X5		0x30		/* Status Register for 9x5 */
+#define		AT91_ADC_SR_DRDY_9X5	(1 << 24)	/* Data Ready */
+
 #define AT91_ADC_LCDR		0x20		/* Last Converted Data Register */
 #define		AT91_ADC_LDATA		(0x3ff)
 
@@ -58,4 +61,10 @@
 #define AT91_ADC_CHR(n)		(0x30 + ((n) * 4))	/* Channel Data Register N */
 #define		AT91_ADC_DATA		(0x3ff)
 
+#define AT91_ADC_CDR0_9X5	(0x50)			/* Channel Data Register 0 for 9X5 */
+
+#define AT91_ADC_TRGR_9260	AT91_ADC_MR
+#define AT91_ADC_TRGR_9G45	0x08
+#define AT91_ADC_TRGR_9X5	0xC0
+
 #endif
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9cf8ab5..49dd751 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -39,6 +39,10 @@
 #define at91_adc_writel(st, reg, val) \
 	(writel_relaxed(val, st->reg_base + reg))
 
+struct at91_adc_caps {
+	struct at91_adc_reg_desc registers;
+};
+
 struct at91_adc_state {
 	struct clk		*adc_clk;
 	u16			*buffer;
@@ -62,6 +66,7 @@ struct at91_adc_state {
 	u32			res;		/* resolution used for convertions */
 	bool			low_res;	/* the resolution corresponds to the lowest one */
 	wait_queue_head_t	wq_data_avail;
+	struct at91_adc_caps	*caps;
 };
 
 static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
@@ -429,6 +434,8 @@ ret:
 	return ret;
 }
 
+static const struct of_device_id at91_adc_dt_ids[];
+
 static int at91_adc_probe_dt(struct at91_adc_state *st,
 			     struct platform_device *pdev)
 {
@@ -441,6 +448,9 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	if (!node)
 		return -EINVAL;
 
+	st->caps = (struct at91_adc_caps *)
+		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
+
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
 	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
@@ -481,43 +491,7 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	if (ret)
 		goto error_ret;
 
-	st->registers = devm_kzalloc(&idev->dev,
-				     sizeof(struct at91_adc_reg_desc),
-				     GFP_KERNEL);
-	if (!st->registers) {
-		dev_err(&idev->dev, "Could not allocate register memory.\n");
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	if (of_property_read_u32(node, "atmel,adc-channel-base", &prop)) {
-		dev_err(&idev->dev, "Missing adc-channel-base property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->registers->channel_base = prop;
-
-	if (of_property_read_u32(node, "atmel,adc-drdy-mask", &prop)) {
-		dev_err(&idev->dev, "Missing adc-drdy-mask property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->registers->drdy_mask = prop;
-
-	if (of_property_read_u32(node, "atmel,adc-status-register", &prop)) {
-		dev_err(&idev->dev, "Missing adc-status-register property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->registers->status_register = prop;
-
-	if (of_property_read_u32(node, "atmel,adc-trigger-register", &prop)) {
-		dev_err(&idev->dev, "Missing adc-trigger-register property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->registers->trigger_register = prop;
-
+	st->registers = &st->caps->registers;
 	st->trigger_number = of_get_child_count(node);
 	st->trigger_list = devm_kzalloc(&idev->dev, st->trigger_number *
 					sizeof(struct at91_adc_trigger),
@@ -776,8 +750,37 @@ static int at91_adc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
+static struct at91_adc_caps at91sam9260_caps = {
+	.registers = {
+		.channel_base = AT91_ADC_CHR(0),
+		.drdy_mask = AT91_ADC_DRDY,
+		.status_register = AT91_ADC_SR,
+		.trigger_register = AT91_ADC_TRGR_9260,
+	},
+};
+
+static struct at91_adc_caps at91sam9g45_caps = {
+	.registers = {
+		.channel_base = AT91_ADC_CHR(0),
+		.drdy_mask = AT91_ADC_DRDY,
+		.status_register = AT91_ADC_SR,
+		.trigger_register = AT91_ADC_TRGR_9G45,
+	},
+};
+
+static struct at91_adc_caps at91sam9x5_caps = {
+	.registers = {
+		.channel_base = AT91_ADC_CDR0_9X5,
+		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
+		.status_register = AT91_ADC_SR_9X5,
+		.trigger_register = AT91_ADC_TRGR_9X5,
+	},
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

