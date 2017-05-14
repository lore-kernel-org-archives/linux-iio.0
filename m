Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:48357 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759615AbdENT5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 15:57:50 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Subject: [PATCH v15 08/13] dt-bindings: i2c: i2c-mux: document general purpose i2c-mux bindings
Date: Sun, 14 May 2017 21:51:11 +0200
Message-Id: <1494791476-14599-9-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Describe how a general purpose multiplexer controller is used to mux an
i2c bus.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/i2c/i2c-mux-gpmux.txt      | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt
new file mode 100644
index 000000000000..2907dab56298
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt
@@ -0,0 +1,99 @@
+General Purpose I2C Bus Mux
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
+- compatible: i2c-mux
+- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
+  port is connected to.
+- mux-controls: The phandle of the mux controller to use for operating the
+  mux.
+* Standard I2C mux properties. See i2c-mux.txt in this directory.
+* I2C child bus nodes. See i2c-mux.txt in this directory. The sub-bus number
+  is also the mux-controller state described in ../mux/mux-controller.txt
+
+Optional properties:
+- mux-locked: If present, explicitly allow unrelated I2C transactions on the
+  parent I2C adapter at these times:
+   + during setup of the multiplexer
+   + between setup of the multiplexer and the child bus I2C transaction
+   + between the child bus I2C transaction and releasing of the multiplexer
+   + during releasing of the multiplexer
+  However, I2C transactions to devices behind all I2C multiplexers connected
+  to the same parent adapter that this multiplexer is connected to are blocked
+  for the full duration of the complete multiplexed I2C transaction (i.e.
+  including the times covered by the above list).
+  If mux-locked is not present, the multiplexer is assumed to be parent-locked.
+  This means that no unrelated I2C transactions are allowed on the parent I2C
+  adapter for the complete multiplexed I2C transaction.
+  The properties of mux-locked and parent-locked multiplexers are discussed
+  in more detail in Documentation/i2c/i2c-topology.
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
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	i2c-mux {
+		compatible = "i2c-mux";
+		mux-locked;
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

