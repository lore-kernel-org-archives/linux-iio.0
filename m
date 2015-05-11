Return-Path: <antoine.tenart@free-electrons.com>
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com,
	jszhang@marvell.com,
	yrliao@marvell.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] Documentation: bindings: document the Berlin ADC driver
Date: Mon, 11 May 2015 12:18:50 +0200
Message-Id: <1431339531-11938-3-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

Following the addition of a Berlin ADC driver, this patch adds the
corresponding bindings documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 .../devicetree/bindings/iio/adc/berlin2_adc.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
new file mode 100644
index 000000000000..908334c6b07f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
@@ -0,0 +1,19 @@
+* Berlin Analog to Digital Converter (ADC)
+
+The Berlin ADC has 8 channels, with one connected to a temperature sensor.
+It is part of the system controller register set. The ADC node should be a
+sub-node of the system controller node.
+
+Required properties:
+- compatible: must be "marvell,berlin2-adc"
+- interrupts: the interrupts for the ADC and the temperature sensor
+- interrupt-names: should be "adc" and "tsen"
+
+Example:
+
+adc: adc {
+	compatible = "marvell,berlin2-adc";
+	interrupt-parent = <&sic>;
+	interrupts = <12>, <14>;
+	interrupt-names = "adc", "tsen";
+};
-- 
2.4.0
