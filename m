Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [RFC PATCH 1/7] dt-bindings: document devicetree bindings for mux-gpio
Date: Thu, 17 Nov 2016 00:48:25 +0100
Message-ID: <1479340111-1259-2-git-send-email-peda@axentia.se>
In-Reply-To: <1479340111-1259-1-git-send-email-peda@axentia.se>
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

---
 .../devicetree/bindings/misc/mux-gpio.txt          | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mux-gpio.txt

diff --git a/Documentation/devicetree/bindings/misc/mux-gpio.txt b/Documentation/devicetree/bindings/misc/mux-gpio.txt
new file mode 100644
index 000000000000..8c1745ecd4ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mux-gpio.txt
@@ -0,0 +1,76 @@
+GPIO-based multiplexer controller bindings
+
+Define what GPIO pins are used to control a multiplexer. Or several
+multiplexers, if the same pins control more than one multiplexer.
+
+Required properties:
+- compatible : "mux-gpio"
+- mux-gpios : list of gpios used to control the multiplexer, least
+	      significant bit first.
+
+Example:
+	control_mux: control-adc-mux {
+		compatible = "mux-gpio";
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
+		control-muxes = <&control_mux>;
+		control-mux-names = "mux";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sync-1@0 {
+			reg = <0>;
+		};
+
+		in@1 {
+			reg = <1>;
+		};
+
+		out@2 {
+			reg = <2>;
+		};
+
+		sync-2@3 {
+			reg = <3>;
+		};
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux-simple,mux-locked";
+		i2c-parent = <&i2c1>;
+
+		control-muxes = <&control_mux>;
+		control-mux-names = "mux";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ssd1307: oled@3c {
+				/* ... */
+			};
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9555: pca9555@20 {
+				/* ... */
+			};
+		};
+	};
-- 
2.1.4
