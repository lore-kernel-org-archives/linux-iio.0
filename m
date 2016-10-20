Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0101.outbound.protection.outlook.com ([104.47.2.101]:28544
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755474AbcJTVA7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Oct 2016 17:00:59 -0400
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: iio: document dpot-dac bindings
Date: Thu, 20 Oct 2016 11:25:59 +0200
Message-ID: <1476955562-13673-2-git-send-email-peda@axentia.se>
In-Reply-To: <1476955562-13673-1-git-send-email-peda@axentia.se>
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/dac/dpot-dac.txt       | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
new file mode 100644
index 000000000000..a381188676c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
@@ -0,0 +1,43 @@
+Bindings for DAC emulation using a digital potentiometer
+
+It is assumed the that the dpot is used as a voltage divider between the
+current dpot wiper setting and the maximum resistance of the dpot. The
+divided voltage is provided by a vref regulator.
+
+                  .------.
+   .-----------.  |      |
+   | Vref      |--'    .---.
+   | regulator |--.    |   |
+   '-----------'  |    | d |
+                  |    | p |
+                  |    | o |  wiper
+                  |    | t |<---------+
+                  |    |   |
+                  |    '---'       dac output voltage
+                  |      |
+                  '------+------------+
+
+Required properties:
+- compatible: Should be "dpot-dac"
+- vref-supply: The regulator supplying the voltage divider.
+- io-channels: Channel node of the dpot to be used for the voltage division.
+- io-channel-names: Should be "dpot".
+- dpot-dac,max-ohms: The maximum resistance of the dpot.
+
+Example:
+
+	&i2c {
+		dpot: mcp4651-503@28 {
+			compatible = "microchip,mcp4651-503";
+			reg = <0x28>;
+			#io-channel-cells = <1>;
+		};
+	};
+
+	dac {
+		compatible = "dpot-dac";
+		vref-supply = <&reg_3v3>;
+		io-channels = <&dpot 0>;
+		io-channel-names = "dpot";
+		dpot-dac,max-ohms = <50000>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7e0064..c68b72088945 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6111,6 +6111,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
 
+IIO DIGITAL POTENTIOMETER DAC
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
+
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
 R:	Hartmut Knaack <knaack.h@gmx.de>
-- 
2.1.4

