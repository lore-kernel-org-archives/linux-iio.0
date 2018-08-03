Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:34128 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeHCCMo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Aug 2018 22:12:44 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc: jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: [PATCH v3 9/9] ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for ALS / proximity
Date: Thu,  2 Aug 2018 20:19:00 -0400
Message-Id: <20180803001900.25371-10-masneyb@onstation.org>
In-Reply-To: <20180803001900.25371-1-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds device tree bindings for the tsl2772 ALS / proximity
sensor for the LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 27 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 928affae1885..ed8f064d0895 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -242,6 +242,15 @@
 			};
 		};
 
+		i2c3_pins: i2c3 {
+			mux {
+				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
 		i2c12_pins: i2c12 {
 			mux {
 				pins = "gpio87", "gpio88";
@@ -333,6 +342,24 @@
 			};
 		};
 	};
+
+	i2c@f9925000 {
+		status = "ok";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_pins>;
+		clock-frequency = <100000>;
+		qcom,src-freq = <50000000>;
+
+		avago_apds993@39 {
+			compatible = "avago,apds9930";
+			reg = <0x39>;
+			interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+			vdd-supply = <&pm8941_l17>;
+			vddio-supply = <&pm8941_lvs1>;
+			led-max-microamp = <100000>;
+			amstaos,proximity-diodes = <0>;
+		};
+	};
 };
 
 &spmi_bus {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index cebb6ae9143a..6dcf2bee66fb 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -713,6 +713,17 @@
 			#size-cells = <0>;
 		};
 
+		blsp_i2c3: i2c@f9925000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9925000 0x1000>;
+			interrupts = <0 97 IRQ_TYPE_NONE>;
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		blsp_i2c8: i2c@f9964000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
-- 
2.17.1

