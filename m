Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1071 "EHLO
	smtp-out-078.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753547Ab2DWRtT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Apr 2012 13:49:19 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] staging:iio:dac:ad5446: Do not exit powerdown when writing a sample
Date: Mon, 23 Apr 2012 19:51:30 +0200
Message-Id: <1335203497-11041-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Both the powerdown mode bits and the sample value are stored in the same
register, so writing a sample while the device is powered down will clear the
power down bits. To avoid this only update the cached value when the device is
powered down.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index ec6968b..0cfe445 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -282,7 +282,8 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 		val <<= chan->scan_type.shift;
 		mutex_lock(&indio_dev->mlock);
 		st->cached_val = val;
-		st->chip_info->store_sample(st, val);
+		if (!st->pwr_down)
+			st->chip_info->store_sample(st, val);
 		ret = spi_sync(st->spi, &st->msg);
 		mutex_unlock(&indio_dev->mlock);
 		break;
-- 
1.7.9.5

