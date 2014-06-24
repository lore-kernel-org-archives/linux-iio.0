Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16575 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbaFXMYm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jun 2014 08:24:42 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, kgene.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, cpgs@samsung.com,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/4] ARM: DTS: use new compatible string as per the
 documentation
Date: Tue, 24 Jun 2014 17:49:15 +0530
Message-id: <1403612356-23685-4-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As Murata is the Manufactures the NTC thermistors. The vendor
name in the compatibility is preposed to change to "murata, ncpXXX"

This patch uses the new compatibility string in exynos4412 based
Trats2 board.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
---
1. Updates the thermistor node in Exynos4412 based Trats2 dts
   using the new DT bindings for NTC thermistors updated with vendor-prefix

 arch/arm/boot/dts/exynos4412-trats2.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 11967f4..d35755a 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -771,7 +771,7 @@
 	};
 
 	thermistor-ap@0 {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
 		pullup-ohm = <100000>;	 /* 100K */
 		pulldown-ohm = <100000>; /* 100K */
@@ -779,7 +779,7 @@
 	};
 
 	thermistor-battery@1 {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
 		pullup-ohm = <100000>;	 /* 100K */
 		pulldown-ohm = <100000>; /* 100K */
-- 
1.7.9.5

