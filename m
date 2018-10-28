Return-Path: <SRS0=Ck17=NI=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	robh+dt@kernel.org,
	pmeerw@pmeerw.net,
	lars@metafoo.de,
	knaack.h@gmx.de,
	jic23@kernel.org
Cc: khilman@baylibre.com,
	carlo@caione.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/7] dt-bindings: iio: adc: meson-saradc: add temperature sensor support
Date: Sun, 28 Oct 2018 13:26:23 +0100
Message-Id: <20181028122629.10144-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
References: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The 32-bit Meson SoCs Meson8, Meson8b and Meson8m2 can use the SAR ADC
to read the chip temperature. This requires a few new, optional
properties:
- nvmem-cells and nvmem-cell-names are needed because the temperature
  sensor requires calibration to work correctly. The calibration data is
  stored in the eFuse.
- amlogic,hhi-sysctrl is needed on Meson8b and Meson8m2 because the 5th
  bit of the TSC (temperature sensor calibration coefficient) is stored
  in the HHI register region (in the scratch register HHI_DPLL_TOP_0 at
  offset 0x318).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/iio/adc/amlogic,meson-saradc.txt          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index 54b823f3a453..75c775954102 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -22,6 +22,16 @@ Required properties:
 - vref-supply:	the regulator supply for the ADC reference voltage
 - #io-channel-cells: must be 1, see ../iio-bindings.txt
 
+Optional properties:
+- amlogic,hhi-sysctrl:	phandle to the syscon which contains the 5th bit
+			of the TSC (temperature sensor coefficient) on
+			Meson8b and Meson8m2 (which used to calibrate the
+			temperature sensor)
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
