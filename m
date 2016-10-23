Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 5/8] dt-bindings: iio: document dpot-dac bindings
Date: Mon, 24 Oct 2016 00:39:38 +0200
Message-ID: <1477262381-7800-6-git-send-email-peda@axentia.se>
In-Reply-To: <1477262381-7800-1-git-send-email-peda@axentia.se>
References: <1477262381-7800-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/dac/dpot-dac.txt       | 41 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
new file mode 100644
index 000000000000..fdf47a01bfef
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
@@ -0,0 +1,41 @@
+Bindings for DAC emulation using a digital potentiometer
+
+It is assumed that the dpot is used as a voltage divider between the
+current dpot wiper setting and the maximum resistance of the dpot. The
+divided voltage is provided by a vref regulator.
+
+                  .------.
+   .-----------.  |      |
+   | vref      |--'    .---.
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
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 7c65585e1230..6218010128dc 100644
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
