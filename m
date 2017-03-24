Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48433 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757380AbdCXP3b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 11:29:31 -0400
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, wsa+renesas@sang-engineering.com,
        magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: salvator-x: Add current sense amplifiers
Date: Fri, 24 Mar 2017 16:28:43 +0100
Message-Id: <1490369323-13866-5-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device nodes for two Maxim max961x current sense amplifiers
sensing VDD_08 and DVFS_08 lines.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index c7f40f8..389a177 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -257,6 +257,24 @@
 	status = "okay";
 };
 
+&i2c4 {
+	status = "okay";
+
+	csa_vdd: adc@7c {
+		compatible = "maxim,max9611";
+		reg = <0x7c>;
+
+		shunt-resistor-uohm = <5000>;
+	};
+
+	csa_dvfs: adc@7f {
+		compatible = "maxim,max9611";
+		reg = <0x7f>;
+
+		shunt-resistor-uohm = <5000>;
+	};
+};
+
 &wdt0 {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.7.4

