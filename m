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
Subject: [PATCH v5 8/9] dt-bindings: mux-adg792a: document devicetree bindings for ADG792A/G mux
Date: Tue, 29 Nov 2016 11:10:44 +0100
Message-ID: <1480414245-14034-9-git-send-email-peda@axentia.se>
In-Reply-To: <1480414245-14034-1-git-send-email-peda@axentia.se>
References: <1480414245-14034-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Analog Devices ADG792A/G is a triple 4:1 mux.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/misc/mux-adg792a.txt       | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mux-adg792a.txt

diff --git a/Documentation/devicetree/bindings/misc/mux-adg792a.txt b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
new file mode 100644
index 000000000000..8d5c9de09832
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
@@ -0,0 +1,82 @@
+Bindings for Analog Devices ADG792A/G Triple 4:1 Multiplexers
+
+Required properties:
+- compatible : "adi,adg792a" or "adi,adg792g"
+- #mux-control-cells : <0> if parallel, or <1> if not.
+* Standard mux-controller bindings as decribed in mux-controller.txt
+
+Optional properties:
+- adi,parallel : if present, the three muxes are bound together with a single
+  mux controller, controlling all three muxes in parallel.
+- adi,idle-state : if present, array of states the three mux controllers will
+  have when idle (or, if parallel, a single idle-state).
+
+Mux controller states 0 through 3 correspond to signals A through D in the
+datasheet. Mux controller states 4 and 5 are only available as possible idle
+states. State 4 represents that nothing is connected, and state 5 represents
+that the mux controller keeps the mux in its previously selected state during
+the idle period. State 5 is the default idle state.
+
+Example:
+
+	/* three independent mux controllers (of which one is used) */
+	&i2c0 {
+		mux: adg792a@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <1>;
+		};
+	};
+
+	adc-mux {
+		compatible = "iio-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux 1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sync-1@0 {
+			reg = <0>;
+		};
+
+		in@2 {
+			reg = <2>;
+		};
+	};
+
+
+	/*
+	 * Three parallel muxes with one mux controller, useful e.g. if
+	 * the adc is differential, thus needing two signals to be muxed
+	 * simultaneously for correct operation.
+	 */
+	&i2c0 {
+		pmux: adg792a@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <0>;
+			adi,parallel;
+		};
+	};
+
+	diff-adc-mux {
+		compatible = "iio-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&pmux>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sync-1@0 {
+			reg = <0>;
+		};
+
+		in@2 {
+			reg = <2>;
+		};
+	};
-- 
2.1.4
