Return-Path: <SRS0=kndm=5V=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 5/8] dt-bindings: iio: Add STM32 LPTimer trigger binding
Date: Fri, 16 Jun 2017 17:58:43 +0200
Message-ID: <1497628726-7563-6-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
References: <1497628726-7563-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for STMicroelectronics STM32 Low Power Timer trigger
binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/iio/timer/stm32-lptimer-trigger.txt    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
new file mode 100644
index 0000000..6ece007
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
@@ -0,0 +1,21 @@
+STMicroelectronics STM32 Low Power Timer trigger
+
+STM32 LP Timer provides trigger source (LPTIM output) that can be used
+by STM32 internal ADC and/or DAC.
+
+Must be a sub-node of an STM32 LP Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required properties:
+- compatible: Must be "st,stm32-lptimer-trigger".
+- reg: Identify trigger hardware block.
+
+Example:
+	lptimer1: lptimer@0x40002400 {
+		compatible = "st,stm32-lptimer";
+		...
+		trigger@0 {
+			compatible = "st,stm32-lptimer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1
