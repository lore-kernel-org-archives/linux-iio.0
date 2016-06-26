Return-Path: <florian.vaussard@gmail.com>
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v2 1/2] iio: adc: max1363: Add device tree binding documentation
Date: Sun, 26 Jun 2016 22:04:03 +0200
Message-Id: <1466971444-5333-2-git-send-email-florian.vaussard@heig-vd.ch>
In-Reply-To: <1466971444-5333-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1466971444-5333-1-git-send-email-florian.vaussard@heig-vd.ch>
List-ID: <linux-iio@vger.kernel.org>

Add the device tree documentation for all the supported parts. Mandatory
binding is the compatible string and the slave I2C address.

Optional properties can be used to specify the Vcc / Vref regulators, as
well as the IRQ line if available.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 .../devicetree/bindings/iio/adc/max1363.txt        | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/max1363.txt b/Documentation/devicetree/bindings/iio/adc/max1363.txt
new file mode 100644
index 0000000..94a9011
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/max1363.txt
@@ -0,0 +1,63 @@
+* Maxim 1x3x/136x/116xx Analog to Digital Converter (ADC)
+
+The node for this driver must be a child node of a I2C controller, hence
+all mandatory properties for your controller must be specified. See directory:
+
+        Documentation/devicetree/bindings/i2c
+
+for more details.
+
+Required properties:
+  - compatible: Should be one of
+		"maxim,max1361"
+		"maxim,max1362"
+		"maxim,max1363"
+		"maxim,max1364"
+		"maxim,max1036"
+		"maxim,max1037"
+		"maxim,max1038"
+		"maxim,max1039"
+		"maxim,max1136"
+		"maxim,max1137"
+		"maxim,max1138"
+		"maxim,max1139"
+		"maxim,max1236"
+		"maxim,max1237"
+		"maxim,max1238"
+		"maxim,max1239"
+		"maxim,max11600"
+		"maxim,max11601"
+		"maxim,max11602"
+		"maxim,max11603"
+		"maxim,max11604"
+		"maxim,max11605"
+		"maxim,max11606"
+		"maxim,max11607"
+		"maxim,max11608"
+		"maxim,max11609"
+		"maxim,max11610"
+		"maxim,max11611"
+		"maxim,max11612"
+		"maxim,max11613"
+		"maxim,max11614"
+		"maxim,max11615"
+		"maxim,max11616"
+		"maxim,max11617"
+		"maxim,max11644"
+		"maxim,max11645"
+		"maxim,max11646"
+		"maxim,max11647"
+  - reg: Should contain the ADC I2C address
+
+Optional properties:
+  - vcc-supply: phandle to the regulator that provides power to the ADC.
+  - vref-supply: phandle to the regulator for ADC reference voltage.
+  - interrupts: IRQ line for the ADC. If not used the driver will use
+    polling.
+
+Example:
+adc: max11644@36 {
+	compatible = "maxim,max11644";
+	reg = <0x36>;
+	vref-supply = <&adc_vref>;
+};
-- 
2.5.5
