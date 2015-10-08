Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0132.outbound.protection.outlook.com ([157.56.110.132]:24886
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932336AbbJHLLe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 8 Oct 2015 07:11:34 -0400
From: Haibo Chen <haibo.chen@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<shawnguo@kernel.org>, <kernel@pengutronix.de>,
	<mturquette@baylibre.com>, <sboyd@codeaurora.org>,
	<jic23@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 5/5] ARM: dts: imx7d-sdb: add ADC support
Date: Thu, 8 Oct 2015 18:59:08 +0800
Message-ID: <1444301948-21721-5-git-send-email-haibo.chen@freescale.com>
In-Reply-To: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
References: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ADC support for imx7d-sdb board.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 432aaf5..b2c4536 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -97,6 +97,16 @@
 	};
 };
 
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&adc2 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
 &cpu0 {
 	arm-supply = <&sw1a_reg>;
 };
-- 
1.9.1

