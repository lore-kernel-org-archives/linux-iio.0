Return-Path: <SRS0=acV6=7M=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
	<linux-iio@vger.kernel.org>, <jic23@kernel.org>,
	<alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH 1/3] Documentation: dt: iio: at91-sama5d2_adc: add optional dma property
Date: Thu, 10 Aug 2017 15:34:57 +0300
Message-ID: <1502368499-6739-2-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
References: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Added property for DMA configuration of the device.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 552e7a8..5f94d47 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -17,6 +17,11 @@ Required properties:
   This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
   IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
 
+Optional properties:
+  - dmas: Phandle to dma channel for the ADC.
+  See ../../dma/dma.txt for details.
+  - dma-names: Must be "rx" when dmas property is being used.
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
