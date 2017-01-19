Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26907 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752727AbdASNfb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 08:35:31 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 4/7] Documentation: dt: iio: stm32-adc: optional dma support
Date: Thu, 19 Jan 2017 14:34:11 +0100
Message-ID: <1484832854-6314-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC can use dma. Add dt documentation for optional dma support.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 49ed82e..5dfc88e 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -53,6 +53,11 @@ Required properties:
 - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
   Documentation/devicetree/bindings/iio/iio-bindings.txt
 
+Optional properties:
+- dmas: Phandle to dma channel for this ADC instance.
+  See ../../dma/dma.txt for details.
+- dma-names: Must be "rx" when dmas property is being used.
+
 Example:
 	adc: adc@40012000 {
 		compatible = "st,stm32f4-adc-core";
@@ -77,6 +82,8 @@ Example:
 			interrupt-parent = <&adc>;
 			interrupts = <0>;
 			st,adc-channels = <8>;
+			dmas = <&dma2 0 0 0x400 0x0>;
+			dma-names = "rx";
 		};
 		...
 		other adc child nodes follow...
-- 
1.9.1

