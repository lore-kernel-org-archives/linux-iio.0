Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:33830 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936523AbcIYLlJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Sep 2016 07:41:09 -0400
From: Brian Masney <masneyb@onstation.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 1/3] staging: iio: isl29018: remove unused variable and defines
Date: Sun, 25 Sep 2016 07:41:05 -0400
Message-Id: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Removes unused variable and associated #defines that was found using
make W=1.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 76d9f74..ad282f1 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -66,16 +66,6 @@
 #define ISL29035_BOUT_SHIFT		0x07
 #define ISL29035_BOUT_MASK		(0x01 << ISL29035_BOUT_SHIFT)
 
-#define ISL29018_INT_TIME_AVAIL		"0.090000 0.005630 0.000351 0.000021"
-#define ISL29023_INT_TIME_AVAIL		"0.090000 0.005600 0.000352 0.000022"
-#define ISL29035_INT_TIME_AVAIL		"0.105000 0.006500 0.000410 0.000025"
-
-static const char * const int_time_avail[] = {
-	ISL29018_INT_TIME_AVAIL,
-	ISL29023_INT_TIME_AVAIL,
-	ISL29035_INT_TIME_AVAIL,
-};
-
 enum isl29018_int_time {
 	ISL29018_INT_TIME_16,
 	ISL29018_INT_TIME_12,
-- 
2.7.4

