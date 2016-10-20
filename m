Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 3/4] dt-bindings: iio: document envelope-detector bindings
Date: Thu, 20 Oct 2016 11:26:01 +0200
Message-ID: <1476955562-13673-4-git-send-email-peda@axentia.se>
In-Reply-To: <1476955562-13673-1-git-send-email-peda@axentia.se>
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/adc/envelope-detector.txt         | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
new file mode 100644
index 000000000000..0e26299516fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
@@ -0,0 +1,65 @@
+Bindings for ADC envelope detector using a DAC and a comparator
+
+The DAC is used to find the peak level of an alternating voltage input
+signal by a binary search using the output of a comparator wired to
+an interrupt pin. Like so:
+                          _
+                         | \
+    input +------>-------|+ \
+                         |   \
+           .-------.     |    }---.
+           |       |     |   /    |
+           |    dac|-->--|- /     |
+           |       |     |_/      |
+           |       |              |
+           |       |              |
+           |    irq|------<-------'
+           |       |
+           '-------'
+
+Required properties:
+- compatible: Should be "envelope-detector"
+- io-channels: Channel node of the dac to be used for comparator input.
+- io-channel-names: Should be "dac".
+- interrupt specification for one client interrupt,
+  see ../../interrupt-controller/interrupts.txt for details.
+- interrupt-names: Should be "comp".
+- envelope-detector,dac-max: The maximum raw input value for the dac.
+- envelope-detector,comp-interval-ms: How long to wait for the comparator
+  to trigger before moving on to another DAC level. This interval needs to
+  relate to the lowest possible frequency of the above input signal.
+
+Optional properties:
+- envelope-detector,inverted: If the input signal is centered around the
+  dac-max voltage (instead of zero), this property causes the detector to
+  search for the lowest DAC value that does not triggers the comparator
+  (instead of the highest). The result is also inverted so that a lower DAC
+  reading yields a higher voltage value.
+
+
+Example:
+
+	&spi {
+		dac: ad7303@4 {
+			compatible = "adi,ad7303";
+			reg = <4>;
+			spi-max-frequency = <10000000>;
+			Vdd-supply = <&vdd_supply>;
+			adi,use-external-reference;
+			REF-supply = <&vref_supply>;
+			#io-channel-cells = <1>;
+		};
+	};
+
+	envelope-detector {
+		compatible = "envelope-detector";
+		io-channels = <&dac 0>;
+		io-channel-names = "dac";
+
+		interrupt-parent = <&gpio>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "comp";
+
+		envelope-detector,dac-max = <255>;
+		envelope-detector,comp-interval-ms = <50>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c8aae24b96b..4b6f6ec1b703 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6118,6 +6118,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
 F:	drivers/iio/dac/dpot-dac.c
 
+IIO ENVELOPE DETECTOR
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
+
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
 R:	Hartmut Knaack <knaack.h@gmx.de>
-- 
2.1.4
