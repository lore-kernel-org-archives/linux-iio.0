Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:62843 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbbBPLVW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Feb 2015 06:21:22 -0500
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] iio: mcp3422: Add DT binding documentation
Date: Mon, 16 Feb 2015 12:21:03 +0100
Message-Id: <1424085663-21799-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding binding documentation for ADC MCP3422.
---
 Documentation/devicetree/bindings/iio/adc/mcp3422.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3422.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
new file mode 100644
index 0000000..333139c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
@@ -0,0 +1,17 @@
+* Microchip mcp3422/3/4/6/7/8 chip family (ADC)
+
+Required properties:
+ - compatible: Should be
+	"microchip,mcp3422" or
+	"microchip,mcp3423" or
+	"microchip,mcp3424" or
+	"microchip,mcp3426" or
+	"microchip,mcp3427" or
+	"microchip,mcp3428"
+ - reg: I2C address for the device
+
+Example:
+adc@0 {
+	compatible = "microchip,mcp3424";
+	reg = <0x68>;
+};
-- 
1.9.1

