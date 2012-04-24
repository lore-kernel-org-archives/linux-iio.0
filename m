Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 01/11] staging:iio:dac:ad5446: Do not exit powerdown when writing a sample
Date: Tue, 24 Apr 2012 18:49:31 +0200
Message-Id: <1335286181-20474-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Both the powerdown mode bits and the sample value are stored in the same
register, so writing a sample while the device is powered down will clear the
power down bits. To avoid this only update the cached value when the device is
powered down.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

----
v1 actually had a small bug in that it would still write to the device's
register when the sample was updated while the device was powered down. This was
not critical since it would send out the powerdown mode again.
---
 drivers/staging/iio/dac/ad5446.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index ec6968b..de796c2 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -272,7 +272,7 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
-	int ret;
+	int ret = 0;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -282,8 +282,10 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 		val <<= chan->scan_type.shift;
 		mutex_lock(&indio_dev->mlock);
 		st->cached_val = val;
-		st->chip_info->store_sample(st, val);
-		ret = spi_sync(st->spi, &st->msg);
+		if (!st->pwr_down) {
+			st->chip_info->store_sample(st, val);
+			ret = spi_sync(st->spi, &st->msg);
+		}
 		mutex_unlock(&indio_dev->mlock);
 		break;
 	default:
-- 
1.7.9.5
