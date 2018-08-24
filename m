Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47012 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeHXN2K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Aug 2018 09:28:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so4061483pga.13
        for <linux-iio@vger.kernel.org>; Fri, 24 Aug 2018 02:54:16 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@spreadtrum.com, broonie@kernel.org,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: sc27xx: Add ADC scale calibration
Date: Fri, 24 Aug 2018 17:53:16 +0800
Message-Id: <cc6b76c5d660818d3ff7833ea5be4f32ed960f54.1535103920.git.baolin.wang@linaro.org>
In-Reply-To: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
References: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
In-Reply-To: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
References: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support to read calibration values from the eFuse
controller to calibrate the ADC channel scales, which can make ADC
sample data more accurate.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |    4 ++
 drivers/iio/adc/sc27xx_adc.c                       |   52 ++++++++++++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
index 8aad960..b4daa15 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
@@ -12,6 +12,8 @@ Required properties:
 - interrupts: The interrupt number for the ADC device.
 - #io-channel-cells: Number of cells in an IIO specifier.
 - hwlocks: Reference to a phandle of a hwlock provider node.
+- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
+- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
 
 Example:
 
@@ -32,5 +34,7 @@ Example:
 			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
+			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
+			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
 		};
 	};
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 153c311..7ac78eda 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -5,6 +5,7 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -87,16 +88,48 @@ struct sc27xx_adc_linear_graph {
  * should use the small-scale graph, and if more than 1.2v, we should use the
  * big-scale graph.
  */
-static const struct sc27xx_adc_linear_graph big_scale_graph = {
+static struct sc27xx_adc_linear_graph big_scale_graph = {
 	4200, 3310,
 	3600, 2832,
 };
 
-static const struct sc27xx_adc_linear_graph small_scale_graph = {
+static struct sc27xx_adc_linear_graph small_scale_graph = {
 	1000, 3413,
 	100, 341,
 };
 
+static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
+	4200, 856,
+	3600, 733,
+};
+
+static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
+	1000, 833,
+	100, 80,
+};
+
+static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
+{
+	return ((calib_data & 0xff) + calib_adc - 128) * 4;
+}
+
+static void
+sc27xx_adc_scale_calibration(const struct sc27xx_adc_linear_graph *calib_graph,
+			     u32 calib_data, bool big_scale)
+{
+	struct sc27xx_adc_linear_graph *graph;
+
+	if (big_scale)
+		graph = &big_scale_graph;
+	else
+		graph = &small_scale_graph;
+
+	/* Only need to calibrate the adc values in the linear graph. */
+	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
+	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
+						calib_graph->adc1);
+}
+
 static int sc27xx_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
@@ -209,7 +242,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
 
-static int sc27xx_adc_to_volt(const struct sc27xx_adc_linear_graph *graph,
+static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 			      int raw_adc)
 {
 	int tmp;
@@ -371,6 +404,7 @@ static int sc27xx_adc_write_raw(struct iio_dev *indio_dev,
 
 static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 {
+	u32 val;
 	int ret;
 
 	ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
@@ -390,6 +424,18 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	if (ret)
 		goto disable_clk;
 
+	/* ADC channel scales' calibration from nvmem device */
+	ret = nvmem_cell_read_u32(data->dev, "big_scale_calib", &val);
+	if (ret)
+		goto disable_clk;
+
+	sc27xx_adc_scale_calibration(&big_scale_graph_calib, val, true);
+
+	ret = nvmem_cell_read_u32(data->dev, "small_scale_calib", &val);
+	if (ret)
+		goto disable_clk;
+
+	sc27xx_adc_scale_calibration(&small_scale_graph_calib, val, false);
 	return 0;
 
 disable_clk:
-- 
1.7.9.5
