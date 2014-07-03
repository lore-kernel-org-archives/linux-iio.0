Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57399 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaGCGln (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jul 2014 02:41:43 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so13914400pab.16
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2014 23:41:43 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, spk.linux@gmail.com,
	Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/5] iio: ad5624r_spi: Remove redundant variable
Date: Thu,  3 Jul 2014 12:08:02 +0530
Message-Id: <1404369485-1903-2-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

By re-arranging the code, 'ret' can be removed from this
function.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Barry Song <21cnbao@gmail.com>
---
 drivers/iio/dac/ad5624r_spi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index e8199cc..61bb9d4 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -67,7 +67,6 @@ static int ad5624r_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -79,10 +78,8 @@ static int ad5624r_write_raw(struct iio_dev *indio_dev,
 				chan->address, val,
 				chan->scan_type.shift);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static const char * const ad5624r_powerdown_modes[] = {
-- 
1.7.9.5

