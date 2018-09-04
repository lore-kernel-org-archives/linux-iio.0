Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21406 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXbg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Sep 2018 19:31:36 -0400
From: Afonso Bordado <afonsobordado@az8.co>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] iio: gyro: add device tree support for fxas21002c
Date: Tue,  4 Sep 2018 21:04:32 +0100
Message-Id: <20180904200434.10442-2-afonsobordado@az8.co>
In-Reply-To: <20180904200434.10442-1-afonsobordado@az8.co>
References: <20180904200434.10442-1-afonsobordado@az8.co>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds device tree support for the fxas21002c driver, including
bindings.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 35 +++++++++++++++++++
 drivers/iio/gyro/fxas21002c.c                 | 10 +++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
new file mode 100644
index 000000000000..5f02cfa5ac82
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
@@ -0,0 +1,35 @@
+* Freescale FXAS21002C Digital Angular Rate Gyroscope
+
+Required properties:
+
+  - compatible: must be "fsl,fxas21002c"
+  - reg : the I2C address of the sensor
+
+Optional properties:
+
+  - interrupt-parent	: phandle to the parent interrupt controller.
+			  see interrupt-controller/interrupts.txt
+  - interrupts		: The first interrupt listed must be the one
+			  connected to the INT1 pin, the second interrupt
+			  listed must be the one connected to the INT2 pin.
+			  The interrupts can be triggered on rising or falling
+			  edges alike.
+			  see interrupt-controller/interrupts.txt
+  - vdd-supply 		: The main voltage regulator
+  - iovdd-supply 	: The IO voltage regulator
+			  see regulator/regulator.txt
+  - reset-gpios		: GPIO used to reset the device.
+			  see gpio/gpio.txt.
+  - mount-matrix	: see iio/mount-matrix.txt
+
+Example:
+gyroscope@20 {
+	compatible = "fsl,fxas21002c";
+	reg = <0x20>;
+	reset-gpios = <&gpio0 2 0>;
+	vdd-supply = <&vref>;
+	iovdd-supply = <&vref2>;
+	interrupt-parent = <&foo>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
+		     <1 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)>;
+};
diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
index 1668e6f3fe11..18b1f500dd3e 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -8,7 +8,6 @@
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
  *        ODR / Scale Support
- *        Devicetree
  *        Power management
  *        GPIO Reset
  *        Power supplies
@@ -350,6 +349,14 @@ static int fxas21002c_probe(struct i2c_client *client,
 	return ret;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id fxas21002c_of_ids[] = {
+	{.compatible = "fsl,fxas21002c"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_of_ids);
+#endif
+
 static const struct i2c_device_id fxas21002c_id[] = {
 	{"fxas21002c", ID_FXAS21002C},
 	{}
@@ -360,6 +367,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
 static struct i2c_driver fxas21002c_driver = {
 	.driver = {
 		.name = FXAS21002C_DRV_NAME,
+		.of_match_table = of_match_ptr(fxas21002c_of_ids),
 	},
 	.probe		= fxas21002c_probe,
 	.id_table	= fxas21002c_id,
-- 
2.18.0
