Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60428 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757932AbdCUPgh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 11:36:37 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: [PATCH v3 03/11] ARM: dts: sun8i: sina33: add cpu-supply
Date: Tue, 21 Mar 2017 16:36:03 +0100
Message-Id: <20170321153611.16228-4-quentin.schulz@free-electrons.com>
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the cpu-supply DT property to the cpu0 DT node needed by
the board to adapt the regulator voltage depending on the currently used
OPP.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index cde14b3..d84f1bd 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -83,6 +83,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &de {
 	status = "okay";
 };
-- 
2.9.3

