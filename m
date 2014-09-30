Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47760 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaI3MAp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Sep 2014 08:00:45 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so5101648pdb.11
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2014 05:00:44 -0700 (PDT)
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH v3 4/4] arch: arm: boot: dts: Added correct vendor-prefix with device name to compatible property
Date: Tue, 30 Sep 2014 17:29:08 +0530
Message-Id: <1412078348-7646-5-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
References: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the correct vendor-prefix listed in Documentation/devicetree/bindings/vendor-prefixes.txt
with the device name to compatible property and removes deprecated vendor-prefix.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 2063795..dcc6c75 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -187,7 +187,7 @@
 
 		/* ALS and Proximity sensor */
 		isl29028@44 {
-			compatible = "isil,isl29028";
+			compatible = "isl,isl29028";
 			reg = <0x44>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1

