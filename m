Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0104.outbound.protection.outlook.com ([104.47.2.104]:39232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934156AbcKQGYZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Nov 2016 01:24:25 -0500
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
Subject: [RFC PATCH 4/7] dt-bindings: iio: iio-mux: document iio-mux bindings
Date: Thu, 17 Nov 2016 00:48:28 +0100
Message-ID: <1479340111-1259-5-git-send-email-peda@axentia.se>
In-Reply-To: <1479340111-1259-1-git-send-email-peda@axentia.se>
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 .../bindings/iio/multiplexer/iio-mux.txt           | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
new file mode 100644
index 000000000000..2f5c7fc35a42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
@@ -0,0 +1,59 @@
+IIO multiplexer bindings
+
+If a multiplexer is used to select when hardware signal is fed to
+e.g. an ADC channel, these bindings describe that situation.
+
+Required properties:
+- compatible : "iio-mux"
+- io-channels : Channel node of the parent channel that has multiplexed
+		input.
+- io-channel-names : Should be "parent".
+- control-muxes : Node of the multiplexer that controls the input signal.
+- control-mux-names : Should be "mux".
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Required properties for iio-mux child nodes:
+- reg : The multiplexer number.
+
+Optional properties for iio-mux child nodes:
+- iio-ext-info : Array of string pairs, the first item in each pair is the
+		 iio ext_info attribute name, and the second item in each
+		 pair is the iio ext_info value for that attribute. The
+		 mux will write these ext_info values to the corresponding
+		 ext_info attributes on every multiplexer switch.
+
+Example:
+	control_adc_mux: control-adc-mux {
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
+		control-muxes = <&control_adc_mux>;
+		control-mux-names = "mux";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sync@0 {
+			reg = <0>;
+			iio-ext-info = "invert", "1";
+		};
+
+		in@1 {
+			reg = <1>;
+			iio-ext-info = "invert", "1";
+		};
+
+		system-regulator@2 {
+			reg = <2>;
+			iio-ext-info = "invert", "0";
+		};
+	};
-- 
2.1.4

