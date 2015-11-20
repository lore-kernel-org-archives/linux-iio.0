Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2on0144.outbound.protection.outlook.com ([65.55.169.144]:30304
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1163164AbbKTPoq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 20 Nov 2015 10:44:46 -0500
From: Haibo Chen <haibo.chen@freescale.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <shawnguo@kernel.org>,
	<kernel@pengutronix.de>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux@arm.linux.org.uk>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/4] ARM: dts: imx7d-sdb: add ADC support
Date: Fri, 20 Nov 2015 23:48:15 +0800
Message-ID: <1448034495-1759-5-git-send-email-haibo.chen@freescale.com>
In-Reply-To: <1448034495-1759-1-git-send-email-haibo.chen@freescale.com>
References: <1448034495-1759-1-git-send-email-haibo.chen@freescale.com>
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

