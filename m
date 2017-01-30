Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40516 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753461AbdA3OLm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 09:11:42 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 1/5] Documentation: dt: iio: document stm32 adc trigger polarity
Date: Mon, 30 Jan 2017 14:57:39 +0100
Message-ID: <1485784663-19505-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC trigger polarity can be set to either rising, falling
or both edges. Allow to configure it from dt.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 5dfc88e..6c6d968 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -57,6 +57,8 @@ Optional properties:
 - dmas: Phandle to dma channel for this ADC instance.
   See ../../dma/dma.txt for details.
 - dma-names: Must be "rx" when dmas property is being used.
+- st,trigger-polarity: Must be 0 (default), 1 or 2 to set default trigger
+  polarity to respectively "rising-edge", "falling-edge" or "both-edges".
 
 Example:
 	adc: adc@40012000 {
@@ -84,6 +86,7 @@ Example:
 			st,adc-channels = <8>;
 			dmas = <&dma2 0 0 0x400 0x0>;
 			dma-names = "rx";
+			st,trigger-polarity = <1>;
 		};
 		...
 		other adc child nodes follow...
-- 
1.9.1

