Return-Path: <SRS0=EYTz=NO=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	robh+dt@kernel.org,
	pmeerw@pmeerw.net,
	lars@metafoo.de,
	knaack.h@gmx.de,
	jic23@kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: meson-saradc: add temperature sensor support
Date: Sun,  4 Nov 2018 00:10:23 +0100
Message-Id: <20181103231024.659-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181103231024.659-1-martin.blumenstingl@googlemail.com>
References: <20181103231024.659-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The 32-bit Meson8 SoC can use the SAR ADC to read the chip temperature.
This requires setting the correct TSC (temperature sensor coefficient),
which is programmed into the eFuse during the manufacturing process.
Meson8b and Meson8m2 are not supported yet because they have a 5-bit TSC
and only the first four bits are stored inside the SAR ADC registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index 54b823f3a453..325090e43ce6 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -22,6 +22,12 @@ Required properties:
 - vref-supply:	the regulator supply for the ADC reference voltage
 - #io-channel-cells: must be 1, see ../iio-bindings.txt
 
+Optional properties:
+- nvmem-cells:		phandle to the temperature_calib eFuse cells
+- nvmem-cell-names:	if present (to enable the temperature sensor
+			calibration) this must contain "temperature_calib"
+
+
 Example:
 	saradc: adc@8680 {
 		compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
-- 
2.19.1
