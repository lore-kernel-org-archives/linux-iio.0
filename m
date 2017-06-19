Return-Path: <SRS0=fSvt=5Y=ti.com=m-stecklein@kernel.org>
From: Michael Stecklein <m-stecklein@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>
CC: "Andrew F . Davis" <afd@ti.com>, Michael Stecklein <m-stecklein@ti.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: iio: humidity: add bindings for HDC100x sensors
Date: Mon, 19 Jun 2017 11:01:04 -0500
Message-ID: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add the bindings for the family of HDC100x sensors.

Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
---
 .../devicetree/bindings/iio/humidity/hdc100x.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.txt

diff --git a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
new file mode 100644
index 0000000..c52333b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
@@ -0,0 +1,17 @@
+* HDC100x temperature + humidity sensors
+
+Required properties:
+  - compatible: Should contain one of the following:
+	ti,hdc1000
+	ti,hdc1008
+	ti,hdc1010
+	ti,hdc1050
+	ti,hdc1080
+  - reg: i2c address of the sensor
+
+Example:
+
+hdc100x@40 {
+	compatible = "ti,hdc1000";
+	reg = <0x40>;
+};
-- 
2.7.4
