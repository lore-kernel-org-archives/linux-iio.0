Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:48961 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdJ3HWi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Oct 2017 03:22:38 -0400
From: Joel Stanley <joel@jms.id.au>
To: Jonathan Cameron <jic23@kernel.org>,
        Rick Altherr <raltherr@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: Philipp Zabel <philipp.zabel@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: aspeed: Deassert reset in probe
Date: Mon, 30 Oct 2017 17:52:18 +1030
Message-Id: <20171030072218.2094-1-joel@jms.id.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ASPEED SoC must deassert a reset in order to use the ADC peripheral.

The device tree bindings are updated to document the resets phandle, and
the example is updated to match what is expected for both the reset and
clock phandle.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/iio/adc/aspeed_adc.txt      |  4 +++-
 drivers/iio/adc/aspeed_adc.c                        | 21 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
index 674e133b7cd7..034fc2ba100e 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
@@ -8,6 +8,7 @@ Required properties:
 - reg: memory window mapping address and length
 - clocks: Input clock used to derive the sample clock. Expected to be the
           SoC's APB clock.
+- resets: Reset controller phandle
 - #io-channel-cells: Must be set to <1> to indicate channels are selected
                      by index.
 
@@ -15,6 +16,7 @@ Example:
 	adc@1e6e9000 {
 		compatible = "aspeed,ast2400-adc";
 		reg = <0x1e6e9000 0xb0>;
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_ADC>;
 		#io-channel-cells = <1>;
 	};
diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 8a958d5f1905..0fc9712cdde4 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -53,11 +54,12 @@ struct aspeed_adc_model_data {
 };
 
 struct aspeed_adc_data {
-	struct device	*dev;
-	void __iomem	*base;
-	spinlock_t	clk_lock;
-	struct clk_hw	*clk_prescaler;
-	struct clk_hw	*clk_scaler;
+	struct device		*dev;
+	void __iomem		*base;
+	spinlock_t		clk_lock;
+	struct clk_hw		*clk_prescaler;
+	struct clk_hw		*clk_scaler;
+	struct reset_control	*rst;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -217,6 +219,13 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		goto scaler_error;
 	}
 
+	data->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(data->rst)) {
+		dev_err(&pdev->dev, "invalid reset controller in device tree");
+		data->rst = NULL;
+	} else
+		reset_control_deassert(data->rst);
+
 	model_data = of_device_get_match_data(&pdev->dev);
 
 	if (model_data->wait_init_sequence) {
@@ -268,6 +277,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 
 scaler_error:
 	clk_hw_unregister_divider(data->clk_prescaler);
+	reset_control_assert(data->rst);
 	return ret;
 }
 
@@ -282,6 +292,7 @@ static int aspeed_adc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->clk_scaler->clk);
 	clk_hw_unregister_divider(data->clk_scaler);
 	clk_hw_unregister_divider(data->clk_prescaler);
+	reset_control_assert(data->rst);
 
 	return 0;
 }
-- 
2.14.1

