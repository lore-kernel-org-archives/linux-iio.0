Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1068 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753302Ab3I1Jar (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:47 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/25] iio:max1363: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:50 +0200
Message-Id: <1380360717-26103-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/max1363.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index b4bc166..2b34d2f 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -397,7 +397,6 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 	int ret;
-	unsigned long scale_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -406,10 +405,9 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = st->vref_uv >> st->chip_info->bits;
-		*val = scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = st->vref_uv / 1000;
+		*val2 = st->chip_info->bits;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
 		return -EINVAL;
 	}
-- 
1.8.0

