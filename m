Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr30106.outbound.protection.outlook.com ([40.107.3.106]:58085
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933713AbcK3Jus (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Nov 2016 04:50:48 -0500
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
Subject: [PATCH v6 8/9] dt-bindings: mux-adg792a: document devicetree bindings for ADG792A/G mux
Date: Wed, 30 Nov 2016 09:17:02 +0100
Message-ID: <1480493823-21462-9-git-send-email-peda@axentia.se>
In-Reply-To: <1480493823-21462-1-git-send-email-peda@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Analog Devices ADG792A/G is a triple 4:1 mux.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/misc/mux-adg792a.txt       | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mux-adg792a.txt

diff --git a/Documentation/devicetree/bindings/misc/mux-adg792a.txt b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
new file mode 100644
index 000000000000..4677f9ab1c55
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mux-adg792a.txt
@@ -0,0 +1,64 @@
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
+		channels = "sync-1", "", "out";
+	};
-- 
2.1.4

