Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2on0144.outbound.protection.outlook.com ([207.46.100.144]:63996
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755513AbbLAISm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Dec 2015 03:18:42 -0500
From: Haibo Chen <haibo.chen@freescale.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <shawnguo@kernel.org>, <kernel@pengutronix.de>
CC: <haibo.chen@freescale.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v4 4/4] ARM: dts: imx7d-sdb: add ADC support
Date: Tue, 1 Dec 2015 16:22:30 +0800
Message-ID: <1448958150-25579-5-git-send-email-haibo.chen@freescale.com>
In-Reply-To: <1448958150-25579-1-git-send-email-haibo.chen@freescale.com>
References: <1448958150-25579-1-git-send-email-haibo.chen@freescale.com>
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

