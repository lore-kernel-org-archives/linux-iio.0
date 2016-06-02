Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35804 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbcFBE2Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 00:28:16 -0400
Date: Wed, 1 Jun 2016 21:28:14 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] iio: adc: ad7793: claim direct mode when writing
 frequency
Message-ID: <20160602042802.GA2910@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode and trying to lock it, but
left a gap where mode could change before the desired operation.
Use iio_device_claim_direct_mode() to guarantee device stays in
direct mode.

Refactor function to clarify look-up followed by lock sequence.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
Changes in v2
Refactored function per reviewers comments
Updated changelog

 drivers/iio/adc/ad7793.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 7b07bb6..a43722f 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -369,13 +369,6 @@ static ssize_t ad7793_write_frequency(struct device *dev,
 	long lval;
 	int i, ret;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
-		return -EBUSY;
-	}
-	mutex_unlock(&indio_dev->mlock);
-
 	ret = kstrtol(buf, 10, &lval);
 	if (ret)
 		return ret;
@@ -383,20 +376,21 @@ static ssize_t ad7793_write_frequency(struct device *dev,
 	if (lval == 0)
 		return -EINVAL;
 
-	ret = -EINVAL;
-
 	for (i = 0; i < 16; i++)
-		if (lval == st->chip_info->sample_freq_avail[i]) {
-			mutex_lock(&indio_dev->mlock);
-			st->mode &= ~AD7793_MODE_RATE(-1);
-			st->mode |= AD7793_MODE_RATE(i);
-			ad_sd_write_reg(&st->sd, AD7793_REG_MODE,
-					 sizeof(st->mode), st->mode);
-			mutex_unlock(&indio_dev->mlock);
-			ret = 0;
-		}
+		if (lval == st->chip_info->sample_freq_avail[i])
+			break;
+	if (i == 16)
+		return -EINVAL;
 
-	return ret ? ret : len;
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+	st->mode &= ~AD7793_MODE_RATE(-1);
+	st->mode |= AD7793_MODE_RATE(i);
+	ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), st->mode);
+	iio_device_release_direct_mode(indio_dev);
+
+	return len;
 }
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-- 
2.1.4

