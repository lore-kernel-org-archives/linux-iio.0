Return-Path: <SRS0=fWxU=2F=jmondi.org=jacopo+renesas@kernel.org>
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com,
	magnus.damm@gmail.com,
	laurent.pinchart@ideasonboard.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	meerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: salvator-x: Add current sense amplifiers
Date: Fri, 24 Feb 2017 16:05:56 +0100
Message-Id: <1487948756-25172-5-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
List-ID: <linux-iio@vger.kernel.org>

Add device nodes for two Maxim max961x current sense amplifiers
sensing VDD_08 and DVFS_08 lines.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index fd05c2b..c533aef 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -261,6 +261,23 @@
 	status = "okay";
 };
 
+&i2c4 {
+	status = "okay";
+
+	csa_vdd: max9611_vdd@7c {
+		compatible = "maxim,max961x";
+		reg = <0x7c>;
+
+		shunt-resistor = <5000>;
+	};
+
+	csa_dvfs: max9611_dvfs@7f {
+		compatible = "maxim,max961x";
+		reg = <0x7f>;
+		shunt-resistor = <5000>;
+	};
+};
+
 &wdt0 {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.7.4
