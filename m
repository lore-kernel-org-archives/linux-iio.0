Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Juergen Beisert <jbe@pengutronix.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wolfgang Denk <wd@denx.de>
Subject: [PATCH 3/3] IIO: arm: Add LRADC to i.MX28 dts
Date: Sun, 12 Aug 2012 17:21:58 +0200
Message-Id: <1344784918-32352-4-git-send-email-marex@denx.de>
In-Reply-To: <1344784918-32352-1-git-send-email-marex@denx.de>
References: <1344784918-32352-1-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Juergen Beisert <jbe@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/boot/dts/imx28.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 2a413ed..ad90c59 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -677,7 +677,10 @@
 			};
 
 			lradc@80050000 {
+				compatible = "fsl,imx28-lradc";
 				reg = <0x80050000 0x2000>;
+				interrupts = <10 14 15 16 17 18 19
+						20 21 22 23 24 25>;
 				status = "disabled";
 			};
 
-- 
1.7.10.4
