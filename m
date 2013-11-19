Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47337 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343Ab3KSPzH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Nov 2013 10:55:07 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [RFC PATCH 3/3] ARM: cfa10057: Add the accelerometer and gyroscope to the device tree
Date: Tue, 19 Nov 2013 16:50:33 +0100
Message-Id: <1384876234-1211-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The CFA-10057 has an embedded ST Micro LSM330 DLC accelerometer and
gyroscope wired on the the i2c0 bus. Add those to the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10057.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 0333c0532f28..fc289465c30f 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -119,6 +119,19 @@
 				status = "okay";
 			};
 
+			i2c0: i2c@80058000 {
+				accel: accel@19 {
+					compatible = "st,lsm330dlc-accel";
+					reg = <0x19>;
+				};
+
+				gyro: gyro@6a {
+					compatible = "st,lsm330dlc-gyro";
+					reg = <0x6a>;
+				};
+			};
+
+
 			i2c1: i2c@8005a000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c1_pins_a>;
-- 
1.8.4.2

