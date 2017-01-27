Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48801 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932330AbdA0Jvv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 04:51:51 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH v2 06/25] ARM: dtsi: axp209: add AXP209 ADC subnode
Date: Fri, 27 Jan 2017 09:54:39 +0100
Message-Id: <20170127085458.18270-7-quentin.schulz@free-electrons.com>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the ADC subnode for AXP20X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - removed #io-channels property (the IIO channels mapping is done by
 using iio_map structure in the ADC driver),

 arch/arm/boot/dts/axp209.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 675bb0f..00f6ff5 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -53,6 +53,10 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp209_adc: adc {
+		compatible = "x-powers,axp209-adc";
+	};
+
 	axp_gpio: gpio {
 		compatible = "x-powers,axp209-gpio";
 		gpio-controller;
-- 
2.9.3

