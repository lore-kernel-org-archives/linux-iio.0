Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:61754 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab3IIKKZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 06:10:25 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so3043046eek.10
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2013 03:10:24 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/14] ARM: ux500: Enable the LPS001WP Pressure & Temperature sensor from DT
Date: Mon,  9 Sep 2013 11:09:58 +0100
Message-Id: <1378721410-30937-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
References: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After applying this node the LPS001WP sensor chip should probe
successfully once the driver support has also been applied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index f1fc128..2b43c26 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -153,6 +153,16 @@
 			status = "okay";
 		};
 
+		i2c@80128000 {
+			lps001wp@5c {
+				compatible = "st,lps001wp";
+				reg = <0x5c>;
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+		};
+
 		uart@80120000 {
 			status = "okay";
 		};
-- 
1.8.1.2

