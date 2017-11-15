Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:32372 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932498AbdKONIx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Nov 2017 08:08:53 -0500
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v3 1/4] dt-bindings: iio: at91-sama5d2_adc: add optional dma property
Date: Wed, 15 Nov 2017 14:56:45 +0200
Message-ID: <1510750608-8697-2-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added property for DMA configuration of the device.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Changes in v3:
None, but we discussed on the ML about whether we should have "dma-names"
present in the binding even if it's only one.
The helpers in the kernel to retrieve the channel info rely on the
presence of this property, so I am resending the patch based on this.
If another solution is better, please advise and I can try it and
resend the patch.

 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 552e7a8..6469a4c 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -17,6 +17,11 @@ Required properties:
   This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
   IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
 
+Optional properties:
+  - dmas: Phandle to dma channel for the ADC.
+  - dma-names: Must be "rx" when dmas property is being used.
+  See ../../dma/dma.txt for details.
+
 Example:
 
 adc: adc@fc030000 {
@@ -31,4 +36,6 @@ adc: adc@fc030000 {
 	vddana-supply = <&vdd_3v3_lp_reg>;
 	vref-supply = <&vdd_3v3_lp_reg>;
 	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
+	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
+	dma-names = "rx";
 }
-- 
2.7.4

