Return-Path: <SRS0=AxCn=52=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 7/8] dt-bindings: iio: Add STM32 LPTimer quadrature encoder and counter
Date: Wed, 21 Jun 2017 16:30:14 +0200
Message-ID: <1498055415-31513-8-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for STMicroelectronics STM32 Low-Power Timer
quadrature encoder and counter binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- s/Low Power/Low-Power
- remove leading 0x in example (parent node)
- improve properties descriptions
---
 .../bindings/iio/counter/stm32-lptimer-cnt.txt     | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
new file mode 100644
index 0000000..b9fd014
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
@@ -0,0 +1,27 @@
+STMicroelectronics STM32 Low-Power Timer quadrature encoder and counter
+
+STM32 Low-Power Timer provides several counter modes. It can be used as:
+- quadrature encoder to detect angular position and direction of rotary
+  elements, from IN1 and IN2 input signals.
+- simple counter from IN1 input signal.
+
+Must be a sub-node of an STM32 Low-Power Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-lptimer-counter".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+			to set IN1/IN2 pins in mode of operation for Low-Power
+			Timer input on external pin.
+
+Example:
+	lptimer1: lptimer@40002400 {
+		compatible = "st,stm32-lptimer";
+		...
+		counter {
+			compatible = "st,stm32-lptimer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lptim1_in_pins>;
+		};
+	};
-- 
1.9.1
