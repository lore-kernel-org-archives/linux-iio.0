Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:51914 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbaBPLrV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 16 Feb 2014 06:47:21 -0500
Received: from [192.168.0.80] ([178.12.50.63]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEo4s-1WUwdp38Xq-00G1Lg for
 <linux-iio@vger.kernel.org>; Sun, 16 Feb 2014 12:47:19 +0100
Message-ID: <5300A545.5040308@gmx.de>
Date: Sun, 16 Feb 2014 12:47:17 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH]iio:max1363 fix typos of int_vref_mv
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes some typos in max1363_chip_info_tbl[].

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index e283f2f..de7d3b4 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1253,7 +1253,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 	[max11604] = {
 		.bits = 8,
-		.int_vref_mv = 4098,
+		.int_vref_mv = 4096,
 		.mode_list = max1238_mode_list,
 		.num_modes = ARRAY_SIZE(max1238_mode_list),
 		.default_mode = s0to11,
@@ -1313,7 +1313,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 	[max11610] = {
 		.bits = 10,
-		.int_vref_mv = 4098,
+		.int_vref_mv = 4096,
 		.mode_list = max1238_mode_list,
 		.num_modes = ARRAY_SIZE(max1238_mode_list),
 		.default_mode = s0to11,
@@ -1373,7 +1373,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 	[max11616] = {
 		.bits = 12,
-		.int_vref_mv = 4098,
+		.int_vref_mv = 4096,
 		.mode_list = max1238_mode_list,
 		.num_modes = ARRAY_SIZE(max1238_mode_list),
 		.default_mode = s0to11,
