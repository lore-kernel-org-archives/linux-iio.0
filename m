Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0111.outbound.protection.outlook.com ([104.47.0.111]:45124
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932222AbeDWVIf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Apr 2018 17:08:35 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: iio: afe: add binding for voltage-divider
Date: Mon, 23 Apr 2018 23:08:07 +0200
Message-Id: <20180423210809.29586-3-peda@axentia.se>
In-Reply-To: <20180423210809.29586-1-peda@axentia.se>
References: <20180423210809.29586-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

An ADC is often used to measure other quantities indirectly. This
binding describe one cases, a "big" voltage measured with the help
of a voltage divider.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/voltage-divider.txt           | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
new file mode 100644
index 000000000000..afb52ce77c27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
@@ -0,0 +1,53 @@
+Voltage divider
+===============
+
+When an io-channel measures the midpoint of a voltage divider, the
+interesting voltage is often the voltage over the full resistance
+of the divider. This binding describes the voltage divider in such
+a curcuit.
+
+    Vin ----.
+            |
+         .-----.
+         |  R  |
+         '-----'
+            |
+            +---- Vout
+            |
+         .-----.
+         | Rout|
+         '-----'
+            |
+           GND
+
+Required properties:
+- compatible : "voltage-divider"
+- io-channels : Channel node of a voltage io-channel measuring Vout.
+- output-ohms : Resistance Rout over which the output voltage is measured.
+	        See full-ohms.
+- full-ohms : Resistance R + Rout for the full divider. The io-channel
+	      is scaled by the Rout / (R + Rout) quotient.
+
+Example:
+The system voltage is circa 12V, but divided down with a 22/222
+voltage divider (R = 200 Ohms, Rout = 22 Ohms) and fed to an ADC.
+
+sysv {
+	compatible = "voltage-divider";
+	io-channels = <&maxadc 1>;
+
+	/* Scale the system voltage by 22/222 to fit the ADC range. */
+	output-ohms = <22>;
+	full-ohms = <222>; /* 200 + 22 */
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
index 0f7bec878919..4d534c9321de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6894,6 +6894,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
-- 
2.11.0

