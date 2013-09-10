Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:42977 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab3IJMtx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:49:53 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so3875869eek.30
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:49:52 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/38] ARM: ux500: Enable the L3G4200D Gyroscope sensor from DT
Date: Tue, 10 Sep 2013 13:49:06 +0100
Message-Id: <1378817379-8238-6-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After applying this node the L3G4200D sensor chip should probe
successfully once the driver support has also been applied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index e37284e..0b53854 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -177,6 +177,14 @@
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
 			};
+
+			l3g4200d_gyro@68 {
+				compatible = "st,l3g4200d_gyro";
+				reg = <0x68>;
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
 		};
 
 		uart@80120000 {
-- 
1.8.1.2

