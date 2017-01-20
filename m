Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37849 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdATJRK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 04:17:10 -0500
Received: by mail-wm0-f48.google.com with SMTP id c206so33995627wme.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Jan 2017 01:16:24 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v9 3/8] dt-bindings: pwm: Add STM32 bindings
Date: Fri, 20 Jan 2017 10:15:04 +0100
Message-Id: <1484903709-11650-4-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define bindings for pwm-stm32

version 9:
- change commit message header

version 8:
- reword st,breakinput description.

version 6:
- change st,breakinput parameter format to make it usuable on stm32f7 too.

version 2:
- use parameters instead of compatible of handle the hardware configuration

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
new file mode 100644
index 0000000..6dd0403
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -0,0 +1,35 @@
+STMicroelectronics STM32 Timers PWM bindings
+
+Must be a sub-node of an STM32 Timers device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required parameters:
+- compatible:		Must be "st,stm32-pwm".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
+			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
+
+Optional parameters:
+- st,breakinput:	One or two <index level filter> to describe break input configurations.
+			"index" indicates on which break input (0 or 1) the configuration
+			should be applied.
+			"level" gives the active level (0=low or 1=high) of the input signal
+			for this configuration.
+			"filter" gives the filtering value to be applied.
+
+Example:
+	timers@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm {
+			compatible = "st,stm32-pwm";
+			pinctrl-0	= <&pwm1_pins>;
+			pinctrl-names	= "default";
+			st,breakinput = <0 1 5>;
+		};
+	};
-- 
1.9.1

