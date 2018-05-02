Return-Path: <SRS0=yk1a=HV=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC: <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: iio: stm32-adc: add support for STM32MP1
Date: Wed, 2 May 2018 09:44:49 +0200
Message-ID: <1525247091-18143-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
Introduce "st,stm32mp1-adc" compatible to handle variants of this
hardware such as vregready flag, interrupts, clock rate.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Update dt-bindings following Rob's remark: STM32MP1 ADC has two
  interrupt lines
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index e8bb824..f1ead43 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -24,8 +24,11 @@ Required properties:
 - compatible: Should be one of:
   "st,stm32f4-adc-core"
   "st,stm32h7-adc-core"
+  "st,stm32mp1-adc-core"
 - reg: Offset and length of the ADC block register set.
-- interrupts: Must contain the interrupt for ADC block.
+- interrupts: One or more interrupts for ADC block. Some parts like stm32f4
+  and stm32h7 share a common ADC interrupt line. stm32mp1 has two separate
+  interrupt lines, one for each ADC within ADC block.
 - clocks: Core can use up to two clocks, depending on part used:
   - "adc" clock: for the analog circuitry, common to all ADCs.
     It's required on stm32f4.
@@ -53,6 +56,7 @@ Required properties:
 - compatible: Should be one of:
   "st,stm32f4-adc"
   "st,stm32h7-adc"
+  "st,stm32mp1-adc"
 - reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
 - clocks: Input clock private to this ADC instance. It's required only on
   stm32f4, that has per instance clock input for registers access.
-- 
1.9.1
