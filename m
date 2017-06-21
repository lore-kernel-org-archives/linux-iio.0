Return-Path: <SRS0=AxCn=52=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 3/8] dt-bindings: pwm: Add STM32 LPTimer PWM binding
Date: Wed, 21 Jun 2017 16:30:10 +0200
Message-ID: <1498055415-31513-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for STMicroelectronics STM32 Low-Power Timer
PWM binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- s/Low Power/Low-Power/
- remove 0x in example (parent node)
- improve properties description
---
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
new file mode 100644
index 0000000..941c990
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -0,0 +1,24 @@
+STMicroelectronics STM32 Low-Power Timer PWM
+
+STM32 Low-Power Timer provides single channel PWM.
+
+Must be a sub-node of an STM32 Low-Power Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required parameters:
+- compatible:		Must be "st,stm32-pwm-lp".
+
+Optional properties:
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		Phandle pointing to pin configuration node for PWM.
+
+Example:
+	lptimer1: lptimer@40002400 {
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
