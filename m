Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1125 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754538Ab3I1Jat (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:49 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 20/25] staging:iio:ad7606: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:52 +0200
Message-Id: <1380360717-26103-20-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index f042027..2083673 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -85,7 +85,6 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int scale_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -101,11 +100,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		*val = (short) ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (st->range * 1000 * 2)
-			>> st->chip_info->channels[0].scan_type.realbits;
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = st->range * 2;
+		*val2 = st->chip_info->channels[0].scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 	return -EINVAL;
 }
-- 
1.8.0

