Return-Path: <josh.wu@atmel.com>
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
        nicolas.ferre@atmel.com, Josh Wu <josh.wu@atmel.com>
Subject: [PATCH 4/5] iio: at91: add an optional dt property for for adc clock hz.
Date: Sun, 14 Jul 2013 16:04:28 +0800
Message-Id: <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 Documentation/devicetree/bindings/arm/atmel-adc.txt |    2 ++
 drivers/iio/adc/at91_adc.c                          |    8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index 16769d9..0db2945 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -27,6 +27,8 @@ Optional properties:
 		       resolution will be used.
   - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
   - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
+  - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
+			  adc_op_clk.
  
 Optional trigger Nodes:
   - Required properties:
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index e93a075..8f1386f 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -47,6 +47,7 @@ struct at91_adc_caps {
 
 struct at91_adc_state {
 	struct clk		*adc_clk;
+	u32			adc_clk_rate;
 	u16			*buffer;
 	unsigned long		channels_mask;
 	struct clk		*clk;
@@ -448,6 +449,10 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	if (!node)
 		return -EINVAL;
 
+	prop = 0;
+	of_property_read_u32(node, "atmel,adc-clock-rate", &prop);
+	st->adc_clk_rate = prop;
+
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
 	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop)) {
@@ -723,7 +728,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 	 * specified by the electrical characteristics of the board.
 	 */
 	mstrclk = clk_get_rate(st->clk);
-	adc_clk = clk_get_rate(st->adc_clk);
+	adc_clk = st->adc_clk_rate ?
+		st->adc_clk_rate : clk_get_rate(st->adc_clk);
 	adc_clk_khz = adc_clk / 1000;
 	prsc = (mstrclk / (2 * adc_clk)) - 1;
 
-- 
1.7.10
