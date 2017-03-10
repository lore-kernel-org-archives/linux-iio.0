Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34601 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935157AbdCJKjp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 05:39:45 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, stefan.mavrodiev@gmail.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com
Subject: [PATCH v2 04/11] ARM: dts: sun8i: olinuxino: add cpu-supply
Date: Fri, 10 Mar 2017 11:39:14 +0100
Message-Id: <20170310103921.19469-5-quentin.schulz@free-electrons.com>
In-Reply-To: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the cpu-supply DT property to the cpu0 DT node needed by
the board to adapt the regulator voltage depending on the currently use
OPP.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index be9a6b8..9d25e90 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -72,6 +72,10 @@
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

