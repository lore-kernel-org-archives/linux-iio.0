Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44839 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab2DRNe0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:34:26 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] IIO: AT91: Add DT support to at91_adc driver
Date: Wed, 18 Apr 2012 15:33:56 +0200
Message-Id: <1334756036-15944-7-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/arm/atmel-adc.txt          |   21 +++++
 drivers/staging/iio/adc/at91_adc.c                 |   88 +++++++++++++++-----
 2 files changed, 87 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-adc.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
new file mode 100644
index 0000000..ac62847
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -0,0 +1,21 @@
+* AT91's Analog to Digital Converter (ADC)
+
+Required properties:
+  - compatible: Should be "atmel,at91-adc"
+  - reg: Should contain ADC registers location and length
+  - interrupts: Should contain the IRQ line for the ADC
+  - atmel,adc-use-external: Boolean to enable the muxing and the use of external
+    triggers
+  - atmel,adc-vref: Reference voltage in millivolts for the conversions
+  - atmel,adc-channels-used: Bitmask of the channels muxed and enable for this
+    device
+
+Examples:
+	adc@f804c000 {
+		compatible = "atmel,at91-adc";
+		reg = <0xf804c000 0x100>;
+		interrupts = <19 4>;
+		atmel,adc-use-external;
+		atmel,adc-channels-used = <0xff>;
+		atmel,adc-vref = <3300>;
+	};
diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
index 7c93cde..d655cba 100644
--- a/drivers/staging/iio/adc/at91_adc.c
+++ b/drivers/staging/iio/adc/at91_adc.c
@@ -15,6 +15,8 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -81,6 +83,7 @@ struct at91_adc_state {
 	struct mutex		lock;
 	void __iomem		*reg_base;
 	struct iio_trigger	**trig;
+	bool			use_external;
 	u32			vref_mv;
 	wait_queue_head_t	wq_data_avail;
 };
@@ -245,14 +248,13 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int at91_adc_channel_init(struct iio_dev *idev,
-				 struct at91_adc_data *pdata)
+static int at91_adc_channel_init(struct iio_dev *idev)
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	struct iio_chan_spec *chan_array;
 	int bit, idx = 0;
 
-	idev->num_channels = bitmap_weight(&pdata->channels_used,
+	idev->num_channels = bitmap_weight(&st->channels_mask,
 					   st->desc->num_channels) + 1;
 
 	chan_array = devm_kzalloc(&idev->dev,
@@ -262,7 +264,7 @@ static int at91_adc_channel_init(struct iio_dev *idev,
 	if (chan_array == NULL)
 		return -ENOMEM;
 
-	for_each_set_bit(bit, &pdata->channels_used, st->desc->num_channels) {
+	for_each_set_bit(bit, &st->channels_mask, st->desc->num_channels) {
 		struct iio_chan_spec *chan = chan_array + idx;
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
@@ -400,8 +402,7 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
 	return trig;
 }
 
-static int at91_adc_trigger_init(struct iio_dev *idev,
-				 struct at91_adc_data *pdata)
+static int at91_adc_trigger_init(struct iio_dev *idev)
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	int i, ret;
@@ -416,7 +417,7 @@ static int at91_adc_trigger_init(struct iio_dev *idev,
 	}
 
 	for (i = 0; st->desc->triggers[i].name != NULL; i++) {
-		if (st->desc->triggers[i].is_external && !(pdata->use_external))
+		if (st->desc->triggers[i].is_external && !(st->use_external))
 			continue;
 
 		st->trig[i] = at91_adc_allocate_trigger(idev,
@@ -555,6 +556,39 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 	return -EINVAL;
 }
 
+static int at91_adc_probe_dt(struct at91_adc_state *st,
+			     struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+
+	if (!node)
+		return -EINVAL;
+
+	if (of_get_property(node, "atmel,adc-use-external", NULL))
+		st->use_external = true;
+
+	of_property_read_u32(node, "atmel,adc-channels-used",
+			     (u32*)&st->channels_mask);
+	of_property_read_u32(node, "atmel,adc-vref", &st->vref_mv);
+
+	return 0;
+}
+
+static int at91_adc_probe_pdata(struct at91_adc_state *st,
+				struct platform_device *pdev)
+{
+	struct at91_adc_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata)
+		return -EINVAL;
+
+	st->use_external = pdata->use_external;
+	st->vref_mv = pdata->vref;
+	st->channels_mask = pdata->channels_used;
+
+	return 0;
+}
+
 static const struct iio_info at91_adc_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &at91_adc_read_raw,
@@ -567,12 +601,25 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
 	struct resource *res;
-	struct at91_adc_data *pdata = pdev->dev.platform_data;
 
-	if (!pdata) {
+	idev = iio_allocate_device(sizeof(struct at91_adc_state));
+	if (idev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	st = iio_priv(idev);
+
+	if (pdev->dev.of_node) {
+		ret = at91_adc_probe_dt(st, pdev);
+	} else {
+		ret = at91_adc_probe_pdata(st, pdev);
+	}
+
+	if (ret) {
 		dev_err(&pdev->dev, "No platform data available.\n");
 		ret = -EINVAL;
-		goto error_ret;
+		goto error_free_device;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -582,12 +629,6 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 		goto error_ret;
 	}
 
-	idev = iio_allocate_device(sizeof(struct at91_adc_state));
-	if (idev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
 	platform_set_drvdata(pdev, idev);
 
 	idev->dev.parent = &pdev->dev;
@@ -595,7 +636,6 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	idev->modes = INDIO_DIRECT_MODE;
 	idev->info = &at91_adc_info;
 
-	st = iio_priv(idev);
 	ret = at91_adc_select_soc(st);
 	if (ret) {
 		dev_err(&pdev->dev, "SoC unknown\n");
@@ -689,7 +729,7 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 			  (AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
 
 	/* Setup the ADC channels available on the board */
-	ret = at91_adc_channel_init(idev, pdata);
+	ret = at91_adc_channel_init(idev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't initialize the channels.\n");
 		goto error_disable_clk;
@@ -698,16 +738,13 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	init_waitqueue_head(&st->wq_data_avail);
 	mutex_init(&st->lock);
 
-	st->vref_mv = pdata->vref;
-	st->channels_mask = pdata->channels_used;
-
 	ret = at91_adc_buffer_init(idev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
 		goto error_free_channels;
 	}
 
-	ret = at91_adc_trigger_init(idev, pdata);
+	ret = at91_adc_trigger_init(idev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
 		goto error_unregister_buffer;
@@ -766,11 +803,18 @@ static int __devexit at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id at91_adc_dt_ids[] = {
+	{ .compatible = "atmel,at91-adc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
+
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
 	.remove = __devexit_p(at91_adc_remove),
 	.driver = {
 		   .name = "at91_adc",
+		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
 	},
 };
 
-- 
1.7.5.4

