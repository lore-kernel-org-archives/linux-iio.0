Return-Path: <SRS0=OunF=HB=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: afe: add binding for adi,lt6106
Date: Wed, 11 Apr 2018 16:15:54 +0200
Message-Id: <20180411141555.15044-2-peda@axentia.se>
In-Reply-To: <20180411141555.15044-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This is a current sense amplifier from Analog Devices.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt b/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
new file mode 100644
index 000000000000..98b6d93596f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
@@ -0,0 +1,50 @@
+LT6106 36V High Side Current Sence Amplifier
+============================================
+
+This binding assumes the typical application of the current sense amplifier
+as described in the LT6106 datasheet.
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/6106fb.pdf
+
+                                             .------.
+    Vin --------------------+--------------+-|Rsense|-+-----.
+                            |              | '------' |     |
+                            |              |          |   .---.
+                 .--------------------.  .---.        |   | L |
+                 |          V+        |  |Rin|        |   | O |
+                 |                    |  '---'        |   | A |
+                 |                    |    |          |   | D |
+                 |                -IN |----'          |   '---'
+    Vout ---+----| OUT   LT6106       |               |     |
+            |    |                +IN |---------------'    GND
+         .----.  |                    |
+         |Rout|  |                    |
+         '----'  |          V-        |
+            |    '--------------------'
+            |               |
+           GND             GND
+
+The voltage Vsense over Rsense is measured by looking at Vout. They
+are related as Vout = Vsense * Rout / Rin. The current Isense through
+Rsense is (almost) the same as that through the LOAD. Hence, the
+interesting LOAD current can be calculated as
+
+                 Vout * Rin / (Rout * Rsense)
+
+Required properties:
+- compatible : "adi,lt6106"
+- io-channels : Channel node of an io-channel measuring Vout.
+- sense-resistor-micro-ohms : The Rsense resistance in microohms.
+- input-resistor-ohms : The Rin resistance in ohms.
+- output-resistor-ohms : The Rout resistance in ohms.
+
+Example:
+
+sysi {
+	compatible = "adi,lt6106";
+	io-channels = <&tiadc 0>;
+
+	sense-resistor-micro-ohms = <20000>;
+	input-resistor-ohms = <200>;
+	output-resistor-ohms = <10000>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 21368749f3b0..76d1e03f350a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6893,6 +6893,7 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 F:	drivers/iio/afe/iio-unit-converter.c
-- 
2.11.0
