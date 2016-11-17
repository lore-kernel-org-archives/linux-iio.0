Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0105.outbound.protection.outlook.com ([104.47.2.105]:6976
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752256AbcKRBZS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Nov 2016 20:25:18 -0500
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
Subject: [RFC PATCH v2 1/7] dt-bindings: document devicetree bindings for mux-gpio
Date: Thu, 17 Nov 2016 22:48:03 +0100
Message-ID: <1479419289-17553-2-git-send-email-peda@axentia.se>
In-Reply-To: <1479419289-17553-1-git-send-email-peda@axentia.se>
References: <1479419289-17553-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 .../devicetree/bindings/misc/mux-gpio.txt          | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mux-gpio.txt

diff --git a/Documentation/devicetree/bindings/misc/mux-gpio.txt b/Documentation/devicetree/bindings/misc/mux-gpio.txt
new file mode 100644
index 000000000000..73699a37824f
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mux-gpio.txt
@@ -0,0 +1,79 @@
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
+Optional properties:
+- idle-state : if present, the state the mux will have when idle.
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

