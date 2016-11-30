Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH v6 4/9] dt-bindings: iio: iio-mux: document iio-mux bindings
Date: Wed, 30 Nov 2016 09:16:58 +0100
Message-ID: <1480493823-21462-5-git-send-email-peda@axentia.se>
In-Reply-To: <1480493823-21462-1-git-send-email-peda@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/multiplexer/iio-mux.txt           | 40 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
new file mode 100644
index 000000000000..8080cf790d82
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
@@ -0,0 +1,40 @@
+IIO multiplexer bindings
+
+If a multiplexer is used to select which hardware signal is fed to
+e.g. an ADC channel, these bindings describe that situation.
+
+Required properties:
+- compatible : "iio-mux"
+- io-channels : Channel node of the parent channel that has multiplexed
+		input.
+- io-channel-names : Should be "parent".
+- #address-cells = <1>;
+- #size-cells = <0>;
+- mux-controls : Mux controller node to use for operating the mux
+- channels : List of strings, labeling the mux controller states.
+
+The multiplexer state as described in ../misc/mux-controller.txt
+
+For each non-empty string in the channels property, an iio channel will
+be created. The number of this iio channel is the same as the index into
+the list of strings in the channels property, and also matches the mux
+controller state.
+
+Example:
+	mux: mux-controller {
+		compatible = "mux-gpio";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	adc-mux {
+		compatible = "iio-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux>;
+
+		channels = "sync", "in", system-regulator";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index dc7498682752..77045ae15865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6234,6 +6234,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
 F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 F:	drivers/iio/adc/envelope-detector.c
 
+IIO MULTIPLEXER
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
+
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
 R:	Hartmut Knaack <knaack.h@gmx.de>
-- 
2.1.4
