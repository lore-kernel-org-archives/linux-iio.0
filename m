Return-Path: <SRS0=kndm=5V=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 3/8] dt-bindings: pwm: Add STM32 LPTimer PWM binding
Date: Fri, 16 Jun 2017 17:58:41 +0200
Message-ID: <1497628726-7563-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for STMicroelectronics STM32 Low Power Timer
PWM binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
new file mode 100644
index 0000000..8eebe31
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -0,0 +1,24 @@
+STMicroelectronics STM32 Low Power Timer PWM
+
+STM32 LP Timer provides single channel PWM.
+
+Must be a sub-node of an STM32 LP Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required parameters:
+- compatible: Must be "st,stm32-pwm-lp".
+
+Optional properties:
+- A pinctrl state named "default" can be defined to set a pin in mode of
+  operation for PWM output on external pin.
+
+Example:
+	lptimer1: lptimer@0x40002400 {
+		compatible = "st,stm32-lptimer";
+		...
+		pwm {
+			compatible = "st,stm32-pwm-lp";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lppwm1_pins>;
+		};
+	};
-- 
1.9.1
