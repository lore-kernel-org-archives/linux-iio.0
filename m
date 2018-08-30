Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37953 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3Tsc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:32 -0400
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 24/30] ARM: dts: sun8i: h3: add support for the thermal sensor in H3
Date: Thu, 30 Aug 2018 17:45:12 +0200
Message-Id: <20180830154518.29507-25-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the missing compatible and the thermal sensor cells.
The H3 has one sensor.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..5b7994cb1471 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -185,3 +185,8 @@
 &pio {
 	compatible = "allwinner,sun8i-h3-pinctrl";
 };
+
+&ths {
+	compatible = "allwinner,sun8i-h3-ths";
+	#thermal-sensor-cells = <0>;
+};
-- 
2.11.0
