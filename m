Return-Path: <SRS0=xDUO=G7=axentia.se=peda@kernel.org>
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
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: afe: add current-sense-shunt and voltage-divider
Date: Tue, 10 Apr 2018 17:28:01 +0200
Message-Id: <20180410152802.30958-2-peda@axentia.se>
In-Reply-To: <20180410152802.30958-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

An ADC is often used to measure other quantities indirectly. These
bindings describe two cases, a current through a shunt resistor, and
a "big" voltage measured with the help of a voltage divider.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/current-sense-shunt.txt       | 41 ++++++++++++++++++++
 .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
new file mode 100644
index 000000000000..4d842aa85040
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
@@ -0,0 +1,41 @@
+Current Sense Shunt
+===================
+
+When an io-channel measures the voltage over a current sense shunt,
+the interesting mesaurement is almost always the current through the
+shunt, not the voltage over it. This binding describes such a current
+sense circuit.
+
+Required properties:
+- compatible : "current-sense-shunt"
+- io-channels : Channel node of a voltage io-channel.
+- shunt-resistor-micro-ohms : The shunt resistance in microohms.
+
+Example:
+The system current is measured by measuring the voltage over a
+3.3 ohms shunt resistor.
+
+sysi {
+	compatible = "current-sense-shunt";
+	io-channels = <&tiadc 0>;
+
+	/* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
+	shunt-resistor-micro-ohms = <3300000>;
+};
+
+&i2c {
+	tiadc: adc@48 {
+		compatible = "ti,ads1015";
+	      	reg = <0x48>;
+		#io-channel-cells = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 { /* IN0,IN1 differential */
+			reg = <0>;
+			ti,gain = <1>;
+			ti,datarate = <4>;
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
new file mode 100644
index 000000000000..fd4a215d9e6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
@@ -0,0 +1,45 @@
+Voltage divider
+===============
+
+When an io-channel measures the midpoint of a voltage divider, the
+interesting voltage is often the voltage over the full resistance
+of the divider. This binding describes the voltage divider in such
+a curcuit.
+
+Required properties:
+- compatible : "voltage-divider"
+- io-channels : Channel node of a voltage io-channel.
+
+Optional properties:
+- numerator : The io-channel scale is multiplied by this value (default 1).
+- denominator : The io-channel scale is divided by this value (default 1).
+
+Example:
+The system voltage is circa 12V, but divided down with a 22/200
+voltage divider to adjust it to the ADC range.
+
+SYSV        ADC       GND
+  +          +         +
+  |  .-----. | .----.  |
+  '--| 200 |-+-| 22 |--'
+     '-----'   '----'
+
+sysv {
+	compatible = "voltage-divider";
+	io-channels = <&maxadc 1>;
+
+	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
+	numerator = <222>; /* 200 + 22 */
+	denominator = <22>;
+};
+
+&spi {
+	maxadc: adc@0 {
+		compatible = "maxim,max1027";
+	      	reg = <0>;
+		#io-channel-cells = <1>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+		spi-max-frequency = <1000000>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e950b8b4a41..237fcdfdddc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6887,6 +6887,13 @@ F:	drivers/staging/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+IIO UNIT CONVERTER
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
-- 
2.11.0
