Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35784 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933346AbcLIOQb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2016 09:16:31 -0500
Received: by mail-wm0-f41.google.com with SMTP id a197so28325791wmd.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Dec 2016 06:16:25 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org, benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v6 3/8] PWM: add pwm-stm32 DT bindings
Date: Fri,  9 Dec 2016 15:15:14 +0100
Message-Id: <1481292919-26587-4-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define bindings for pwm-stm32

version 6:
- change st,breakinput parameter format to make it usuable on stm32f7 too.

version 2:
- use parameters instead of compatible of handle the hardware configuration

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
new file mode 100644
index 0000000..866f222
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -0,0 +1,33 @@
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
+- st,breakinput:	Arrays of three u32 <index level filter> to describe break input configurations.
+			"index" indicates on which break input the configuration should be applied.
+			"level" gives the active level (0=low or 1=high) for this configuration.
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

