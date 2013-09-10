Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:35776 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab3IJMtu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:49:50 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so3884823eaj.11
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:49:49 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/38] ARM: ux500: Enable the LPS001WP Pressure & Temperature sensor from DT
Date: Tue, 10 Sep 2013 13:49:03 +0100
Message-Id: <1378817379-8238-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After applying this node the LPS001WP sensor chip should probe
successfully once the driver support has also been applied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index f1fc128..d355d25 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -153,6 +153,16 @@
 			status = "okay";
 		};
 
+		i2c@80128000 {
+			lps001wp_press@5c {
+				compatible = "st,lps001wp_press";
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

