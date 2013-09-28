Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1177 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753381Ab3I1Ja5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:57 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Stefan Roese <sr@denx.de>
Subject: [PATCH 24/25] staging:iio:spear_adc: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:56 +0200
Message-Id: <1380360717-26103-24-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 20f2d55..657e01b 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -168,10 +168,9 @@ static int spear_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		scale_mv = (info->vref_external * 1000) >> DATA_BITS;
-		*val =  scale_mv / 1000;
-		*val2 = (scale_mv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = info->vref_external;
+		*val2 = DATA_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
 	return -EINVAL;
-- 
1.8.0

