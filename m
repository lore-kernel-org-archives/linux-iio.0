Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36710 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbFHFoz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2015 01:44:55 -0400
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org, shawn.guo@linaro.org, kernel@pengutronix.de
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stefan@agner.ch,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v1 2/2] ARM: dts: vfxxx: Add property for minimum sample time
Date: Mon,  8 Jun 2015 11:12:01 +0530
Message-Id: <4d2ba0ad1bbc61dedc9ec144e9be6aeb6cf4747d.1433740528.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1433740528.git.maitysanchayan@gmail.com>
References: <cover.1433740528.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1433740528.git.maitysanchayan@gmail.com>
References: <cover.1433740528.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a device tree property which allows to specify the minimum sample
time which can be used to calculate the actual ADC cycles required
depending on the hardware.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 90a03d5..463cfe3 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -229,6 +229,7 @@
 				status = "disabled";
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							<20000000>;
+				fsl,min-sample-time = <1000>;
 			};
 
 			wdoga5: wdog@4003e000 {
@@ -447,6 +448,7 @@
 				status = "disabled";
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							<20000000>;
+				fsl,min-sample-time = <1000>;
 			};
 
 			esdhc1: esdhc@400b2000 {
-- 
2.4.2

