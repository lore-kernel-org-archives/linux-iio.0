Return-Path: <SRS0=euYi=EY=electromag.com.au=preid@kernel.org>
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
  robh+dt@kernel.org, mark.rutland@arm.com, Michael.Hennerich@analog.com,
  preid@electromag.com.au, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: ad5272: Add bindings for Analog Devices digital potentiometers
Date: Mon, 29 Jan 2018 21:12:53 +0800
Message-Id: <1517231574-92777-2-git-send-email-preid@electromag.com.au>
In-Reply-To: <1517231574-92777-1-git-send-email-preid@electromag.com.au>
References: <1517231574-92777-1-git-send-email-preid@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

Add binding documentation for Analog Devices AD5272 and AD5274 digital
potentiometer devices.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 .../bindings/iio/potentiometer/ad5272.txt          | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
new file mode 100644
index 0000000..11e804c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
@@ -0,0 +1,27 @@
+* Analog Devices AD5272 digital potentiometer driver
+
+The node for this driver must be a child node of a I2C controller, hence
+all mandatory properties for your controller must be specified. See directory:
+
+        Documentation/devicetree/bindings/i2c
+
+for more details.
+
+Required properties:
+	- compatible:  	Must be one of the following, depending on the model:
+			adi,ad5272-020
+			adi,ad5272-050
+			adi,ad5272-100
+			adi,ad5274-020
+			adi,ad5274-100
+
+Optional properties:
+ - reset-gpios: GPIO specification for the RESET input. This is an
+		active low signal to the PCA953x.
+
+Example:
+ad5272: ad5272@2f {
+	reg = <0x2F>;
+	compatible = "adi,ad5272-020";
+	reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
+};
-- 
1.8.3.1
