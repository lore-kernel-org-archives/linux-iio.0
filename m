Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34269 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcBIFbX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 00:31:23 -0500
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, shawnguo@kernel.org, stefan@agner.ch,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v1 1/2] ARM: dts: vfxxx: Add DAC node for Vybrid SoC
Date: Tue,  9 Feb 2016 10:56:05 +0530
Message-Id: <537afe56ca3ceafe130604d66636bc90bc827298.1454939346.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1454939346.git.maitysanchayan@gmail.com>
References: <cover.1454939346.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1454939346.git.maitysanchayan@gmail.com>
References: <cover.1454939346.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a device tree node entry for DAC peripheral on Vybrid SoC.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index a5f07e3..8238069 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -602,6 +602,24 @@
 				status = "disabled";
 			};
 
+			dac0: dac@400cc000 {
+				compatible = "fsl,vf610-dac";
+				reg = <0x400cc000 1000>;
+				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "dac";
+				clocks = <&clks VF610_CLK_DAC0>;
+				status = "disabled";
+			};
+
+			dac1: dac@400cd000 {
+				compatible = "fsl,vf610-dac";
+				reg = <0x400cd000 1000>;
+				interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "dac";
+				clocks = <&clks VF610_CLK_DAC1>;
+				status = "disabled";
+			};
+
 			fec0: ethernet@400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
-- 
2.7.1

