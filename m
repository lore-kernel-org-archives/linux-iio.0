Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34571 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935107AbdCJKjo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 05:39:44 -0500
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
Subject: [PATCH v2 02/11] ARM: sun8i: a33: add all operating points
Date: Fri, 10 Mar 2017 11:39:12 +0100
Message-Id: <20170310103921.19469-3-quentin.schulz@free-electrons.com>
In-Reply-To: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds all operating points allowed for the A33 as defined by fex
files available at:
https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a33

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 arch/arm/boot/dts/sun8i-a33.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index b86f0e7..ba87a9e 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -49,24 +49,84 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp@120000000 {
+			opp-hz = /bits/ 64 <120000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@240000000 {
+			opp-hz = /bits/ 64 <240000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp@648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp@720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp@816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp@912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1200000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp@1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp@1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1320000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp@1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1320000>;
-- 
2.9.3

