Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:22263
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751623AbbKINkJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Nov 2015 08:40:09 -0500
From: Haibo Chen <haibo.chen@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<shawnguo@kernel.org>, <kernel@pengutronix.de>,
	<linux@arm.linux.org.uk>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <haibo.chen@freescale.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 4/4] ARM: dts: imx7d-sdb: add ADC support
Date: Mon, 9 Nov 2015 21:28:24 +0800
Message-ID: <1447075704-4605-5-git-send-email-haibo.chen@freescale.com>
In-Reply-To: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
References: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
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

