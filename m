Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:52156 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdFIHJH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2017 03:09:07 -0400
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v4 2/4] Documentation: dt: iio: at91-sama5d2_adc: add hw trigger edge binding
Date: Fri, 9 Jun 2017 10:07:17 +0300
Message-ID: <1496992039-17964-3-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
References: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add property for the edge type of the hardware trigger pin ADTRG

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
  Changes in v4:
 - Modified bindings to be similar with interrupts

 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 3223684..552e7a8 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -11,6 +11,11 @@ Required properties:
   - atmel,min-sample-rate-hz: Minimum sampling rate, it depends on SoC.
   - atmel,max-sample-rate-hz: Maximum sampling rate, it depends on SoC.
   - atmel,startup-time-ms: Startup time expressed in ms, it depends on SoC.
+  - atmel,trigger-edge-type: One of possible edge types for the ADTRG hardware
+  trigger pin. When the specific edge type is detected, the conversion will
+  start. Possible values are rising, falling, or both.
+  This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
+  IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
 
 Example:
 
@@ -25,4 +30,5 @@ adc: adc@fc030000 {
 	atmel,startup-time-ms = <4>;
 	vddana-supply = <&vdd_3v3_lp_reg>;
 	vref-supply = <&vdd_3v3_lp_reg>;
+	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
 }
-- 
2.7.4

