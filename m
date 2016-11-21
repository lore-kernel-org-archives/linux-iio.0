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
Subject: [PATCH v3 1/7] dt-bindings: document devicetree bindings for mux-controllers and mux-gpio
Date: Mon, 21 Nov 2016 14:17:09 +0100
Message-ID: <1479734235-18837-2-git-send-email-peda@axentia.se>
In-Reply-To: <1479734235-18837-1-git-send-email-peda@axentia.se>
References: <1479734235-18837-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/misc/mux-controller.txt    | 76 +++++++++++++++++++++
 .../devicetree/bindings/misc/mux-gpio.txt          | 78 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 3 files changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mux-controller.txt
 create mode 100644 Documentation/devicetree/bindings/misc/mux-gpio.txt

diff --git a/Documentation/devicetree/bindings/misc/mux-controller.txt b/Documentation/devicetree/bindings/misc/mux-controller.txt
new file mode 100644
index 000000000000..6946b5428546
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mux-controller.txt
@@ -0,0 +1,76 @@
+Common multiplexer controller bindings
+
+A mux controller will have one, or several, child devices that uses (or
+consumes) a mux controller. A mux controller can possibly control several
+parallel multiplexers. The node for a mux controller will have one child
+node for each multiplexer controller consumer.
+
+A mux controller provides a number of states to its consumers, and the
+state space is a simple zero-based enumeration. I.e. 0-1 for a 2-way
+multiplexer, 0-7 for an 8-way multiplexer, etc.
+
+Example:
+
+	/*
+	 * Two consumers (one for an ADC line and one for an i2c bus) of
+	 * parallel 4-way multiplexers controlled by the same two GPIO-lines.
+	 */
+	mux {
+		compatible = "mux-gpio";
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+
+		adc {
+			compatible = "iio-mux";
+			io-channels = <&adc 0>;
+			io-channel-names = "parent";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sync-1@0 {
+				reg = <0>;
+			};
+
+			in@1 {
+				reg = <1>;
+			};
+
+			out@2 {
+				reg = <2>;
+			};
+
+			sync-2@3 {
+				reg = <3>;
+			};
+		};
+
+		i2c-mux {
+			compatible = "i2c-mux-simple,mux-locked";
+			i2c-parent = <&i2c1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ssd1307: oled@3c {
+					/* ... */
+				};
+			};
+
+			i2c@3 {
+				reg = <3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pca9555: pca9555@20 {
+					/* ... */
+				};
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/misc/mux-gpio.txt b/Documentation/devicetree/bindings/misc/mux-gpio.txt
new file mode 100644
index 000000000000..23b87913f4b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mux-gpio.txt
@@ -0,0 +1,78 @@
+GPIO-based multiplexer controller bindings
+
+Define what GPIO pins are used to control a multiplexer. Or several
+multiplexers, if the same pins control more than one multiplexer.
+
+Required properties:
+- compatible : "mux-gpio"
+- mux-gpios : list of gpios used to control the multiplexer, least
+	      significant bit first.
+* Standard mux-controller bindings as decribed in mux-controller.txt
+
+Optional properties:
+- idle-state : if present, the state the mux will have when idle.
+
+The multiplexer state is defined as the number represented by the
+multiplexer GPIO pins, where the first pin is the least significant
+bit. And active pin is a binary 1, an inactive pin is a binary 0.
+
+Example:
+	mux {
+		compatible = "mux-gpio";
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+
+		adc {
+			compatible = "iio-mux";
+			io-channels = <&adc 0>;
+			io-channel-names = "parent";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sync-1@0 {
+				reg = <0>;
+			};
+
+			in@1 {
+				reg = <1>;
+			};
+
+			out@2 {
+				reg = <2>;
+			};
+
+			sync-2@3 {
+				reg = <3>;
+			};
+		};
+
+		i2c-mux {
+			compatible = "i2c-mux-simple,mux-locked";
+			i2c-parent = <&i2c1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ssd1307: oled@3c {
+					/* ... */
+				};
+			};
+
+			i2c@3 {
+				reg = <3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pca9555: pca9555@20 {
+					/* ... */
+				};
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index ad9b965e5e44..7d797f087822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8244,6 +8244,11 @@ S:	Orphan
 F:	drivers/mmc/host/mmc_spi.c
 F:	include/linux/spi/mmc_spi.h
 
+MULTIPLEXER SUBSYSTEM
+M:	Peter Rosin <peda@axentia.se>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/mux-*
+
 MULTISOUND SOUND DRIVER
 M:	Andrew Veliath <andrewtv@usa.net>
 S:	Maintained
-- 
2.1.4
