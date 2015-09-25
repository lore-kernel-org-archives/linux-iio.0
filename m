Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:42730 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbbIYGaD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Sep 2015 02:30:03 -0400
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCHv2 2/2] iio: ti-ads868x: Add DT binding documentation
Date: Fri, 25 Sep 2015 08:29:40 +0200
Message-ID: <1443162580-28293-2-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1443162580-28293-1-git-send-email-sean.nyekjaer@prevas.dk>
References: <1443162580-28293-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding binding documentation for Texas Instruments ADS868X ADC.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>
---
 .../devicetree/bindings/iio/adc/ti-ads868x.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt
new file mode 100644
index 0000000..bc3c305
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt
@@ -0,0 +1,18 @@
+* Texas Instruments' ADS8684 and ADS8688 ADC chip
+
+Required properties:
+ - compatible: Should be "ti,ads8684" or "ti,ads8688"
+ - reg: spi chip select number for the device
+ - vref-supply: The regulator supply for ADC reference voltage
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+adc@0 {
+	compatible = "ti,ads8688";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <1000000>;
+};
-- 
2.5.3

