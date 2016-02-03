Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:53423 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbcBCObL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Feb 2016 09:31:11 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 2/4] iio: ad5755: Add DT binding documentation
Date: Wed, 3 Feb 2016 15:31:02 +0100
Message-ID: <1454509864-32285-2-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
References: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Changes since v1:
- none

 .../devicetree/bindings/iio/dac/ad5755.txt         | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
new file mode 100644
index 0000000..4c91583
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
@@ -0,0 +1,24 @@
+* Analog Device AD5755 IIO Multi-Channel DAC Linux Driver
+
+Required properties:
+ - compatible: Has to contain one of the following:
+	adi,ad5755
+	adi,ad5755-1
+	adi,ad5757
+	adi,ad5735
+	adi,ad5737
+
+ - reg: spi chip select number for the device
+ - spi-cpha or spi-cpol: is the only modes that is supported
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+dac@0 {
+	compatible = "adi,ad5755";
+	reg = <0>;
+	spi-max-frequency = <1000000>;
+	spi-cpha;
+};
-- 
2.7.0

