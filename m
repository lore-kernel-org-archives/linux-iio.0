Return-Path: <SRS0=YqtP=6V=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: adc: stm32: add optional min-sample-time
Date: Tue, 18 Jul 2017 14:35:31 +0200
Message-ID: <1500381332-17086-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1500381332-17086-1-git-send-email-fabrice.gasnier@st.com>
References: <1500381332-17086-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

STM32 ADC allows each channel to be sampled with a different sampling
time. There's an application note that deals with this: 'How to get
the best ADC accuracy in STM32...' It basically depends on analog input
signal electrical properties (depends on board).

Add optional 'min-sample-time' property so this can be tuned in dt.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 8310073..9cd964b 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -74,6 +74,11 @@ Optional properties:
   * can be 6, 8, 10 or 12 on stm32f4
   * can be 8, 10, 12, 14 or 16 on stm32h7
   Default is maximum resolution if unset.
+- min-sample-time: Minimum sampling time in nanoseconds.
+  Depending on hardware (board) e.g. high/low analog input source impedance,
+  fine tune of ADC sampling time may be recommended.
+  This can be either one value or an array that matches 'st,adc-channels' list,
+  to set sample time resp. for all channels, or independently for each channel.
 
 Example:
 	adc: adc@40012000 {
-- 
1.9.1
