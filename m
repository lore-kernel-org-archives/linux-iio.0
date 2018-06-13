Return-Path: <SRS0=pN2Y=I7=axis.com=borys.movchan@kernel.org>
From: Borys Movchan <borys.movchan@axis.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Borys Movchan <borysmn@axis.com>,
	Borys Movchan <borysmn@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: light: add ISL29033 device bindings
Date: Wed, 13 Jun 2018 16:00:15 +0200
Message-ID: <20180613140043.5802-1-borys.movchan@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Borys Movchan <borysmn@axis.com>

Signed-off-by: Borys Movchan <borys.movchan@axis.com>
---
 .../devicetree/bindings/iio/light/isl29033.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29033.txt

diff --git a/Documentation/devicetree/bindings/iio/light/isl29033.txt b/Documentation/devicetree/bindings/iio/light/isl29033.txt
new file mode 100644
index 000000000000..988e40acc6ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/isl29033.txt
@@ -0,0 +1,18 @@
+Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated Digital Ambient Light Sensor
+
+Required properties:
+  - compatible : Must be "isil,isl29033".
+  - reg: the I2C address of the device
+
+Optional properties:
+  - isil,rext-kohms: External resistor nominal in kOhms used for ADC
+    reference. If not specified, 499 kOhm value will be used.
+
+Example:
+
+        als_sensor@44 {
+            compatible = "isil,isl29033";
+            reg = <0x44>;
+            isil,rext-kohms = <1000>;
+        };
+
-- 
2.11.0
