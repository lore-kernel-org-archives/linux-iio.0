Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.babblebit.net ([37.139.8.208]:47078 "EHLO
        mail.babblebit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeKNTz1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Nov 2018 14:55:27 -0500
From: Chris Coffey <cmc@babblebit.net>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Peter Rosin <peda@axentia.se>, Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Chris Coffey <cmc@babblebit.net>
Subject: [PATCH v2 1/2] dt-bindings: iio: potentiometer: Add Microchip MCP41xxx/42xxx
Date: Wed, 14 Nov 2018 09:52:40 +0000
Message-Id: <20181114095241.27037-2-cmc@babblebit.net>
In-Reply-To: <20181114095241.27037-1-cmc@babblebit.net>
References: <20181114095241.27037-1-cmc@babblebit.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds device tree documentation for the Microchip
MCP41xxx/42xxx family of digital potentiometers.

Signed-off-by: Chris Coffey <cmc@babblebit.net>
---
 .../bindings/iio/potentiometer/mcp41010.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
new file mode 100644
index 0000000000..17565acace
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
@@ -0,0 +1,29 @@
+* Microchip MCP41010/41050/41100/42010/42050/42100 Digital Potentiometer
+  driver
+
+Datasheet publicly available at:
+http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in
+
+        Documentation/devicetree/bindings/spi/spi-bus.txt
+
+must be specified.
+
+Required properties:
+	- compatible:  	Must be one of the following, depending on the
+			model:
+			"microchip,mcp41010"
+			"microchip,mcp41050"
+			"microchip,mcp41100"
+			"microchip,mcp42010"
+			"microchip,mcp42050"
+			"microchip,mcp42100"
+
+Example:
+mcp41010: potentiometer@0 {
+	compatible = "mcp41010";
+	reg = <0>;
+	spi-max-frequency = <500000>;
+};
-- 
2.11.0
