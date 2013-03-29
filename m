Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52432 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab3C2OyX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 10:54:23 -0400
From: <ludovic.desroches@atmel.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <maxime.ripard@free-electrons.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 1/3] iio: at91_adc: add low and high res support
Date: Fri, 29 Mar 2013 15:54:11 +0100
Message-ID: <1364568853-18561-2-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com>
References: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

at91 adc offers the choice between two resolutions: low and high.
The low and high resolution values depends on adc IP version, as many IP
properties have been exposed through device tree, these settings have also
been added to the dt bindings.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 .../devicetree/bindings/arm/atmel-adc.txt          | 11 ++++
 drivers/iio/adc/at91_adc.c                         | 74 ++++++++++++++++++++--
 2 files changed, 81 insertions(+), 4 deletions(-)

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
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 83c836b..a7ad3e7 100644
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
@@ -628,9 +687,16 @@ static int at91_adc_probe(struct platform_device *pdev)
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
1.7.11.3

