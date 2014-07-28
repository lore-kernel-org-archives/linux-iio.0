Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38565 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaG1MoN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jul 2014 08:44:13 -0400
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org
Cc: ch.naveen@samsung.com, arnd@arndb.de, kgene.kim@samsung.com,
	kyungmin.park@samsung.com, heiko@sntech.de, knaack.h@gmx.de,
	t.figa@samsung.com, linux-iio@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 3/3] dt-bindings: samsung: exynos_adc: Remove un-necessary
 white-sapce
Date: Mon, 28 Jul 2014 21:44:02 +0900
Message-id: <1406551442-15186-4-git-send-email-cw00.choi@samsung.com>
In-reply-to: <1406551442-15186-1-git-send-email-cw00.choi@samsung.com>
References: <1406551442-15186-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch remove un-necessary white-sapce to code clean.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
index 709efaa..5ee0266 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
@@ -30,7 +30,7 @@ Required properties:
 			- The base address and range of ADC register
 			- The base address and range of ADC_PHY register (every
 			  SoC except for s3c24xx/s3c64xx ADC)
-- interrupts: 		Contains the interrupt information for the timer. The
+- interrupts:		Contains the interrupt information for the timer. The
 			format is being dependent on which interrupt controller
 			the Samsung device uses.
 - #io-channel-cells = <1>; As ADC has multiple outputs
-- 
1.8.0

