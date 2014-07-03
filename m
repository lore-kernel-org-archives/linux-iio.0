Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50156 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbaGCGlq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jul 2014 02:41:46 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so13918210pad.37
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2014 23:41:46 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, spk.linux@gmail.com,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 3/5] iio: ad5504: Remove redundant variable
Date: Thu,  3 Jul 2014 12:08:03 +0530
Message-Id: <1404369485-1903-3-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

By re-arranging the code, 'ret' can be removed from this
function.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/iio/dac/ad5504.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index c917dd2..581ec14 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -125,7 +125,6 @@ static int ad5504_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -134,10 +133,8 @@ static int ad5504_write_raw(struct iio_dev *indio_dev,
 
 		return ad5504_spi_write(st, chan->address, val);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static const char * const ad5504_powerdown_modes[] = {
-- 
1.7.9.5

