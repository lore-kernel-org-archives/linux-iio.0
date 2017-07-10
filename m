Return-Path: <SRS0=ii5x=6N=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: iio: stm32-dac: add support for STM32F4
Date: Mon, 10 Jul 2017 15:23:57 +0200
Message-ID: <1499693040-12994-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Introduce new compatible to support STM32F4 DAC (Digital-To-Analog
converter) variant.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
index bcee71f..bf2925c 100644
--- a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
+++ b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
@@ -10,7 +10,9 @@ current.
 Contents of a stm32 dac root node:
 -----------------------------------
 Required properties:
-- compatible: Must be "st,stm32h7-dac-core".
+- compatible: Should be one of:
+  "st,stm32f4-dac-core"
+  "st,stm32h7-dac-core"
 - reg: Offset and length of the device's register set.
 - clocks: Must contain an entry for pclk (which feeds the peripheral bus
   interface)
-- 
1.9.1
