Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55760 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3IKKim (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Sep 2013 06:38:42 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so9007957pdi.41
        for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2013 03:38:42 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 1/5] iio: gyro: adis16130: Remove redundant break
Date: Wed, 11 Sep 2013 15:50:25 +0530
Message-Id: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'break' after return is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adis16130.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index ac66fc1..9155cf6 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -103,7 +103,6 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -115,7 +114,6 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		break;
 	}
 
 	return -EINVAL;
-- 
1.7.9.5

