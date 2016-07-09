Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41215 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932486AbcGIBYJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2016 21:24:09 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 1/2] input: adc-keys: add DT binding documentation
Date: Sat,  9 Jul 2016 03:24:01 +0200
Message-Id: <1468027442-5033-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation for ADC keys

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v2:
 - fix title
 - use keyup-threshold-mvolt and press-threshold-mvolt instead of
   voltage-keyup-mvolt and voltage-mvolt.

 .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt

diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
new file mode 100644
index 000000000000..e43b8979b85a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adc-keys.txt
@@ -0,0 +1,45 @@
+ADC attached resistor ladder buttons
+------------------------------------
+
+Required properties:
+ - compatible: "adc-keys"
+ - io-channels: Phandle to an ADC channel
+ - io-channel-names = "buttons";
+ - keyup-threshold-mvolt: Voltage at which all the keys are considered up.
+
+Each key is represented as a sub-node of "adc-keys":
+
+Required subnode-properties:
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+	- press-threshold-mvolt: Voltage adc input when this key is pressed.
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&lradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-mvolt = <2000>;
+
+		button@1500 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-mvolt = <1500>;
+		};
+
+		button@1000 {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-mvolt = <1000>;
+		};
+
+		button@500 {
+			label = "Enter";
+			linux,code = <KEY_ENTER>;
+			press-threshold-mvolt = <500>;
+		};
+	};
+
-- 
2.8.1

