Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:53557 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752626Ab2LSSsR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Dec 2012 13:48:17 -0500
Received: from mail644.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id A3F6C108C037
	for <linux-iio@vger.kernel.org>; Wed, 19 Dec 2012 19:47:38 +0100 (CET)
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-iio@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 1/3] ARM: AT91: IIO: add low and high res support for adc
Date: Wed, 19 Dec 2012 19:37:10 +0100
Message-Id: <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <20121219183236.GP23971@game.jcrosoft.org>
References: <20121219183236.GP23971@game.jcrosoft.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

at91 adc offers the choice between two resolutions: low and high.
The low and high resolution values depends on adc IP version, as many IP
properties have been exposed through device tree, these settings have also
been added to the dt bindings.

Update at the same time the dtsi.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
[plagnioj@jcrosoft.com: udpate current adc dt support]
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/arm/atmel-adc.txt          |   11 +++
 arch/arm/boot/dts/at91sam9260.dtsi                 |    3 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    3 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    3 +
 drivers/iio/adc/at91_adc.c                         |   74 ++++++++++++++++++--
 5 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index c63097d..fd2d69e 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -14,9 +14,17 @@ Required properties:
   - atmel,adc-status-register: Offset of the Interrupt Status Register
   - atmel,adc-trigger-register: Offset of the Trigger Register
   - atmel,adc-vref: Reference voltage in millivolts for the conversions
+  - atmel,adc-res: List of resolution in bits supported by the ADC. List size
+		   must be two at least.
+  - atmel,adc-res-names: Contains one identifier string for each resolution
+			 in atmel,adc-res property. "lowres" and "highres"
+			 identifiers are required.
 
 Optional properties:
   - atmel,adc-use-external: Boolean to enable of external triggers
+  - atmel,adc-use-res: String corresponding to an identifier from
+		       atmel,adc-res-names property. If not specified, the highest
+		       resolution will be used.
  
 Optional trigger Nodes:
   - Required properties:
@@ -40,6 +48,9 @@ adc0: adc@fffb0000 {
 	atmel,adc-trigger-register = <0x08>;
 	atmel,adc-use-external;
 	atmel,adc-vref = <3300>;
+	atmel,adc-res = <8 10>;
+	atmel,adc-res-names = "lowres", "highres";
+	atmel,adc-use-res = "lowres";
 
 	trigger@0 {
 		trigger-name = "external-rising";
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index cca34bc..7c605d2 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -506,6 +506,9 @@
 				atmel,adc-drdy-mask = <0x10000>;
 				atmel,adc-status-register = <0x1c>;
 				atmel,adc-trigger-register = <0x04>;
+				atmel,adc-res = <8 10>;
+				atmel,adc-res-names = "lowres", "highres";
+				atmel,adc-use-res = "highres";
 
 				trigger@0 {
 					trigger-name = "timer-counter-0";
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 253afed..70c776e 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -488,6 +488,9 @@
 				atmel,adc-drdy-mask = <0x10000>;
 				atmel,adc-status-register = <0x1c>;
 				atmel,adc-trigger-register = <0x08>;
+				atmel,adc-res = <8 10>;
+				atmel,adc-res-names = "lowres", "highres";
+				atmel,adc-use-res = "highres";
 
 				trigger@0 {
 					trigger-name = "external-rising";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 70c1f5d..e52862d 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -469,6 +469,9 @@
 				atmel,adc-drdy-mask = <0x1000000>;
 				atmel,adc-status-register = <0x30>;
 				atmel,adc-trigger-register = <0xc0>;
+				atmel,adc-res = <8 10>;
+				atmel,adc-res-names = "lowres", "highres";
+				atmel,adc-use-res = "highres";
 
 				trigger@0 {
 					trigger-name = "external-rising";
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 315bed1..f175a86 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -57,6 +57,8 @@ struct at91_adc_state {
 	u32			trigger_number;
 	bool			use_external;
 	u32			vref_mv;
+	u32			res;		/* resolution used for convertions */
+	bool			low_res;	/* the resolution corresponds to the lowest one */
 	wait_queue_head_t	wq_data_avail;
 };
 
@@ -138,7 +140,7 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 		chan->channel = bit;
 		chan->scan_index = idx;
 		chan->scan_type.sign = 'u';
-		chan->scan_type.realbits = 10;
+		chan->scan_type.realbits = st->res;
 		chan->scan_type.storagebits = 16;
 		chan->info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
 			IIO_CHAN_INFO_RAW_SEPARATE_BIT;
@@ -372,6 +374,59 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 	return -EINVAL;
 }
 
+static int at91_adc_of_get_resolution(struct at91_adc_state *st,
+				      struct platform_device *pdev)
+{
+	struct iio_dev *idev = iio_priv_to_dev(st);
+	struct device_node *np = pdev->dev.of_node;
+	int count, i, ret = 0;
+	char *res_name, *s;
+	u32 *resolutions;
+
+	count = of_property_count_strings(np, "atmel,adc-res-names");
+	if (count < 2) {
+		dev_err(&idev->dev, "You must specified at least two resolution names for "
+				    "adc-res-names property in the DT\n");
+		return count;
+	}
+
+	resolutions = kmalloc(count * sizeof(*resolutions), GFP_KERNEL);
+	if (!resolutions)
+		return -ENOMEM;
+
+	if (of_property_read_u32_array(np, "atmel,adc-res", resolutions, count)) {
+		dev_err(&idev->dev, "Missing adc-res property in the DT.\n");
+		ret = -ENODEV;
+		goto ret;
+	}
+
+	if (of_property_read_string(np, "atmel,adc-use-res", (const char **)&res_name))
+		res_name = "highres";
+
+	for (i = 0; i < count; i++) {
+		if (of_property_read_string_index(np, "atmel,adc-res-names", i, (const char **)&s))
+			continue;
+
+		if (strcmp(res_name, s))
+			continue;
+
+		st->res = resolutions[i];
+		if (!strcmp(res_name, "lowres"))
+			st->low_res = true;
+		else
+			st->low_res = false;
+
+		dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
+		goto ret;
+	}
+
+	dev_err(&idev->dev, "There is no resolution for %s\n", res_name);
+
+ret:
+	kfree(resolutions);
+	return ret;
+}
+
 static int at91_adc_probe_dt(struct at91_adc_state *st,
 			     struct platform_device *pdev)
 {
@@ -415,6 +470,10 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	}
 	st->vref_mv = prop;
 
+	ret = at91_adc_of_get_resolution(st, pdev);
+	if (ret)
+		goto error_ret;
+
 	st->registers = devm_kzalloc(&idev->dev,
 				     sizeof(struct at91_adc_reg_desc),
 				     GFP_KERNEL);
@@ -628,9 +687,16 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	 */
 	ticks = round_up((st->startup_time * adc_clk /
 			  1000000) - 1, 8) / 8;
-	at91_adc_writel(st, AT91_ADC_MR,
-			(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
-			(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
+
+	if (st->low_res)
+		at91_adc_writel(st, AT91_ADC_MR,
+				AT91_ADC_LOWRES |
+				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
+				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
+	else
+		at91_adc_writel(st, AT91_ADC_MR,
+				(AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
+				(AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
 
 	/* Setup the ADC channels available on the board */
 	ret = at91_adc_channel_init(idev);
-- 
1.7.10.4

