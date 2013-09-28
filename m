Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1083 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754538Ab3I1Jas (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:48 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 19/25] staging:iio:ad7280a: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:51 +0200
Message-Id: <1380360717-26103-19-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7280a.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index e7191e4..8209fa5 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -783,7 +783,6 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7280_state *st = iio_priv(indio_dev);
-	unsigned int scale_uv;
 	int ret;
 
 	switch (m) {
@@ -804,13 +803,12 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6)
-			scale_uv = (4000 * 1000) >> AD7280A_BITS;
+			*val = 4000;
 		else
-			scale_uv = (5000 * 1000) >> AD7280A_BITS;
+			*val = 5000;
 
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val2 = AD7280A_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 	return -EINVAL;
 }
-- 
1.8.0

