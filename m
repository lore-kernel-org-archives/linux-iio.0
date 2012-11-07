Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65315 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab2KGQo4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Nov 2012 11:44:56 -0500
From: Alban Bedel <alban.bedel@avionic-design.de>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <stigge@antcom.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alban Bedel <alban.bedel@avionic-design.de>
Subject: [PATCH] staging:iio:lpc32xx_adc: Add scale/offset support
Date: Wed,  7 Nov 2012 17:44:50 +0100
Message-Id: <1352306690-25841-1-git-send-email-alban.bedel@avionic-design.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 .../bindings/staging/iio/adc/lpc32xx-adc.txt       |    6 ++++
 drivers/staging/iio/adc/lpc32xx_adc.c              |   30 +++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
index b3629d3..515c128 100644
--- a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
+++ b/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
@@ -6,6 +6,11 @@ Required properties:
   region.
 - interrupts: The ADC interrupt
 
+Optional properties:
+- reference-voltages: the 3 reference voltages value (in mV) to use
+  for scaling. If not given or 0 a scaling factor of 1 is used.
+- offsets: the 3 offsets to add to the raw value before scaling.
+
 Example:
 
 	adc@40048000 {
@@ -13,4 +18,5 @@ Example:
 		reg = <0x40048000 0x1000>;
 		interrupt-parent = <&mic>;
 		interrupts = <39 0>;
+		reference-voltages = <5000>, <3300>, <1200>;
 	};
diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 10c5962..aaa23ac 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -64,6 +64,8 @@ struct lpc32xx_adc_info {
 	struct completion completion;
 
 	u32 value;
+	u32 ref_voltage[3];
+	u32 offset[3];
 };
 
 static int lpc32xx_read_raw(struct iio_dev *indio_dev,
@@ -91,6 +93,26 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	}
 
+	if (mask == IIO_CHAN_INFO_SCALE) {
+		if (info->ref_voltage[chan->channel]) {
+			unsigned factor;
+			factor = div_u64((u64)info->ref_voltage[chan->channel] *
+					 (u64)1000000,
+					 ADC_VALUE_MASK);
+			*val = factor / 1000000;
+			*val2 = factor % 1000000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		} else {
+			*val = 1;
+			return IIO_VAL_INT;
+		}
+	}
+
+	if (mask == IIO_CHAN_INFO_OFFSET) {
+		*val = info->offset[chan->channel];
+		return IIO_VAL_INT;
+	}
+
 	return -EINVAL;
 }
 
@@ -103,7 +125,9 @@ static const struct iio_info lpc32xx_adc_iio_info = {
 	.type = IIO_VOLTAGE,				\
 	.indexed = 1,					\
 	.channel = _index,				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
+	             IIO_CHAN_INFO_SCALE_SEPARATE_BIT |	\
+	             IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,	\
 	.address = AD_IN * _index,			\
 	.scan_index = _index,				\
 }
@@ -149,6 +173,10 @@ static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
 	}
 
 	info = iio_priv(iodev);
+	of_property_read_u32_array(pdev->dev.of_node, "reference-voltages",
+				   info->ref_voltage, ARRAY_SIZE(info->ref_voltage));
+	of_property_read_u32_array(pdev->dev.of_node, "offsets",
+				   info->offset, ARRAY_SIZE(info->offset));
 
 	info->adc_base = ioremap(res->start, resource_size(res));
 	if (!info->adc_base) {
-- 
1.7.0.4

