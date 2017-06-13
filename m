Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33065 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdFMRVr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2017 13:21:47 -0400
Received: by mail-pf0-f180.google.com with SMTP id 83so70990793pfr.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2017 10:21:46 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jic23@kernel.org, pmeerw@pmeerw.net, robh+dt@kernel.org,
        william.markezana@meas-spec.com, ludovic.tancerel@maplehightech.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        nicolas.dechesne@linaro.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] dt-bindings: iio: pressure: Add bindings for MS5637, MS5805, MS5837 and MS8607 sensors
Date: Tue, 13 Jun 2017 22:51:32 +0530
Message-Id: <1497374492-21040-1-git-send-email-manivannan.sadhasivam@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree bindings for Measurement-Specialties MS5637, MS5805, MS5837 and MS8607 pressure & temperature sensor

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/iio/pressure/ms5637.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5637.txt

diff --git a/Documentation/devicetree/bindings/iio/pressure/ms5637.txt b/Documentation/devicetree/bindings/iio/pressure/ms5637.txt
new file mode 100644
index 0000000..c0f3f8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/ms5637.txt
@@ -0,0 +1,18 @@
+* MS5637 - Measurement-Specialties MS5637, MS5805, MS5837 and MS8607 pressure & temperature sensor
+
+Required properties:
+
+	-compatible: should be one of the following
+		meas,ms5637
+		meas,ms5805
+		meas,ms5837
+		meas,ms8607-temppressure
+	-reg: I2C address of the sensor
+
+Example:
+
+ms5637@76 {
+	compatible = "meas,ms5637";
+	reg = <0x76>;
+};
+	
-- 
2.7.4

