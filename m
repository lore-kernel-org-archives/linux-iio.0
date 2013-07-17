Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1061 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab3GQOoA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:00 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/15] staging:iio:adis16260: Fix reading calibscale
Date: Wed, 17 Jul 2013 16:44:25 +0200
Message-Id: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Return the actual value read from the device and not just the mask.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 620d63f..0b34492 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -223,7 +223,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
-		*val = (1 << bits) - 1;
+		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	}
-- 
1.8.0

