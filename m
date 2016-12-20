Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34609 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbcLTK2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 05:28:20 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@free-electrons.com
Subject: [PATCH 4/7] ARM: dts: sun8i-a33-sinlinx-sina33: add cpu-supply
Date: Tue, 20 Dec 2016 11:27:06 +0100
Message-Id: <20161220102709.9504-5-quentin.schulz@free-electrons.com>
In-Reply-To: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
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
index fef6abc..0901c57 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -63,6 +63,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.9.3

