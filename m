Return-Path: <SRS0=kndm=5V=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 1/8] dt-bindings: mfd: Add STM32 LPTimer binding
Date: Fri, 16 Jun 2017 17:58:39 +0200
Message-ID: <1497628726-7563-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for STMicroelectronics STM32 Low Power Timer binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/mfd/stm32-lptimer.txt      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
new file mode 100644
index 0000000..237b7d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -0,0 +1,51 @@
+STMicroelectronics STM32 Low Power Timer
+
+The STM32 Low Power Timer (LPTIM) is a 16-bit timer that provides several
+functionalities:
+- PWM output (with programmable prescaler, configurable polarity)
+- Quadrature encoder, counter
+- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
+
+Required properties:
+- compatible: Must be "st,stm32-lptimer".
+- reg: Offset and length of the device's register set.
+- clocks: Phandle to the clock used by the LP Timer module.
+- clock-names: Must be "int".
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties:
+- resets: Must contain the phandle to the reset controller.
+
+Optional subnodes:
+- pwm: See ../pwm/pwm-stm32-lp.txt
+- counter: See ../iio/timer/stm32-lptimer-cnt.txt
+- trigger: See ../iio/timer/stm32-lptimer-trigger.txt
+
+Example:
+
+	lptimer1: lptimer@0x40002400 {
+		compatible = "st,stm32-lptimer";
+		reg = <0x40002400 0x400>;
+		clocks = <&timer_clk>;
+		clock-names = "int";
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
