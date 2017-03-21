Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60573 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758035AbdCUPgk (ORCPT
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
Subject: [PATCH v3 11/11] ARM: sun8i: sina33: add highest OPP of CPUs
Date: Tue, 21 Mar 2017 16:36:11 +0100
Message-Id: <20170321153611.16228-12-quentin.schulz@free-electrons.com>
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The A33 supports 1.1GHz and 1.2GHz frequencies at 1.32V and the Sinlinx
SinA33 has its cpu-supply property set in the cpu DT node.

Therefore, CPUfreq knows how to handle the regulator in charge of the
CPU and can adjust its voltage to match the OPP.

Add these two CPU frequencies to the CPU OPP table of the Sinlinx
SinA33.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v3

 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index d84f1bd..a92dee1 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -87,6 +87,20 @@
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&cpu0_opp_table {
+	opp@1104000000 {
+		opp-hz = /bits/ 64 <1104000000>;
+		opp-microvolt = <1320000>;
+		clock-latency-ns = <244144>; /* 8 32k periods */
+	};
+
+	opp@1200000000 {
+		opp-hz = /bits/ 64 <1200000000>;
+		opp-microvolt = <1320000>;
+		clock-latency-ns = <244144>; /* 8 32k periods */
+	};
+};
+
 &de {
 	status = "okay";
 };
-- 
2.9.3

