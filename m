Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:36225 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbbJFIMn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 6 Oct 2015 04:12:43 -0400
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v4 2/2] iio: ti-ads8688: Add DT binding documentation
Date: Tue, 6 Oct 2015 10:12:36 +0200
Message-ID: <1444119156-8316-2-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1444119156-8316-1-git-send-email-sean.nyekjaer@prevas.dk>
References: <1444119156-8316-1-git-send-email-sean.nyekjaer@prevas.dk>
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
2.6.0

