Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13979 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaGVCFE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jul 2014 22:05:04 -0400
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org
Cc: ch.naveen@samsung.com, arnd@arndb.de, kgene.kim@samsung.com,
	kyungmin.park@samsung.com, t.figa@samsung.com,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv8 4/4] ARM: dts: Fix wrong compatible string for Exynos3250 ADC
Date: Tue, 22 Jul 2014 11:04:56 +0900
Message-id: <1405994696-3117-5-git-send-email-cw00.choi@samsung.com>
In-reply-to: <1405994696-3117-1-git-send-email-cw00.choi@samsung.com>
References: <1405994696-3117-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset fix wrong compatible string for Exynos3250 ADC. Exynos3250 SoC
need to control only special clock for ADC. Exynos SoC except for Exynos3250
has not included special clock for ADC. The exynos ADC driver can control
special clock if compatible string is 'exynos3250-adc-v2'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/exynos3250.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 15c9c87..767189a 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -407,10 +407,11 @@
 		};
 
 		adc: adc@126C0000 {
-			compatible = "samsung,exynos-adc-v3";
+			compatible = "samsung,exynos3250-adc",
+				     "samsung,exynos-adc-v2";
 			reg = <0x126C0000 0x100>, <0x10020718 0x4>;
 			interrupts = <0 137 0>;
-			clock-names = "adc", "sclk_tsadc";
+			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
 			io-channel-ranges;
-- 
1.8.0

