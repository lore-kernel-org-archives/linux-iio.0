Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:63388 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3IPQCm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 12:02:42 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so2124802eek.32
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2013 09:02:41 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/20] ARM: ux500: Enable the L3G4200D Gyroscope sensor from DT
Date: Mon, 16 Sep 2013 17:02:11 +0100
Message-Id: <1379347346-823-6-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After applying this node the L3G4200D sensor chip should probe
successfully once the driver support has also been applied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index b851713..7bc157f 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -162,6 +162,14 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 			};
 
+			l3g4200d@68 {
+				compatible = "st,l3g4200d";
+				reg = <0x68>;
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+
 			lsm303dlhc_accel@19 {
 				compatible = "st,lsm303dlhc_accel";
 				reg = <0x19>;
-- 
1.8.1.2

