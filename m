Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:10694 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754447AbbJ0JCF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 27 Oct 2015 05:02:05 -0400
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v5 2/2] iio: ti-ads8688: Add DT binding documentation
Date: Tue, 27 Oct 2015 10:01:48 +0100
Message-ID: <1445936508-9272-2-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1445936508-9272-1-git-send-email-sean.nyekjaer@prevas.dk>
References: <1445936508-9272-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding binding documentation for Texas Instruments ADS8688 ADC.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>
---
Changes since v2:
- Moved vref-supply to Optional properties

 .../devicetree/bindings/iio/adc/ti-ads8688.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
new file mode 100644
index 0000000..a02337d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
@@ -0,0 +1,20 @@
+* Texas Instruments' ADS8684 and ADS8688 ADC chip
+
+Required properties:
+ - compatible: Should be "ti,ads8684" or "ti,ads8688"
+ - reg: spi chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+ - vref-supply: The regulator supply for ADC reference voltage
+
+Example:
+adc@0 {
+	compatible = "ti,ads8688";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <1000000>;
+};
-- 
2.6.2

