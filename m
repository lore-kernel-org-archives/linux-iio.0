Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:46863 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbbBDOOi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 09:14:38 -0500
Received: by mail-we0-f175.google.com with SMTP id p10so1989174wes.6
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2015 06:14:37 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] iio:adc:mcp3422 Fix incorrect scales table
Date: Wed,  4 Feb 2015 15:14:26 +0100
Message-Id: <1423059266-18143-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes uncorrect order of mcp3422_scales table, the values
was erroneously transposed.
It removes also an unused array and a wrong comment.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 5167225..b96c636 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -58,20 +58,11 @@
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	}
 
-/* LSB is in nV to eliminate floating point */
-static const u32 rates_to_lsb[] = {1000000, 250000, 62500, 15625};
-
-/*
- *  scales calculated as:
- *  rates_to_lsb[sample_rate] / (1 << pga);
- *  pga is 1 for 0, 2
- */
-
 static const int mcp3422_scales[4][4] = {
-	{ 1000000, 250000, 62500, 15625 },
-	{ 500000 , 125000, 31250, 7812 },
-	{ 250000 , 62500 , 15625, 3906 },
-	{ 125000 , 31250 , 7812 , 1953 } };
+	{ 1000000, 500000, 250000, 125000 },
+	{ 250000 , 125000, 62500 , 31250  },
+	{ 62500  , 31250 , 15625 , 7812   },
+	{ 15625  , 7812  , 3906  , 1953   } };
 
 /* Constant msleep times for data acquisitions */
 static const int mcp3422_read_times[4] = {
-- 
1.9.1

