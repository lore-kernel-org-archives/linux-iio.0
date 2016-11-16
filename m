Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0130.outbound.protection.outlook.com ([104.47.2.130]:15088
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751059AbcKQGXP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Nov 2016 01:23:15 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [RFC PATCH 6/7] dt-bindings: i2c: i2c-mux-simple: document i2c-mux-simple bindings
Date: Thu, 17 Nov 2016 00:48:30 +0100
Message-ID: <1479340111-1259-7-git-send-email-peda@axentia.se>
In-Reply-To: <1479340111-1259-1-git-send-email-peda@axentia.se>
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 .../devicetree/bindings/i2c/i2c-mux-simple.txt     | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
new file mode 100644
index 000000000000..fec1ab39ad64
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
@@ -0,0 +1,91 @@
+Simple I2C Bus Mux
+
+This binding describes an I2C bus multiplexer that uses GPIOs to
+route the I2C signals.
+
+                                  .-----.  .-----.
+                                  | dev |  | dev |
+    .------------.                '-----'  '-----'
+    | SoC        |                   |        |
+    |            |          .--------+--------'
+    |   .------. |  .------+    child bus A, on MUX value set to 0
+    |   | I2C  |-|--| Mux  |
+    |   '------' |  '--+---+    child bus B, on MUX value set to 1
+    |   .------. |     |    '----------+--------+--------.
+    |   | MUX- | |     |               |        |        |
+    |   | Ctrl |-|-----+            .-----.  .-----.  .-----.
+    |   '------' |                  | dev |  | dev |  | dev |
+    '------------'                  '-----'  '-----'  '-----'
+
+Required properties:
+- compatible: i2c-mux-simple,mux-locked or i2c-mux-simple,parent-locked
+- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
+  port is connected to.
+- control-muxes : Node of the multiplexer that controls "Mux".
+- control-mux-names : Should be "mux".
+* Standard I2C mux properties. See i2c-mux.txt in this directory.
+* I2C child bus nodes. See i2c-mux.txt in this directory.
+
+Optional properties:
+- idle-state: value to set the muxer to when idle. When no value is
+  given, it defaults to the last value used.
+
+For each i2c child node, an I2C child bus will be created. They will
+be numbered based on their order in the device tree.
+
+Whenever an access is made to a device on a child bus, the value set
+in the relevant node's reg property will be fed to the mux controller.
+
+If an idle state is defined, using the idle-state (optional) property,
+whenever an access is not being made to a device on a child bus, the
+mux controller will be set according to the idle value.
+
+If an idle state is not defined, the most recently used value will be
+left programmed into hardware whenever no access is being made to a
+device on a child bus.
+
+Example:
+	control_i2c_mux: control-i2c-mux {
+		compatible = "mux-gpio";
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux-simple,mux-locked";
+		i2c-parent = <&i2c1>;
+
+		control-muxes = <&control_i2c_mux>;
+		control-mux-names = "mux";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ssd1307: oled@3c {
+				compatible = "solomon,ssd1307fb-i2c";
+				reg = <0x3c>;
+				pwms = <&pwm 4 3000>;
+				reset-gpios = <&gpio2 7 1>;
+				reset-active-low;
+			};
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9555: pca9555@20 {
+				compatible = "nxp,pca9555";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x20>;
+			};
+		};
+	};
-- 
2.1.4

