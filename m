Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60526 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758011AbdCUPgk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 11:36:40 -0400
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
Subject: [PATCH v3 08/11] ARM: dtsi: sun8i: a33: add thermal sensor
Date: Tue, 21 Mar 2017 16:36:08 +0100
Message-Id: <20170321153611.16228-9-quentin.schulz@free-electrons.com>
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the DT node for the thermal sensor present in the Allwinner
A33 GPADC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v3:
  - switched compatible to allwinner,sun8i-a33-ths,
  - renamed DT node name and label to ths to better match datasheet's name,

 arch/arm/boot/dts/sun8i-a33.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index b1cdff66..f391f71 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -266,6 +266,13 @@
 			status = "disabled";
 		};
 
+		ths: ths@01c25000 {
+			compatible = "allwinner,sun8i-a33-ths";
+			reg = <0x01c25000 0x100>;
+			#thermal-sensor-cells = <0>;
+			#io-channel-cells = <0>;
+		};
+
 		fe0: display-frontend@01e00000 {
 			compatible = "allwinner,sun8i-a33-display-frontend";
 			reg = <0x01e00000 0x20000>;
@@ -376,6 +383,11 @@
 			};
 		};
 	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&ths>;
+	};
 };
 
 &ccu {
-- 
2.9.3

