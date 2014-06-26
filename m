Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:20186 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844AbaFZMXF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jun 2014 08:23:05 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, cpgs@samsung.com
Subject: [PATCH 2/3] ARM: DTS: Add NTC thermistor nodes to Exynos5250 based Snow
Date: Thu, 26 Jun 2014 17:49:07 +0530
Message-id: <1403785148-20792-3-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403785148-20792-1-git-send-email-ch.naveen@samsung.com>
References: <1403785148-20792-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Exynos5250 based Snow board has 4 NTC thermistors to measure
temperatures at various points on the board.

IIO based ADC becomes the parent and NTC thermistors are the childs,
via the HWMON interface.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
Posted earlier by Doug Anderson @ https://lkml.org/lkml/2013/3/27/453

This patch depends on (1/4 and 2/4 patches of) patchset posted 
http://www.spinics.net/lists/linux-iio/msg13486.html
Which were applied on to Guenter Roeck's tree.

cat sysfs entries exported by hwmon for 4 thermistors
and verified the values on Snow.

 arch/arm/boot/dts/exynos5250-snow.dts |   34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 7bd2df1..0fa7067 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -20,6 +20,40 @@
 		i2c104 = &i2c_104;
 	};
 
+	adc@12D10000 {
+		status = "okay";
+		vdd-supply = <&buck5_reg>;
+
+		ncp15wb473@3 {
+			compatible = "murata,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 3>;
+		};
+		ncp15wb473@4 {
+			compatible = "murata,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 4>;
+		};
+		ncp15wb473@5 {
+			compatible = "murata,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 5>;
+		};
+		ncp15wb473@6 {
+			compatible = "murata,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 6>;
+		};
+	};
+
 	rtc@101E0000 {
 		status = "okay";
 	};
-- 
1.7.9.5

