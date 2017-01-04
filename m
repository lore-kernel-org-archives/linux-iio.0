Return-Path: <SRS0=tr1Y=YS=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Wolfram Sang <wsa@the-dreams.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 04/12] dt-bindings: simplified bindings for single-user gpio mux
Date: Wed,  4 Jan 2017 13:16:19 +0100
Message-Id: <1483532187-28494-5-git-send-email-peda@axentia.se>
In-Reply-To: <1483532187-28494-1-git-send-email-peda@axentia.se>
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/mux/mux-controller.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mux/mux-controller.txt b/Documentation/devicetree/bindings/mux/mux-controller.txt
index 42b2177e5ae1..4e89df8b2392 100644
--- a/Documentation/devicetree/bindings/mux/mux-controller.txt
+++ b/Documentation/devicetree/bindings/mux/mux-controller.txt
@@ -125,3 +125,29 @@ An example mux controller might look like this:
 		reg = <0x50>;
 		#mux-control-cells = <1>;
 	};
+
+
+Combinded controller and consumer of a GPIO mux
+-----------------------------------------------
+
+For the common case of a single consumer of a GPIO controlled mux, there is
+a simplified binding which will instantiate an implicit mux controller. Just
+specify a mux-gpios property with the same interpretation as in mux-gpio.txt.
+Note that other properties described in mux-gpio.txt are not available in
+this simplified form and that the mux controller is unnamed. If you need
+more than one mux controller, a shared mux controller or if you need a
+specific idle-state, use the more flexible binding with the mux controller
+in its own node.
+
+Example:
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+
+		channels = "sync-1", "in", "out", "sync-2";
+	};
-- 
2.1.4
