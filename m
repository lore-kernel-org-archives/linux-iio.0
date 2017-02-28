Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28134 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751621AbdB1SUf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 13:20:35 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>
Subject: [PATCH v3 3/6] dt-bindings: iio: document interrupt trigger support
Date: Tue, 28 Feb 2017 17:51:16 +0100
Message-ID: <1488300679-3259-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Document interrupt trigger that takes a generic interrupt, and
can be used as trigger source for sampling devices such as sensors,
ADCs...

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../bindings/iio/trigger/iio-trig-interrupt.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt

diff --git a/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt b/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
new file mode 100644
index 0000000..9de9856
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt
@@ -0,0 +1,22 @@
+Interrupt based trigger
+
+Any internal or external interrupt may be used as trigger source for
+devices like sensors, ADCs... As an example, external signal can be
+routed to a GPIO, and turned into an interrupt driven trigger.
+
+Required properties:
+- compatible: Should be "interrupt-trigger"
+- interrupts: The interrupt used as trigger. Generic interrupt client node as
+  described in ../../interrupt-controller/interrupts.txt
+
+Optional properties:
+- #io-trigger-cells = <0>; See the IIO bindings, IIO trigger providers
+  and consumers sections in ../iio-bindings.txt
+
+Example:
+	trig0: interrupt-trigger0 {
+		#io-trigger-cells = <0>;
+		compatible = "interrupt-trigger";
+		interrupts = <11 0>;
+		interrupt-parent = <&gpioa>;
+	}
-- 
1.9.1

