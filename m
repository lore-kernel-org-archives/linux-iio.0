Return-Path: <SRS0=bqw6=63=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: stm32: add optional st,min-sample-time-nsecs
Date: Mon, 24 Jul 2017 18:10:39 +0200
Message-ID: <1500912640-23927-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
References: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

STM32 ADC allows each channel to be sampled with a different sampling
time. There's an application note that deals with this: 'How to get
the best ADC accuracy in STM32...' It basically depends on analog input
signal electrical properties (depends on board).

Add optional 'st,min-sample-time-nsecs' property so this can be tuned
in dt.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Use 'st,min-sample-time-nsecs' instead of 'min-sample-time'.
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 8310073..48bfcaa3 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -74,6 +74,11 @@ Optional properties:
   * can be 6, 8, 10 or 12 on stm32f4
   * can be 8, 10, 12, 14 or 16 on stm32h7
   Default is maximum resolution if unset.
+- st,min-sample-time-nsecs: Minimum sampling time in nanoseconds.
+  Depending on hardware (board) e.g. high/low analog input source impedance,
+  fine tune of ADC sampling time may be recommended.
+  This can be either one value or an array that matches 'st,adc-channels' list,
+  to set sample time resp. for all channels, or independently for each channel.
 
 Example:
 	adc: adc@40012000 {
-- 
1.9.1
