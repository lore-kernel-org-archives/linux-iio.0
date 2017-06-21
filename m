Return-Path: <SRS0=AxCn=52=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 5/8] dt-bindings: iio: Add STM32 LPTimer trigger binding
Date: Wed, 21 Jun 2017 16:30:12 +0200
Message-ID: <1498055415-31513-6-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for STMicroelectronics STM32 Low-Power Timer Trigger
binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- s/Low Power/Low-Power
- remove leading 0x in example (parent node)
- improve reg property description
---
 .../bindings/iio/timer/stm32-lptimer-trigger.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
new file mode 100644
index 0000000..466d99f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
@@ -0,0 +1,23 @@
+STMicroelectronics STM32 Low-Power Timer Trigger
+
+STM32 Low-Power Timer provides trigger source (LPTIM output) that can be used
+by STM32 internal ADC and/or DAC.
+
+Must be a sub-node of an STM32 Low-Power Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-lptimer-trigger".
+- reg:			Selects trigger hardware block. Must be 0, 1 or 2
+			respectively for lptimer1, lptimer2 or lptimer3
+			trigger output.
+
+Example:
+	lptimer1: lptimer@40002400 {
+		compatible = "st,stm32-lptimer";
+		...
+		trigger@0 {
+			compatible = "st,stm32-lptimer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1
