Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43550 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932185AbdA3OfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 09:35:25 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 3/5] Documentation: dt: iio: document stm32 exti trigger
Date: Mon, 30 Jan 2017 15:33:58 +0100
Message-ID: <1485786840-4557-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add dt documentation for st,stm32-exti-trigger.
EXTi gpio signal can be routed internally as trigger source for various
IPs (e.g. for ADC or DAC conversions).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/iio/trigger/st,stm32-exti-trigger.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
new file mode 100644
index 0000000..ebf2645
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
@@ -0,0 +1,17 @@
+STMicroelectronics STM32 EXTI trigger bindings
+
+EXTi gpio signal can be routed internally as trigger source for various
+IPs (e.g. for ADC or DAC conversions).
+
+Contents of a stm32 exti trigger root node:
+-------------------------------------------
+Required properties:
+- compatible: Should be "st,stm32-exti-trigger"
+- extiN-gpio: optional gpio line that may be used as external trigger source
+  (e.g. N may be 0..15. For example, exti11-gpio can trig ADC on stm32f4).
+
+Example:
+	triggers {
+		compatible = "st,stm32-exti-trigger";
+		exti11-gpio=<&gpioa 11 0>;
+	};
-- 
1.9.1

