Return-Path: <SRS0=/7UJ=5S=linaro.org=manivannan.sadhasivam@kernel.org>
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jic23@kernel.org,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	william.markezana@meas-spec.com,
	ludovic.tancerel@maplehightech.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] dt-bindings: iio: temperature: Add bindings for TSYS01 temperature sensor
Date: Tue, 13 Jun 2017 21:23:13 +0530
Message-Id: <1497369193-32538-1-git-send-email-manivannan.sadhasivam@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Add device tree bindings for Measurement Specialties TSYS01 temperature sensor

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/iio/temperature/tsys01.txt    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/tsys01.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/tsys01.txt b/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
new file mode 100644
index 0000000..0d5cc55
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/tsys01.txt
@@ -0,0 +1,19 @@
+* TSYS01 - Measurement Specialties temperature sensor
+
+Required properties:
+
+	- compatible: should be "meas,tsys01"
+	- reg: I2C address of the sensor (changeable via CSB pin)
+
+		------------------------
+		| CSB | Device Address |
+		------------------------
+		   1         0x76
+		   0	     0x77
+
+Example:
+
+tsys01@76 {
+	compatible = "meas,tsys01";
+	reg = <0x76>;
+};
-- 
2.7.4
