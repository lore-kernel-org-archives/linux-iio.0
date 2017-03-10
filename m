Return-Path: <SRS0=hI5c=2T=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan
 Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Colin
 Ian King <colin.king@canonical.com>, Paul Gortmaker
	<paul.gortmaker@windriver.com>
Subject: [PATCH v10 09/11] dt-bindings: mux-adg792a: document devicetree bindings for ADG792A/G mux
Date: Fri, 10 Mar 2017 12:10:03 +0100
Message-ID: <1489144205-17427-10-git-send-email-peda@axentia.se>
In-Reply-To: <1489144205-17427-1-git-send-email-peda@axentia.se>
References: <1489144205-17427-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Analog Devices ADG792A/G is a triple 4:1 mux.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/mux/adi,adg792a.txt        | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/adi,adg792a.txt

diff --git a/Documentation/devicetree/bindings/mux/adi,adg792a.txt b/Documentation/devicetree/bindings/mux/adi,adg792a.txt
new file mode 100644
index 000000000000..96b787a69f50
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/adi,adg792a.txt
@@ -0,0 +1,75 @@
+Bindings for Analog Devices ADG792A/G Triple 4:1 Multiplexers
+
+Required properties:
+- compatible : "adi,adg792a" or "adi,adg792g"
+- #mux-control-cells : <0> if parallel (the three muxes are bound together
+  with a single mux controller controlling all three muxes), or <1> if
+  not (one mux controller for each mux).
+* Standard mux-controller bindings as described in mux-controller.txt
+
+Optional properties for ADG792G:
+- gpio-controller : if present, #gpio-cells below is required.
+- #gpio-cells : should be <2>
+			  - First cell is the GPO line number, i.e. 0 or 1
+			  - Second cell is used to specify active high (0)
+			    or active low (1)
+
+Optional properties:
+- idle-state : if present, array of states that the mux controllers will have
+  when idle. The special state MUX_IDLE_AS_IS is the default and
+  MUX_IDLE_DISCONNECT is also supported.
+
+States 0 through 3 correspond to signals A through D in the datasheet.
+
+Example:
+
+	/*
+	 * Three independent mux controllers (of which one is used).
+	 * Mux 0 is disconnected when idle, mux 1 idles in the previously
+	 * selected state and mux 2 idles with signal B.
+	 */
+	&i2c0 {
+		mux: mux-controller@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <1>;
+
+			idle-state = <MUX_IDLE_DISCONNECT MUX_IDLE_AS_IS 1>;
+		};
+	};
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux 2>;
+
+		channels = "sync-1", "", "out";
+	};
+
+
+	/*
+	 * Three parallel muxes with one mux controller, useful e.g. if
+	 * the adc is differential, thus needing two signals to be muxed
+	 * simultaneously for correct operation.
+	 */
+	&i2c0 {
+		pmux: mux-controller@50 {
+			compatible = "adi,adg792a";
+			reg = <0x50>;
+			#mux-control-cells = <0>;
+
+			idle-state = <1>;
+		};
+	};
+
+	diff-adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&pmux>;
+
+		channels = "sync-1", "", "out";
+	};
-- 
2.1.4
