Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:7097
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753210AbdARQDs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Jan 2017 11:03:48 -0500
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
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 11/12] dt-bindings: simplified bindings for single-user gpio mux
Date: Wed, 18 Jan 2017 16:57:14 +0100
Message-ID: <1484755035-25927-12-git-send-email-peda@axentia.se>
In-Reply-To: <1484755035-25927-1-git-send-email-peda@axentia.se>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow bindings for a GPIO controlled mux to be specified in the
mux consumer node.

Acked-by: Jonathan Cameron <jic23@kernel.org>
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

