Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-191.synserver.de ([212.40.185.191]:1103 "EHLO
	smtp-out-191.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab2KEJ5G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2012 04:57:06 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] staging:iio:ad7887: Use passed in chan spec in ad7887_read_raw
Date: Mon,  5 Nov 2012 10:56:45 +0100
Message-Id: <1352109406-7206-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1352109406-7206-1-git-send-email-lars@metafoo.de>
References: <1352109406-7206-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the passed in chan spec in ad7887_read_raw instead of alawys using the first
chan spec entry from the chip info data. Since all channels have the same shift
and realbits from a functional point of view it does not matter which chan spec
is used, but the patch makes the a bit more clear.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7887.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.c b/drivers/staging/iio/adc/ad7887.c
index 3ac0c30..72cfe19 100644
--- a/drivers/staging/iio/adc/ad7887.c
+++ b/drivers/staging/iio/adc/ad7887.c
@@ -177,8 +177,8 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 
 		if (ret < 0)
 			return ret;
-		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
-			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
+		*val = ret >> chan->scan_type.shift;
+		*val &= RES_MASK(chan->scan_type.realbits);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->reg) {
@@ -190,7 +190,7 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 			*val = st->chip_info->int_vref_mv;
 		}
 
-		*val2 = st->chip_info->channel[0].scan_type.realbits;
+		*val2 = chan->scan_type.realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
-- 
1.8.0

