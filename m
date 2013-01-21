Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:51236 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137Ab3AUUFa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2013 15:05:30 -0500
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] ARM: mxs: Add OF props for MX23 LRADC
Date: Mon, 21 Jan 2013 21:05:22 +0100
Message-Id: <1358798722-25102-2-git-send-email-marex@denx.de>
In-Reply-To: <1358798722-25102-1-git-send-email-marex@denx.de>
References: <1358798722-25102-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add interrupt mapping and compatible string for MX23 LRADC.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 65415c5..56afcf4 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -391,7 +391,9 @@
 			};
 
 			lradc@80050000 {
+				compatible = "fsl,imx23-lradc";
 				reg = <0x80050000 0x2000>;
+				interrupts = <36 37 38 39 40 41 42 43 44>;
 				status = "disabled";
 			};
 
-- 
1.7.10.4

