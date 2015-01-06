Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: Jonathan Cameron <jic23@kernel.org>, James Hartley
	<james.hartley@imgtec.com>, Andrew Bresticker <abrestic@chromium.org>,
	<robh+dt@kernel.org>, <Mark.Rutland@arm.com>, <knaack.h@gmx.de>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<Pawel.Moll@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, Phani Movva <Phani.Movva@imgtec.com>, Naidu Tellapati
	<Naidu.Tellapati@imgtec.com>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v6 2/3] DT: iio: adc: Add CC_10001 binding documentation
Date: Tue, 6 Jan 2015 12:29:02 -0300
Message-ID: <1420558143-26276-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1420558143-26276-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1420558143-26276-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Phani Movva <Phani.Movva@imgtec.com>

Add the devicetree binding document for Cosmic Circuits 10001 ADC device.

Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
[Ezequiel: minor style cleaning]
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 .../devicetree/bindings/iio/adc/cc10001_adc.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
new file mode 100644
index 0000000..b7ba558
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
@@ -0,0 +1,22 @@
+* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
+
+Required properties:
+  - compatible: Should be "cosmic,10001-adc"
+  - reg: Should contain adc registers location and length.
+  - clock-names: Should contain "adc".
+  - clocks: Should contain a clock specifier for each entry in clock-names
+  - vref-supply: The regulator supply ADC reference voltage.
+
+Optional properties:
+  - cosmic,adc-reserved-channels: Bitmask of reserved channels,
+    i.e. channels that cannot be used by the OS.
+
+Example:
+adc: adc@18101600 {
+	compatible = "cosmic,10001-adc";
+	reg = <0x18101600 0x24>;
+	cosmic,adc-reserved-channels = <0x2>;
+	clocks = <&adc_clk>;
+	clock-names = "adc";
+	vref-supply = <&reg_1v8>;
+};
-- 
2.2.1
