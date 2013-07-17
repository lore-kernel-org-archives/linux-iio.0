Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1066 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3GQOoH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:07 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/15] staging:iio:adis16260: Simplify calibscale and caliboffset reading
Date: Wed, 17 Jul 2013 16:44:32 +0200
Message-Id: <1374072279-7140-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All channels for this device have the same number of bits for calibscale and
caliboffset, there is no need to determine it dynamically based on the channel
type. Also there is no locking required since adis_read_reg_16() will take care
of proper locking on its own.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index f060452..c70094f 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -222,7 +222,6 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *adis = iio_priv(indio_dev);
 	int ret;
-	int bits;
 	u8 addr;
 	s16 val16;
 
@@ -263,40 +262,20 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		*val = 250000 / 1453; /* 25 C = 0x00 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			bits = 12;
-			break;
-		default:
-			return -EINVAL;
-		}
-		mutex_lock(&indio_dev->mlock);
 		addr = adis16260_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(adis, addr, &val16);
-		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+		if (ret)
 			return ret;
-		}
-		*val = sign_extend32(val16, bits - 1);
-		mutex_unlock(&indio_dev->mlock);
+
+		*val = sign_extend32(val16, 11);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBSCALE:
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			bits = 12;
-			break;
-		default:
-			return -EINVAL;
-		}
-		mutex_lock(&indio_dev->mlock);
 		addr = adis16260_addresses[chan->scan_index][1];
 		ret = adis_read_reg_16(adis, addr, &val16);
-		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+		if (ret)
 			return ret;
-		}
+
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
1.8.0

