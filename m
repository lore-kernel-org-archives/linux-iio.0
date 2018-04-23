Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0116.outbound.protection.outlook.com ([104.47.0.116]:56392
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932157AbeDWVIm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Apr 2018 17:08:42 -0400
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
Subject: [PATCH v4 3/4] dt-bindings: iio: afe: add binding for current-sense-amplifier
Date: Mon, 23 Apr 2018 23:08:08 +0200
Message-Id: <20180423210809.29586-4-peda@axentia.se>
In-Reply-To: <20180423210809.29586-1-peda@axentia.se>
References: <20180423210809.29586-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Similar to current sense shunts, but an amplifier enables the use
of a smaller sense resistance.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/current-sense-amplifier.txt   | 26 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
new file mode 100644
index 000000000000..0ddbaebba8ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
@@ -0,0 +1,26 @@
+Current Sense Amplifier
+=======================
+
+When an io-channel measures the output voltage from a current sense
+amplifier, the interesting mesaurement is almost always the current
+through the sense resistor, not the voltage output. This binding
+describes such a current sense circuit.
+
+Required properties:
+- compatible : "current-sense-amplifier"
+- io-channels : Channel node of a voltage io-channel.
+- sense-resistor-micro-ohms : The sense resistance in microohms.
+
+Optional properties:
+- sense-gain-mult: Amplifier gain multiplier. The default is <1>.
+- sense-gain-div: Amplifier gain divider. The default is <1>.
+
+Example:
+
+sysi {
+	compatible = "current-sense-amplifier";
+	io-channels = <&tiadc 0>;
+
+	sense-resistor-micro-ohms = <20000>;
+	sense-gain-mul = <50>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4d534c9321de..1b23e9ebff9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6893,6 +6893,7 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 
-- 
2.11.0

