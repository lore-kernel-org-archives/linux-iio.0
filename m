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
Subject: [PATCH 4/7] ARM: dts: meson8b: add the temperature calibration data for the SAR ADC
Date: Sun, 28 Oct 2018 13:26:26 +0100
Message-Id: <20181028122629.10144-5-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
References: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The SAR ADC can measure the chip temperature of the SoC. This only
works if the chip is calibrated and if the calibration data is written
to the correct registers. The calibration data is stored in the upper
two bytes of eFuse offset 0x1f4.

This adds the eFuse cell for the temperature calibration data and
passes it to the SAR ADC. We also need to pass the HHI sysctrl node to
the SAR ADC because the 4th TSC (temperature sensor calibration
coefficient) bit is stored in the HHI region (unlike bits [3:0] which
are stored directly inside the SAR ADC's register area).

On boards that have the SAR ADC enabled channel 8 can be used to
measure the chip temperature.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index f92aab0aa247..dd47af174c4d 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -283,6 +283,11 @@
 	compatible = "amlogic,meson8b-efuse";
 	clocks = <&clkc CLKID_EFUSE>;
 	clock-names = "core";
+
+	temperature_calib: calib@1f4 {
+		/* only the upper two bytes are relevant */
+		reg = <0x1f4 0x4>;
+	};
 };
 
 &ethmac {
@@ -354,6 +359,9 @@
 	clocks = <&clkc CLKID_XTAL>,
 		<&clkc CLKID_SAR_ADC>;
 	clock-names = "clkin", "core";
+	amlogic,hhi-sysctrl = <&hhi>;
+	nvmem-cells = <&temperature_calib>;
+	nvmem-cell-names = "temperature_calib";
 };
 
 &sdio {
-- 
2.19.1
