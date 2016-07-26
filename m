Return-Path: <caesar.upstream@gmail.com>
From: Caesar Wang <wxt@rock-chips.com>
To: jic23@kernel.org
Cc: heiko@sntech.de,
	robh+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux@roeck-us.net,
	dianders@chromium.org,
	Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 1/4] iio: adc: rockchip_saradc: reset saradc controller before programming it
Date: Tue, 26 Jul 2016 14:11:47 +0800
Message-Id: <1469513510-1516-1-git-send-email-wxt@rock-chips.com>
List-ID: <linux-iio@vger.kernel.org>

SARADC controller needs to be reset before programming it, otherwise
it will not function properly.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
---

 .../bindings/iio/adc/rockchip-saradc.txt           |  5 +++++
 drivers/iio/adc/Kconfig                            |  1 +
 drivers/iio/adc/rockchip_saradc.c                  | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
index bf99e2f..d2258be 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
@@ -13,6 +13,9 @@ Required properties:
 - clocks: Must contain an entry for each entry in clock-names.
 - clock-names: Shall be "saradc" for the converter-clock, and "apb_pclk" for
                the peripheral clock.
+- resets: Must contain an entry for each entry in reset-names.
+	  See ../reset/reset.txt for details.
+- reset-names: Must include the name "saradc-apb".
 - vref-supply: The regulator supply ADC reference voltage.
 - #io-channel-cells: Should be 1, see ../iio-bindings.txt
 
@@ -23,6 +26,8 @@ Example:
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_SARADC>;
+		reset-names = "saradc-apb";
 		#io-channel-cells = <1>;
 		vref-supply = <&vcc18>;
 	};
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1de31bd..7675772 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -389,6 +389,7 @@ config QCOM_SPMI_VADC
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
+	depends on RESET_CONTROLLER
 	help
 	  Say yes here to build support for the SARADC found in SoCs from
 	  Rockchip.
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index f9ad6c2..2f0e110 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -21,6 +21,8 @@
 #include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/reset.h>
 #include <linux/regulator/consumer.h>
 #include <linux/iio/iio.h>
 
@@ -53,6 +55,7 @@ struct rockchip_saradc {
 	struct clk		*clk;
 	struct completion	completion;
 	struct regulator	*vref;
+	struct reset_control	*reset;
 	const struct rockchip_saradc_data *data;
 	u16			last_val;
 };
@@ -190,6 +193,16 @@ static const struct of_device_id rockchip_saradc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
 
+/**
+ * Reset SARADC Controller.
+ */
+static void rockchip_saradc_reset_controller(struct reset_control *reset)
+{
+	reset_control_assert(reset);
+	usleep_range(10, 20);
+	reset_control_deassert(reset);
+}
+
 static int rockchip_saradc_probe(struct platform_device *pdev)
 {
 	struct rockchip_saradc *info = NULL;
@@ -218,6 +231,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
+	info->reset = devm_reset_control_get(&pdev->dev, "saradc-apb");
+	if (IS_ERR(info->reset)) {
+		ret = PTR_ERR(info->reset);
+		dev_err(&pdev->dev, "failed to get saradc reset: %d\n", ret);
+		return ret;
+	}
+
 	init_completion(&info->completion);
 
 	irq = platform_get_irq(pdev, 0);
@@ -252,6 +272,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		return PTR_ERR(info->vref);
 	}
 
+	rockchip_saradc_reset_controller(info->reset);
+
 	/*
 	 * Use a default value for the converter clock.
 	 * This may become user-configurable in the future.
-- 
1.9.1
