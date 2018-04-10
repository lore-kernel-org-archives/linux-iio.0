Return-Path: <SRS0=k1Fe=G7=prevas.dk=Sean.Nyekjaer@kernel.org>
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: jic23@kernel.org,
	robh+dt@kernel.org
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mark.rutland@arm.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [RFC PATCH v2 2/2] iio: ti-dac5571: Add DT binding documentation
Date: Tue, 10 Apr 2018 10:44:53 +0200
Message-Id: <20180410084453.6189-2-sean.nyekjaer@prevas.dk>
In-Reply-To: <20180410084453.6189-1-sean.nyekjaer@prevas.dk>
References: <20180322102336.32268-1-sean.nyekjaer@prevas.dk>
 <20180410084453.6189-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Adding binding documentation for Texas Instruments DAC5571 Family

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/dac/ti,dac5571.txt           | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
new file mode 100644
index 000000000000..03af6b9a4d07
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
@@ -0,0 +1,24 @@
+* Texas Instruments DAC5571 Family
+
+Required properties:
+ - compatible: Should contain
+    "ti,dac5571"
+    "ti,dac6571"
+    "ti,dac7571"
+    "ti,dac5574"
+    "ti,dac6574"
+    "ti,dac7574"
+    "ti,dac5573"
+    "ti,dac6573"
+    "ti,dac7573"
+ - reg: Should contain the DAC I2C address
+
+Optional properties:
+ - vref-supply: The regulator supply for DAC reference voltage
+
+Example:
+dac@0 {
+	compatible = "ti,dac5571";
+	reg = <0x4C>;
+	vref-supply = <&vdd_supply>;
+};
-- 
2.17.0
