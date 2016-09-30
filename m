Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:59483 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932813AbcI3N0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 09:26:42 -0400
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
Subject: [PATCH 2/3] Documentation: dt: iio: add mcp4725/6 dac device binding
Date: Fri, 30 Sep 2016 15:19:47 +0200
Message-Id: <1475241588-18429-3-git-send-email-tomas@novotny.cz>
In-Reply-To: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
References: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 .../devicetree/bindings/iio/dac/mcp4725.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt b/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
new file mode 100644
index 0000000..69c9462
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
@@ -0,0 +1,28 @@
+Microchpip mcp4725 and mcp4726 DAC device driver
+
+Required properties:
+	- compatible: Must be "microchip,mcp4725" or "microchip,mcp4726"
+	- reg: Should contain the DAC I2C address
+	- vref-millivolt: Value of the reference voltage
+
+Optional properties:
+	- vref-mode: Reference voltage selection. It is available only on
+	  mcp4726. Valid values are:
+		- 0, 1: Vdd pin voltage (unbuffered)
+		- 2: Vref pin voltage unbuffered
+		- 3: Vref pin voltage internally buffered
+
+Examples:
+
+        mcp4725@60 {
+                compatible = "microchip,mcp4725";
+                reg = <0x60>;
+                vref-millivolt = <3300>;
+        };
+
+        mcp4726@60 {
+                compatible = "microchip,mcp4726";
+                reg = <0x60>;
+                vref-mode = <2>;
+                vref-millivolt = <2500>;
+        };
-- 
2.1.4

