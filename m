Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0134.outbound.protection.outlook.com ([104.47.2.134]:41408
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756109AbcK3Ju0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Nov 2016 04:50:26 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v6 6/9] dt-bindings: i2c: i2c-mux-simple: document i2c-mux-simple bindings
Date: Wed, 30 Nov 2016 09:17:00 +0100
Message-ID: <1480493823-21462-7-git-send-email-peda@axentia.se>
In-Reply-To: <1480493823-21462-1-git-send-email-peda@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/i2c/i2c-mux-simple.txt     | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
new file mode 100644
index 000000000000..d32ebc9c5639
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
@@ -0,0 +1,81 @@
+Simple I2C Bus Mux
+
+This binding describes an I2C bus multiplexer that uses a mux controller
+from the mux subsystem to route the I2C signals.
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
+- mux-controls: The phandle of the mux controller to use for operating the
+  mux.
+* Standard I2C mux properties. See i2c-mux.txt in this directory.
+* I2C child bus nodes. See i2c-mux.txt in this directory. The sub-bus number
+  is also the mux-controller state described in ../misc/mux-controller.txt
+
+For each i2c child node, an I2C child bus will be created. They will
+be numbered based on their order in the device tree.
+
+Whenever an access is made to a device on a child bus, the value set
+in the relevant node's reg property will be set as the state in the
+mux controller.
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
+	i2c-mux {
+		compatible = "i2c-mux-simple,mux-locked";
+		i2c-parent = <&i2c1>;
+
+		mux-controls = <&mux>;
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

