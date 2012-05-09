Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45322 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab2EIJG7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 05:06:59 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: thomas@free-electrons.com, patrice.vilchez@atmel.com,
	nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Subject: [PATCH 6/9] IIO: AT91: Add DT support to at91_adc driver
Date: Wed,  9 May 2012 11:06:03 +0200
Message-Id: <1336554366-16957-7-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/arm/atmel-adc.txt          |   65 ++++++++++
 drivers/iio/adc/at91_adc.c                         |  133 +++++++++++++++++++-
 2 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-adc.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
new file mode 100644
index 0000000..da2b67d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -0,0 +1,65 @@
+* AT91's Analog to Digital Converter (ADC)
+
+Required properties:
+  - compatible: Should be "atmel,at91-adc"
+  - reg: Should contain ADC registers location and length
+  - interrupts: Should contain the IRQ line for the ADC
+  - atmel,adc-channel-base: Address of the first channel data register
+  - atmel,adc-channels-used: Bitmask of the channels muxed and enable for this
+    device
+  - atmel,adc-drdy-mask: Mask of the DRDY interruption in the ADC
+  - atmel,adc-num-channels: Number of channels available in the ADC
+  - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
+    defined in the datasheet
+  - atmel,adc-status-register: Address of the Interrupt Status Register
+  - atmel,adc-trigger-register: Address of the Trigger Register
+  - atmel,adc-vref: Reference voltage in millivolts for the conversions
+
+Optional properties:
+  - atmel,adc-use-external: Boolean to enable of external triggers
+ 
+Optional trigger Nodes:
+  - Required properties:
+    * trigger-name: Name of the trigger exposed to the user
+    * trigger-value: Value to put in the Trigger register
+      to activate this trigger
+  - Optional properties:
+    * trigger-external: Is the trigger an external trigger?
+
+Examples:
+adc0: adc@fffb0000 {
+	compatible = "atmel,at91-adc";
+	reg = <0xfffb0000 0x100>;
+	interrupts = <20 4>;
+	atmel,adc-channel-base = <0x30>;
+	atmel,adc-channels-used = <0xff>;
+	atmel,adc-drdy-mask = <0x10000>;
+	atmel,adc-num-channels = <8>;
+	atmel,adc-startup-time = <40>;
+	atmel,adc-status-register = <0x1c>;
+	atmel,adc-trigger-register = <0x08>;
+	atmel,adc-use-external;
+	atmel,adc-vref = <3300>;
+
+	trigger@0 {
+		trigger-name = "external-rising";
+		trigger-value = <0x1>;
+		trigger-external;
+	};
+	trigger@1 {
+		trigger-name = "external-falling";
+		trigger-value = <0x2>;
+		trigger-external;
+	};
+
+	trigger@2 {
+		trigger-name = "external-any";
+		trigger-value = <0x3>;
+		trigger-external;
+	};
+
+	trigger@3 {
+		trigger-name = "continuous";
+		trigger-value = <0x6>;
+	};
+};
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index febad23..35892fa 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -15,6 +15,8 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -416,6 +418,124 @@ static int at91_adc_read_raw(struct iio_dev *idev,
 	return -EINVAL;
 }
 
+static int at91_adc_probe_dt(struct at91_adc_state *st,
+			     struct platform_device *pdev)
+{
+	struct iio_dev *idev = iio_priv_to_dev(st);
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *trig_node;
+	int i = 0, ret;
+	u32 prop;
+
+	if (!node)
+		return -EINVAL;
+
+	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
+		st->use_external = true;
+
+	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
+		dev_err(&idev->dev, "Missing adc-channels-used property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->channels_mask = prop;
+
+	if (of_property_read_u32(node, "atmel,adc-num-channels", &prop)) {
+		dev_err(&idev->dev, "Missing adc-num-channels property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->num_channels = prop;
+
+	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
+		dev_err(&idev->dev, "Missing adc-startup-time property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->startup_time = prop;
+
+
+	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
+		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->vref_mv = prop;
+
+	st->registers = devm_kzalloc(&idev->dev,
+				     sizeof(struct at91_adc_reg_desc),
+				     GFP_KERNEL);
+	if (!st->registers) {
+		dev_err(&idev->dev, "Could not allocate register memory.\n");
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	if (of_property_read_u32(node, "atmel,adc-channel-base", &prop)) {
+		dev_err(&idev->dev, "Missing adc-channel-base property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->registers->channel_base = prop;
+
+	if (of_property_read_u32(node, "atmel,adc-drdy-mask", &prop)) {
+		dev_err(&idev->dev, "Missing adc-drdy-mask property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->registers->drdy_mask = prop;
+
+	if (of_property_read_u32(node, "atmel,adc-status-register", &prop)) {
+		dev_err(&idev->dev, "Missing adc-status-register property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->registers->status_register = prop;
+
+	if (of_property_read_u32(node, "atmel,adc-trigger-register", &prop)) {
+		dev_err(&idev->dev, "Missing adc-trigger-register property in the DT.\n");
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	st->registers->trigger_register = prop;
+
+	st->trigger_number = of_get_child_count(node);
+	st->trigger_list = devm_kzalloc(&idev->dev, st->trigger_number *
+					sizeof(struct at91_adc_trigger),
+					GFP_KERNEL);
+	if (!st->trigger_list) {
+		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	for_each_child_of_node(node, trig_node) {
+		struct at91_adc_trigger *trig = st->trigger_list + i;
+		const char* name;
+
+		if (of_property_read_string(node, "trigger-name", &name)) {
+			dev_err(&idev->dev, "Missing trigger-name property in the DT.\n");
+			ret = -EINVAL;
+			goto error_ret;
+		}
+	        trig->name = name;
+
+		if (of_property_read_u32(node, "trigger-value", &prop)) {
+			dev_err(&idev->dev, "Missing trigger-value property in the DT.\n");
+			ret = -EINVAL;
+			goto error_ret;
+		}
+	        trig->value = prop;
+		trig->is_external = of_property_read_bool(node, "trigger-external");
+		i++;
+	}
+
+	return 0;
+
+error_ret:
+	return ret;
+}
+
 static int at91_adc_probe_pdata(struct at91_adc_state *st,
 				struct platform_device *pdev)
 {
@@ -457,7 +577,11 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 
 	st = iio_priv(idev);
 
-	ret = at91_adc_probe_pdata(st, pdev);
+	if (pdev->dev.of_node)
+		ret = at91_adc_probe_dt(st, pdev);
+	else
+		ret = at91_adc_probe_pdata(st, pdev);
+
 	if (ret) {
 		dev_err(&pdev->dev, "No platform data available.\n");
 		ret = -EINVAL;
@@ -659,11 +783,18 @@ static int __devexit at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id at91_adc_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9g20-adc" },
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
1.7.9.5

