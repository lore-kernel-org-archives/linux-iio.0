Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr50136.outbound.protection.outlook.com ([40.107.5.136]:35411
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754029AbeCVKYN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Mar 2018 06:24:13 -0400
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: jic23@kernel.org, robh+dt@kernel.org
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 2/2] iio: ti-dac5571: Add DT binding documentation
Date: Thu, 22 Mar 2018 11:23:36 +0100
Message-Id: <20180322102336.32268-2-sean.nyekjaer@prevas.dk>
In-Reply-To: <20180322102336.32268-1-sean.nyekjaer@prevas.dk>
References: <20180322102336.32268-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding binding documentation for Texas Instruments DAC5571 Family

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 .../devicetree/bindings/iio/dac/ti,dac5571.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
new file mode 100644
index 000000000000..03af6b9a4d07
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
@@ -0,0 +1,24 @@
+* Texas Instruments DAC5571 Family
+
+Required properties:
+ - compatible: Should contain
+    "ti,dac5571"
+    "ti,dac6571"
+    "ti,dac7571"
+    "ti,dac5574"
+    "ti,dac6574"
+    "ti,dac7574"
+    "ti,dac5573"
+    "ti,dac6573"
+    "ti,dac7573"
+ - reg: Should contain the DAC I2C address
+
+Optional properties:
+ - vref-supply: The regulator supply for DAC reference voltage
+
+Example:
+dac@0 {
+	compatible = "ti,dac5571";
+	reg = <0x4C>;
+	vref-supply = <&vdd_supply>;
+};
-- 
2.16.2

