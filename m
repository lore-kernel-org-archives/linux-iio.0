Return-Path: <SRS0=TmfX=7F=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 1/3] dt-bindings: iio: timer: stm32: add support for STM32H7
Date: Thu, 3 Aug 2017 11:14:12 +0200
Message-ID: <1501751654-14153-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
References: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

STM32H7 has slightly different triggers than previous versions.
Introduce st,stm32h7-timer-trigger compatible to handle this new variant.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
index 55a653d..b565ced 100644
--- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -4,7 +4,9 @@ Must be a sub-node of an STM32 Timers device tree node.
 See ../mfd/stm32-timers.txt for details about the parent node.
 
 Required parameters:
-- compatible:	Must be "st,stm32-timer-trigger".
+- compatible:	Must be one of:
+		"st,stm32-timer-trigger"
+		"st,stm32h7-timer-trigger"
 - reg:		Identify trigger hardware block.
 
 Example:
-- 
1.9.1
