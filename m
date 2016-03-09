Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33808 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbcCITat (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 14:30:49 -0500
From: Alison Schofield <amsfield22@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: [RFC PATCH v2 2/2] staging: iio: ad7192: use iio_device_{claim|release}_direct_mode()
Date: Wed,  9 Mar 2016 11:30:43 -0800
Message-Id: <dd3f346d97cfb11f4d18e44eb67309c889639ba7.1457549841.git.amsfield22@gmail.com>
In-Reply-To: <cover.1457549841.git.amsfield22@gmail.com>
References: <cover.1457549841.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode with
iio_device_{claim|release}_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index f843f19..94a2e06 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -349,11 +349,9 @@ static ssize_t ad7192_write_frequency(struct device *dev,
 	if (lval == 0)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
 		return -EBUSY;
-	}
 
 	div = st->mclk / (lval * st->f_order * 1024);
 	if (div < 1 || div > 1023) {
@@ -366,7 +364,7 @@ static ssize_t ad7192_write_frequency(struct device *dev,
 	ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret ? ret : len;
 }
@@ -434,11 +432,9 @@ static ssize_t ad7192_set(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
 		return -EBUSY;
-	}
 
 	switch ((u32)this_attr->address) {
 	case AD7192_REG_GPOCON:
@@ -461,7 +457,7 @@ static ssize_t ad7192_set(struct device *dev,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&indio_dev->mlock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret ? ret : len;
 }
@@ -555,11 +551,9 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	int ret, i;
 	unsigned int tmp;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
 		return -EBUSY;
-	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -582,7 +576,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&indio_dev->mlock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
-- 
2.1.4

