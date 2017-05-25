Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12675 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423387AbdEYLUU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 May 2017 07:20:20 -0400
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@microchip.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v3 2/4] Documentation: dt: iio: at91-sama5d2_adc: add adtrg trigger binding
Date: Thu, 25 May 2017 14:17:12 +0300
Message-ID: <1495711034-28410-3-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
References: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add node information for ADTRG hardware pin and the three possible
edge nodes that are available for the driver

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 3223684..e30ede3 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -11,6 +11,13 @@ Required properties:
   - atmel,min-sample-rate-hz: Minimum sampling rate, it depends on SoC.
   - atmel,max-sample-rate-hz: Maximum sampling rate, it depends on SoC.
   - atmel,startup-time-ms: Startup time expressed in ms, it depends on SoC.
+  - atmel,trigger-edge-type: phandle to one of the adtrg possible edge types
+
+Required adtrg node:
+  - Required edge nodes:
+	For each possible edge type for the ADTRG hardware trigger pin,
+	 a specific sub node. The driver recognises only the three possible
+	 edge types: external_rising, external_falling, external_any.
 
 Example:
 
@@ -25,4 +32,14 @@ adc: adc@fc030000 {
 	atmel,startup-time-ms = <4>;
 	vddana-supply = <&vdd_3v3_lp_reg>;
 	vref-supply = <&vdd_3v3_lp_reg>;
+	atmel,trigger-edge-type = <&external_rising>;
+
+	adtrg: adtrg {
+		external_rising: external_rising {
+		};
+		external_falling: external_falling {
+		};
+		external_any: external_any {
+		};
+	};
 }
-- 
2.7.4

