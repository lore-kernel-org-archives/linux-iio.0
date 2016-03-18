Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32820 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520AbcCRPvv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Mar 2016 11:51:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id x188so7125967wmg.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Mar 2016 08:51:51 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, stefan.eichenberger@netmodule.com
Subject: [PATCH 2/2] iio: adc: max1363: correct reference voltage
Date: Fri, 18 Mar 2016 16:51:04 +0100
Message-Id: <1458316264-18244-2-git-send-email-stefan.eichenberger@netmodule.com>
In-Reply-To: <1458316264-18244-1-git-send-email-stefan.eichenberger@netmodule.com>
References: <1458316264-18244-1-git-send-email-stefan.eichenberger@netmodule.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Swap max11644/max11645 and max 11646/max11647 reference voltages according
to datasheet.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@netmodule.com>
---
 drivers/iio/adc/max1363.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index b5d28c0..998dc3c 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1386,7 +1386,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 	[max11644] = {
 		.bits = 12,
-		.int_vref_mv = 2048,
+		.int_vref_mv = 4096,
 		.mode_list = max11644_mode_list,
 		.num_modes = ARRAY_SIZE(max11644_mode_list),
 		.default_mode = s0to1,
@@ -1396,7 +1396,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 	[max11645] = {
 		.bits = 12,
-		.int_vref_mv = 4096,
+		.int_vref_mv = 2048,
 		.mode_list = max11644_mode_list,
 		.num_modes = ARRAY_SIZE(max11644_mode_list),
 		.default_mode = s0to1,
@@ -1406,7 +1406,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 	[max11646] = {
 		.bits = 10,
-		.int_vref_mv = 2048,
+		.int_vref_mv = 4096,
 		.mode_list = max11644_mode_list,
 		.num_modes = ARRAY_SIZE(max11644_mode_list),
 		.default_mode = s0to1,
@@ -1416,7 +1416,7 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 	},
 	[max11647] = {
 		.bits = 10,
-		.int_vref_mv = 4096,
+		.int_vref_mv = 2048,
 		.mode_list = max11644_mode_list,
 		.num_modes = ARRAY_SIZE(max11644_mode_list),
 		.default_mode = s0to1,
-- 
2.0.4

