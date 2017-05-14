Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:43485 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759609AbdENT5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 15:57:49 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
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
        kernel@pengutronix.de
Subject: [PATCH v15 12/13] dt-bindings: add mmio-based syscon mux controller DT bindings
Date: Sun, 14 May 2017 21:51:15 +0200
Message-Id: <1494791476-14599-13-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This adds device tree binding documentation for mmio-based syscon
multiplexers controlled by a bitfields in a syscon register range.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/mux/mmio-mux.txt | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/mmio-mux.txt

diff --git a/Documentation/devicetree/bindings/mux/mmio-mux.txt b/Documentation/devicetree/bindings/mux/mmio-mux.txt
new file mode 100644
index 000000000000..a9bfb4d8b6ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/mmio-mux.txt
@@ -0,0 +1,60 @@
+MMIO register bitfield-based multiplexer controller bindings
+
+Define register bitfields to be used to control multiplexers. The parent
+device tree node must be a syscon node to provide register access.
+
+Required properties:
+- compatible : "mmio-mux"
+- #mux-control-cells : <1>
+- mux-reg-masks : an array of register offset and pre-shifted bitfield mask
+                  pairs, each describing a single mux control.
+* Standard mux-controller bindings as decribed in mux-controller.txt
+
+Optional properties:
+- idle-states : if present, the state the muxes will have when idle. The
+		special state MUX_IDLE_AS_IS is the default.
+
+The multiplexer state of each multiplexer is defined as the value of the
+bitfield described by the corresponding register offset and bitfield mask pair
+in the mux-reg-masks array, accessed through the parent syscon.
+
+Example:
+
+	syscon {
+		compatible = "syscon";
+
+		mux: mux-controller {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+
+			mux-reg-masks = <0x3 0x30>, /* 0: reg 0x3, bits 5:4 */
+					<0x3 0x40>, /* 1: reg 0x3, bit 6 */
+			idle-states = <MUX_IDLE_AS_IS>, <0>;
+		};
+	};
+
+	video-mux {
+		compatible = "video-mux";
+		mux-controls = <&mux 0>;
+
+		ports {
+			/* inputs 0..3 */
+			port@0 {
+				reg = <0>;
+			};
+			port@1 {
+				reg = <1>;
+			};
+			port@2 {
+				reg = <2>;
+			};
+			port@3 {
+				reg = <3>;
+			};
+
+			/* output */
+			port@4 {
+				reg = <4>;
+			};
+		};
+	};
-- 
2.1.4

