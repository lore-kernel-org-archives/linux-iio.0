Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37082 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbCHNhh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 09:37:37 -0400
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] iio: mcp3422: Add DT binding documentation
Date: Sun,  8 Mar 2015 14:37:23 +0100
Message-Id: <1425821843-29185-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding binding documentation for ADC MCP3422.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
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

