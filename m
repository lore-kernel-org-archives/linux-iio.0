Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:25632
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753261AbcKUNeA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Nov 2016 08:34:00 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 4/7] dt-bindings: iio: iio-mux: document iio-mux bindings
Date: Mon, 21 Nov 2016 14:17:12 +0100
Message-ID: <1479734235-18837-5-git-send-email-peda@axentia.se>
In-Reply-To: <1479734235-18837-1-git-send-email-peda@axentia.se>
References: <1479734235-18837-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/multiplexer/iio-mux.txt           | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
new file mode 100644
index 000000000000..2807333ccc86
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
@@ -0,0 +1,47 @@
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
+
+Required properties for iio-mux child nodes:
+- reg : The multiplexer state as described in ../misc/mux-controller.txt
+
+For each iio-mux child, an iio channel will be created whose number will
+match the mux controller state.
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
+			sync@0 {
+				reg = <0>;
+			};
+
+			in@1 {
+				reg = <1>;
+			};
+
+			system-regulator@2 {
+				reg = <2>;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 37974aeee750..3fc0dbbc04ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6124,6 +6124,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
 
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

