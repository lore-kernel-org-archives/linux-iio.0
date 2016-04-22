Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:37420 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbcDVNxN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Apr 2016 09:53:13 -0400
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
	Marek Vasut <marex@denx.de>,
	linux-arm-kernel@lists.infradead.org,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH 2/3] ARM: dts: imx23: Provide regulators for the current sources of the LRADC
Date: Fri, 22 Apr 2016 13:52:26 +0000
Message-Id: <1461333147-11873-3-git-send-email-harald@ccbib.org>
In-Reply-To: <1461333147-11873-1-git-send-email-harald@ccbib.org>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the devicetree nodes to make the mxs-lradc driver register
regulator devices for the integrated current sources.

Tested on an imx23-olinuxino board.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Note: with this configuration the regulator devices will be present but
disabled by default.

 arch/arm/boot/dts/imx23.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 302d116..05ff6f1 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -471,6 +471,14 @@
 				status = "disabled";
 				clocks = <&clks 26>;
 				#io-channel-cells = <1>;
+
+				isrc_lradc0: ISRC0 {
+					regulator-max-microamp = <300>;
+				};
+
+				isrc_lradc1: ISRC1 {
+					regulator-max-microamp = <300>;
+				};
 			};
 
 			spdif@80054000 {
-- 
2.1.4

