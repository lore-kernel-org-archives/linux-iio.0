Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33466 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCRNgz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Mar 2018 09:36:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id s206so9006622wme.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Mar 2018 06:36:54 -0700 (PDT)
Date: Sun, 18 Mar 2018 14:36:51 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 09/11] staging: iio: ad2s1200: Add scaling factor for
 IIO_ANGL_VEL channel
Message-ID: <02a7cb757f8c61a274ee499d3b458ca09a569917.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521379685.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The sysfs iio ABI states that a unit of radians per second is
expected, but the 12-bit angular velocity register has rps as its unit.
So a fractional scaling factor of approximately 2 * Pi is added to the
angular velocity channel.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 82 ++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 7ee1d9f76dfb..4b97a106012c 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -61,40 +61,69 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 	int ret = 0;
 	u16 vel;
 
-	mutex_lock(&st->lock);
-	gpiod_set_value(st->sample, 0);
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			/*
+			 * 2 * Pi is almost equal to
+			 * 2 * 103993 / 33102 = 103993 / (33102 / 2)
+			 * This fraction is based on OEIS series of
+			 * of nominator/denominator of convergents to Pi
+			 * (A002485 and A002486).
+			 *
+			 * iio_convert_raw_to_processed_unlocked uses integer
+			 * division. This will cause at most 5% error
+			 * (for very small values). But for 99.5% of the values
+			 * it will cause less that 1% error.
+			 */
+			*val = 103993;
+			*val2 = 33102 / 2;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		gpiod_set_value(st->sample, 0);
+
+		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
+		udelay(1);
+		gpiod_set_value(st->sample, 1);
+		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
+
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
 
-	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
-	udelay(1);
-	gpiod_set_value(st->sample, 1);
-	gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
+		vel = be16_to_cpup((__be16 *)st->rx);
+		switch (chan->type) {
+		case IIO_ANGL:
+			*val = vel >> 4;
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_ANGL_VEL:
+			*val = sign_extend32((s16)vel >> 4, 11);
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0) {
+		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
+		udelay(1);
 		mutex_unlock(&st->lock);
-		return ret;
-	}
 
-	vel = be16_to_cpup((__be16 *)st->rx);
-	switch (chan->type) {
-	case IIO_ANGL:
-		*val = vel >> 4;
-		ret = IIO_VAL_INT;
-		break;
-	case IIO_ANGL_VEL:
-		*val = sign_extend32((s16)vel >> 4, 11);
-		ret = IIO_VAL_INT;
-		break;
+		return ret;
 	default:
-		ret = -EINVAL;
 		break;
 	}
 
-	/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
-	udelay(1);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return -EINVAL;
 }
 
 static const struct iio_chan_spec ad2s1200_channels[] = {
@@ -108,6 +137,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 	}
 };
 
-- 
2.16.2

