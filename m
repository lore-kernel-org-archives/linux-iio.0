Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-052.synserver.de ([212.40.185.52]:1033 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757778Ab3AIOAo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 09:00:44 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] staging:iio:adis16080: Perform sign extension
Date: Wed,  9 Jan 2013 15:01:13 +0100
Message-Id: <1357740079-12326-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adis16080 reports sample values in twos complement. So we need to perform a
sign extension on the result, otherwise negative values will be reported
incorrectly as large positive values.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
This one should go into 3.8 if possible, the rest of the series is for 3.9
---
 drivers/staging/iio/gyro/adis16080_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 3525a68..149ff99 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -69,7 +69,7 @@ static int adis16080_spi_read(struct iio_dev *indio_dev,
 	ret = spi_read(st->us, st->buf, 2);
 
 	if (ret == 0)
-		*val = ((st->buf[0] & 0xF) << 8) | st->buf[1];
+		*val = sign_extend32(12, ((st->buf[0] & 0xF) << 8) | st->buf[1]);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
-- 
1.8.0

