Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1169 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754538Ab3I1Jay (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:54 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 23/25] staging:iio:ad7746: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:55 +0200
Message-Id: <1380360717-26103-23-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/cdc/ad7746.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 75a533b..862d68d 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -656,20 +656,21 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			/* 8.192pf / 2^24 */
-			*val2 = 488;
 			*val =  0;
+			*val2 = 488;
+			ret = IIO_VAL_INT_PLUS_NANO;
 			break;
 		case IIO_VOLTAGE:
 			/* 1170mV / 2^23 */
-			*val2 = 139475;
-			*val =  0;
+			*val = 1170;
+			*val2 = 23;
+			ret = IIO_VAL_FRACTIONAL_LOG2;
 			break;
 		default:
-			ret =  -EINVAL;
-			goto out;
+			ret = -EINVAL;
+			break;
 		}
 
-		ret = IIO_VAL_INT_PLUS_NANO;
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.8.0

