Return-Path: <SRS0=k6Ac=NR=pschenker.ch=dev@kernel.org>
From: Philippe Schenker <dev@pschenker.ch>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH 3/3] ARM: dts: Add stmpe-adc driver to relevant devicetrees
Date: Tue,  6 Nov 2018 17:41:16 +0100
Message-Id: <20181106164116.6299-3-dev@pschenker.ch>
In-Reply-To: <20181106164116.6299-1-dev@pschenker.ch>
References: <20181106164116.6299-1-dev@pschenker.ch>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Philippe Schenker <philippe.schenker@toradex.com>

Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/tegra30-colibri.dtsi | 14 ++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 3dc99dd8dde1..10ba925be35a 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -356,6 +356,20 @@
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
 		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq = <1>;
+			/* 12-bit ADC */
+			st,mod-12b = <1>;
+			/* internal ADC reference */
+			st,ref-sel = <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time = <4>;
+			/* forbid to use ADC channels 3-0 (touch) */
+			st,norequest-mask = <0x0F>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 87e15e7cb32b..2c11dc33526c 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -287,6 +287,20 @@
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
 		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq = <1>;
+			/* 12-bit ADC */
+			st,mod-12b = <1>;
+			/* internal ADC reference */
+			st,ref-sel = <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time = <4>;
+			/* forbid to use ADC channels 3-0 (touch) */
+			st,norequest-mask = <0x0F>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 7f112f192fe9..1fd3c1f60478 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1001,6 +1001,20 @@
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay = <5>;
 			};
+
+			stmpe_adc {
+				compatible = "st,stmpe-adc";
+				/* 3.25 MHz ADC clock speed */
+				st,adc-freq = <1>;
+				/* 12-bit ADC */
+				st,mod-12b = <1>;
+				/* internal ADC reference */
+				st,ref-sel = <0>;
+				/* ADC converstion time: 80 clocks */
+				st,sample-time = <4>;
+				/* forbid to use ADC channels 3-0 (touch) */
+				st,norequest-mask = <0x0F>;
+			};
 		};
 
 		/*
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 35af03ca9e90..d9fe112eb5ad 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -870,6 +870,20 @@
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay = <5>;
 			};
+
+			stmpe_adc {
+				compatible = "st,stmpe-adc";
+				/* 3.25 MHz ADC clock speed */
+				st,adc-freq = <1>;
+				/* 12-bit ADC */
+				st,mod-12b = <1>;
+				/* internal ADC reference */
+				st,ref-sel = <0>;
+				/* ADC converstion time: 80 clocks */
+				st,sample-time = <4>;
+				/* forbid to use ADC channels 3-0 (touch) */
+				st,norequest-mask = <0x0F>;
+			};
 		};
 
 		/*
-- 
2.19.1
