Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39421 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbeDVWED (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2018 18:04:03 -0400
Date: Mon, 23 Apr 2018 00:03:59 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v3 6/9] staging: iio: ad2s1200: Add scaling factor for
 angular velocity channel
Message-ID: <803058d8b119451a193c556866ffbb291ec83bcb.1524432236.git.davidjulianveenstra@gmail.com>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524432236.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The sysfs iio ABI states radians per second is expected as the unit for
angular velocity, but the 12-bit angular velocity register has rps
as its unit. So a scaling factor of approximately 2 * Pi is
added to the angular velocity channel.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v3:
 - A decimal approximation of the scale is used, instead
   of a fractional approximation.
 - Remove unneeded explanation of iio_convert_raw_to_processed.

 drivers/staging/iio/resolver/ad2s1200.c | 71 +++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 3c7163610ff6..3e1696e52c38 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -57,37 +57,55 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 	struct ad2s1200_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	mutex_lock(&st->lock);
-	gpiod_set_value(st->sample, 0);
-
-	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
-	udelay(1);
-	gpiod_set_value(st->sample, 1);
-	gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
-
-	ret = spi_read(st->sdev, &st->rx, 2);
-	if (ret < 0) {
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			/* 2 * Pi ~= 6.283185 */
+			*val = 6;
+			*val2 = 283185;
+			return IIO_VAL_INT_PLUS_MICRO;
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
+		ret = spi_read(st->sdev, &st->rx, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		switch (chan->type) {
+		case IIO_ANGL:
+			*val = be16_to_cpup(&st->rx) >> 4;
+			break;
+		case IIO_ANGL_VEL:
+			*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
+			break;
+		default:
+			mutex_unlock(&st->lock);
+			return -EINVAL;
+		}
+
+		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
+		udelay(1);
 		mutex_unlock(&st->lock);
-		return ret;
-	}
 
-	switch (chan->type) {
-	case IIO_ANGL:
-		*val = be16_to_cpup(&st->rx) >> 4;
-		break;
-	case IIO_ANGL_VEL:
-		*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
-		break;
+		return IIO_VAL_INT;
 	default:
-		mutex_unlock(&st->lock);
-		return -EINVAL;
+		break;
 	}
 
-	/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
-	udelay(1);
-	mutex_unlock(&st->lock);
-
-	return IIO_VAL_INT;
+	return -EINVAL;
 }
 
 static const struct iio_chan_spec ad2s1200_channels[] = {
@@ -101,6 +119,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 	}
 };
 
-- 
2.16.2

