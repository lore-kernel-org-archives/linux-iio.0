Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57281 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755462AbdJLNSV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2017 09:18:21 -0400
From: Maciej Purski <m.purski@samsung.com>
To: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 4/4] ARM: dts: Add ti-max-expected-current-milliamp
 properties for ina231 in Odroid XU3
Date: Thu, 12 Oct 2017 15:18:02 +0200
Message-id: <1507814282-1486-5-git-send-email-m.purski@samsung.com>
In-reply-to: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
References: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
        <CGME20171012131817eucas1p1c1dd009d306c34e62cfdb850247f36d5@eucas1p1.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Set max expected current to values required by the documentation,
in order to achieve desired precision.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 9ed6564..a34c1e5 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -28,6 +28,7 @@
 		compatible = "ti,ina231";
 		reg = <0x40>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-milliamp = <9000>;
 	};
 
 	/* memory: VDD_MEM */
@@ -35,6 +36,7 @@
 		compatible = "ti,ina231";
 		reg = <0x41>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-milliamp = <3000>;
 	};
 
 	/* GPU: VDD_G3D */
@@ -42,6 +44,7 @@
 		compatible = "ti,ina231";
 		reg = <0x44>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-milliamp = <5000>;
 	};
 
 	/* A7 cluster: VDD_KFC */
@@ -49,6 +52,7 @@
 		compatible = "ti,ina231";
 		reg = <0x45>;
 		shunt-resistor = <10000>;
+		ti-max-expected-current-milliamp = <2000>;
 	};
 };
 
-- 
2.7.4

