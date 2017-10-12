Return-Path: <SRS0=aWpD=BL=samsung.com=m.purski@kernel.org>
From: Maciej Purski <m.purski@samsung.com>
To: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>,
	Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski
	<m.purski@samsung.com>
Subject: [PATCH v2 4/4] ARM: dts: Add ti-max-expected-current-microamp
 properties for ina231 in Odroid XU3
Date: Thu, 12 Oct 2017 14:36:05 +0200
Message-id: <1507811765-31005-5-git-send-email-m.purski@samsung.com>
In-reply-to: <1507811765-31005-1-git-send-email-m.purski@samsung.com>
References: <1507811765-31005-1-git-send-email-m.purski@samsung.com>
	<CGME20171012123642eucas1p2878b47147404d6699eb92f9316f7c1b5@eucas1p2.samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Set max expected current to values required by the documentation,
in order to achieve desired precision.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 9ed6564..bbad001 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -28,6 +28,7 @@
 		compatible = "ti,ina231";
 		reg = <0x40>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <9000>;
 	};
 
 	/* memory: VDD_MEM */
@@ -35,6 +36,7 @@
 		compatible = "ti,ina231";
 		reg = <0x41>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <3000>;
 	};
 
 	/* GPU: VDD_G3D */
@@ -42,6 +44,7 @@
 		compatible = "ti,ina231";
 		reg = <0x44>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <5000>;
 	};
 
 	/* A7 cluster: VDD_KFC */
@@ -49,6 +52,7 @@
 		compatible = "ti,ina231";
 		reg = <0x45>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-microamp = <2000>;
 	};
 };
 
-- 
2.7.4
