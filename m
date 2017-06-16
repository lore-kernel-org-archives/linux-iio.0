Return-Path: <SRS0=kndm=5V=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 7/8] dt-bindings: iio: Add STM32 LPTimer quadrature encoder and counter
Date: Fri, 16 Jun 2017 17:58:45 +0200
Message-ID: <1497628726-7563-8-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for STMicroelectronics STM32 Low Power Timer
quadrature encoder and counter binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/iio/counter/stm32-lptimer-cnt.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
new file mode 100644
index 0000000..e31e54d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
@@ -0,0 +1,25 @@
+STMicroelectronics STM32 Low Power Timer quadrature encoder and counter
+
+STM32 LP Timer provides several counter modes. It can be used as:
+- quadrature encoder to detect angular position and direction of rotary
+  elements, from IN1 and IN2 input signals.
+- simple counter from IN1 input signal.
+
+Must be a sub-node of an STM32 LP Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required properties:
+- compatible: Must be "st,stm32-lptimer-counter".
+- A pinctrl state named "default" can be defined to set IN1/IN2 pins in mode
+  of operation for LP Timer input signals on external pin.
+
+Example:
+	lptimer1: lptimer@0x40002400 {
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
