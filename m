Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45983 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752283AbeFDJIq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jun 2018 05:08:46 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so8018488plz.12
        for <linux-iio@vger.kernel.org>; Mon, 04 Jun 2018 02:08:46 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: jic23@kernel.org
Cc: baolin.wang@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, arnd@arndb.de, broonie@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Convert to use timespec64 variables to get a time stamp
Date: Mon,  4 Jun 2018 17:07:39 +0800
Message-Id: <8ab19b1665b51364c1f7e607f9a69a86fe084d0d.1528102909.git.baolin.wang@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The struct timespec is not y2038 safe on 32bit machines, thus this patch
converts to use timespec64 variables and related APIs to get a time stamp
for events etc.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/iio/industrialio-core.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d..8d2b93b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -207,35 +207,35 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
  */
 s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 {
-	struct timespec tp;
+	struct timespec64 tp;
 
 	switch (iio_device_get_clock(indio_dev)) {
 	case CLOCK_REALTIME:
-		ktime_get_real_ts(&tp);
+		ktime_get_real_ts64(&tp);
 		break;
 	case CLOCK_MONOTONIC:
-		ktime_get_ts(&tp);
+		ktime_get_ts64(&tp);
 		break;
 	case CLOCK_MONOTONIC_RAW:
-		getrawmonotonic(&tp);
+		getrawmonotonic64(&tp);
 		break;
 	case CLOCK_REALTIME_COARSE:
-		tp = current_kernel_time();
+		tp = current_kernel_time64();
 		break;
 	case CLOCK_MONOTONIC_COARSE:
-		tp = get_monotonic_coarse();
+		tp = get_monotonic_coarse64();
 		break;
 	case CLOCK_BOOTTIME:
-		get_monotonic_boottime(&tp);
+		get_monotonic_boottime64(&tp);
 		break;
 	case CLOCK_TAI:
-		timekeeping_clocktai(&tp);
+		timekeeping_clocktai64(&tp);
 		break;
 	default:
 		BUG();
 	}
 
-	return timespec_to_ns(&tp);
+	return timespec64_to_ns(&tp);
 }
 EXPORT_SYMBOL(iio_get_time_ns);
 
-- 
1.7.9.5

