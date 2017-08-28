Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6258 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751546AbdH1KFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2017 06:05:20 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>,
        <jic23@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH v3 1/9] dt-bindings: mfd: Add STM32 LPTimer binding
Date: Mon, 28 Aug 2017 12:04:06 +0200
Message-ID: <1503914654-19963-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
References: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation for STMicroelectronics STM32 Low-Power Timer binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- Rob's comment on node name: timer@...

Changes in v2:
- Lee's comments: s/Low Power/Low-Power/, remove 0x in example, improve
  properties descriptions
---
 .../devicetree/bindings/mfd/stm32-lptimer.txt      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
new file mode 100644
index 0000000..2a9ff29
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -0,0 +1,48 @@
+STMicroelectronics STM32 Low-Power Timer
+
+The STM32 Low-Power Timer (LPTIM) is a 16-bit timer that provides several
+functions:
+- PWM output (with programmable prescaler, configurable polarity)
+- Quadrature encoder, counter
+- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
+
+Required properties:
+- compatible:		Must be "st,stm32-lptimer".
+- reg:			Offset and length of the device's register set.
+- clocks:		Phandle to the clock used by the LP Timer module.
+- clock-names:		Must be "mux".
+- #address-cells:	Should be '<1>'.
+- #size-cells:		Should be '<0>'.
+
+Optional subnodes:
+- pwm:			See ../pwm/pwm-stm32-lp.txt
+- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
+- trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
+
+Example:
+
+	timer@40002400 {
+		compatible = "st,stm32-lptimer";
+		reg = <0x40002400 0x400>;
+		clocks = <&timer_clk>;
+		clock-names = "mux";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pwm {
+			compatible = "st,stm32-pwm-lp";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lppwm1_pins>;
+		};
+
+		trigger@0 {
+			compatible = "st,stm32-lptimer-trigger";
+			reg = <0>;
+		};
+
+		counter {
+			compatible = "st,stm32-lptimer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lptim1_in_pins>;
+		};
+	};
-- 
1.9.1

