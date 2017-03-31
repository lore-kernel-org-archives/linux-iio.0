Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933147AbdCaMdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 08:33:46 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: stm32-adc: add option to set resolution
Date: Fri, 31 Mar 2017 14:32:37 +0200
Message-ID: <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
References: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation for 'assigned-resolution-bits' dt optional property.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- rename property from 'st,adc-res' to 'assigned-resolution-bits' so it
  is more common.
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 5dfc88e..e35f9f1 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -57,6 +57,9 @@ Optional properties:
 - dmas: Phandle to dma channel for this ADC instance.
   See ../../dma/dma.txt for details.
 - dma-names: Must be "rx" when dmas property is being used.
+- assigned-resolution-bits: Resolution (bits) to use for conversions. Must
+  match device available resolutions (e.g. can be 6, 8, 10 or 12 on stm32f4).
+  Default is maximum resolution if unset.
 
 Example:
 	adc: adc@40012000 {
@@ -84,6 +87,7 @@ Example:
 			st,adc-channels = <8>;
 			dmas = <&dma2 0 0 0x400 0x0>;
 			dma-names = "rx";
+			assigned-resolution-bits = <8>;
 		};
 		...
 		other adc child nodes follow...
-- 
1.9.1

