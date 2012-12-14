Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58713 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab2LNBq5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Dec 2012 20:46:57 -0500
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/3] iio: mxs: Enable touchscreen on m28evk
Date: Fri, 14 Dec 2012 02:46:38 +0100
Message-Id: <1355449598-15980-3-git-send-email-marex@denx.de>
In-Reply-To: <1355449598-15980-1-git-send-email-marex@denx.de>
References: <1355449598-15980-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds necessary DT properties to m28evk to enable touchscreen
in the LRADC block. The M28EVK is shipped with 4-wire resistive touchscreen.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-m28evk.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index c718f91..712d99a 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -213,6 +213,7 @@
 
 			lradc@80050000 {
 				status = "okay";
+				fsl,lradc-touchscreen-wires = <4>;
 			};
 
 			duart: serial@80074000 {
-- 
1.7.10.4

