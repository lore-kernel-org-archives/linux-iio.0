Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34488 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbcCATEE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2016 14:04:04 -0500
From: Alison Schofield <amsfield22@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: [RFC PATCH 2/2] staging: iio: adc7192: use iio_{claim|release}_direct_mode()
Date: Tue,  1 Mar 2016 11:03:52 -0800
Message-Id: <2345ebfd89c408206e623a8b29072dafa6041dff.1456794364.git.amsfield22@gmail.com>
In-Reply-To: <cover.1456794364.git.amsfield22@gmail.com>
References: <cover.1456794364.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode with
iio_{claim|release}_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index f843f19..401ec91 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -349,11 +349,9 @@ static ssize_t ad7192_write_frequency(struct device *dev,
 	if (lval == 0)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+	ret = iio_claim_direct_mode(indio_dev);
+	if (ret)
 		return -EBUSY;
-	}
 
 	div = st->mclk / (lval * st->f_order * 1024);
 	if (div < 1 || div > 1023) {
@@ -366,7 +364,7 @@ static ssize_t ad7192_write_frequency(struct device *dev,
 	ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	iio_release_direct_mode(indio_dev);
 
 	return ret ? ret : len;
 }
@@ -434,11 +432,9 @@ static ssize_t ad7192_set(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+	ret = iio_claim_direct_mode(indio_dev);
+	if (ret)
 		return -EBUSY;
-	}
 
 	switch ((u32)this_attr->address) {
 	case AD7192_REG_GPOCON:
@@ -461,7 +457,7 @@ static ssize_t ad7192_set(struct device *dev,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&indio_dev->mlock);
+	iio_release_direct_mode(indio_dev);
 
 	return ret ? ret : len;
 }
@@ -555,11 +551,9 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	int ret, i;
 	unsigned int tmp;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+	ret = iio_claim_direct_mode(indio_dev);
+	if (ret)
 		return -EBUSY;
-	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -582,7 +576,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&indio_dev->mlock);
+	iio_release_direct_mode(indio_dev);
 
 	return ret;
 }
-- 
2.1.4

