Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35302 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab3FEQ3J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:29:09 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"Patil, Rachna" <rachna@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 14/22] arm/am33xx: add TSC/ADC mfd device support
Date: Wed,  5 Jun 2013 18:24:47 +0200
Message-Id: <1370449495-29981-15-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Patil, Rachna" <rachna@ti.com>

Add support for core multifunctional device along
with its clients touchscreen and ADC.

[ panto@antoniou-consulting.com : make sure status is
	set to 'disabled' in dtsi file. ]

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Patil, Rachna <rachna@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
[bigeasy: add 'status = "okay"']
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/arm/boot/dts/am335x-evm.dts |   14 ++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |    9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 0423298..26fea97 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -244,3 +244,17 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 };
+
+&tscadc {
+	status = "okay";
+	tsc {
+		ti,wires = <4>;
+		ti,x-plate-resistance = <200>;
+		ti,coordiante-readouts = <5>;
+		ti,wire-config = <0x00 0x11 0x22 0x33>;
+	};
+
+	adc {
+		ti,adc-channels = <4>;
+	};
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1460d9b..cc0656a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -404,6 +404,15 @@
 			ti,hwmods = "wkup_m3";
 		};
 
+		tscadc: tscadc@44e0d000 {
+			compatible = "ti,am3359-tscadc";
+			reg = <0x44e0d000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <16>;
+			ti,hwmods = "adc_tsc";
+			status = "disabled";
+		};
+
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
-- 
1.7.10.4

