Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42611 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdLDPcD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 10:32:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id l141so6545975wmg.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2017 07:32:03 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: temperature: add MLX90632 device bindings
Date: Mon,  4 Dec 2017 16:31:54 +0100
Message-Id: <20171204153154.26211-1-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree bindings for MLX90632 IR temperature sensor.

Signed-off-by: Crt Mori <cmo@melexis.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/temperature/mlx90632.txt          | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
new file mode 100644
index 000000000000..0b05812001f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
@@ -0,0 +1,28 @@
+* Melexis MLX90632 contactless Infra Red temperature sensor
+
+Link to datasheet: https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90632
+
+There are various applications for the Infra Red contactless temperature sensor
+and MLX90632 is most suitable for consumer applications where measured object
+temperature is in range between -20 to 200 degrees Celsius with relative error
+of measurement below 1 degree Celsius in object temperature range for
+industrial applications. Since it can operate and measure ambient temperature
+in range of -20 to 85 degrees Celsius it is suitable also for outdoor use.
+
+Be aware that electronics surrounding the sensor can increase ambient
+temperature. MLX90632 can be calibrated to reduce the housing effect via
+already existing EEPROM parameters.
+
+Since measured object emissivity effects Infra Red energy emitted, emissivity
+should be set before requesting the object temperature.
+
+Required properties:
+  - compatible: should be "melexis,mlx90632"
+  - reg: the I2C address of the sensor (default 0x3a)
+
+Example:
+
+mlx90632@3a {
+	compatible = "melexis,mlx90632";
+	reg = <0x3a>;
+};
-- 
2.15.0

