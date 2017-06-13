Return-Path: <SRS0=/7UJ=5S=linaro.org=manivannan.sadhasivam@kernel.org>
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jic23@kernel.org,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	william.markezana@meas-spec.com,
	ludovic.tancerel@maplehightech.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	nicolas.dechesne@linaro.org,
	amit.kucheria@linaro.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] dt-bindings: iio: humidity: Add bindings for HTU21 and MS8607 sensors
Date: Tue, 13 Jun 2017 22:50:43 +0530
Message-Id: <1497374443-20935-1-git-send-email-manivannan.sadhasivam@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Add device tree bindings for Measurement-Specialties HTU21 temperature & humidity sensor and humidity part of MS8607 sensor

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/iio/humidity/htu21.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt

diff --git a/Documentation/devicetree/bindings/iio/humidity/htu21.txt b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
new file mode 100644
index 0000000..97d7963
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
@@ -0,0 +1,13 @@
+*HTU21 - Measurement-Specialties htu21 temperature & humidity sensor and humidity part of MS8607 sensor
+
+Required properties:
+
+	- compatible: should be "meas,htu21" or "meas,ms8607-humidity"
+	- reg: I2C address of the sensor
+
+Example:
+
+htu21@40 {
+	compatible = "meas,htu21";
+	reg = <0x40>;
+};
-- 
2.7.4
