Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35377 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbbFTDoC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jun 2015 23:44:02 -0400
Received: by pacyx8 with SMTP id yx8so97038260pac.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2015 20:44:02 -0700 (PDT)
From: Tan Nguyen <tan.nqd@gmail.com>
To: lars@metafoo.de
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio/accel: fixed 1 coding style problem
Date: Sat, 20 Jun 2015 10:43:52 +0700
Message-Id: <1434771832-13305-1-git-send-email-tan.nqd@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Break line to fix "line over 80 characters" style problem.

Signed-off-by: Tan Nguyen <tan.nqd@gmail.com>
---
 drivers/staging/iio/accel/adis16220_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index e46a91c..60d9af4 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -387,7 +387,8 @@ static const struct iio_info adis16220_info = {
 };
 
 static const char * const adis16220_status_error_msgs[] = {
-	[ADIS16220_DIAG_STAT_VIOLATION_BIT] = "Capture period violation/interruption",
+	[ADIS16220_DIAG_STAT_VIOLATION_BIT] =
+				"Capture period violation/interruption",
 	[ADIS16220_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
 	[ADIS16220_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
 	[ADIS16220_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
