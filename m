Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35858 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbcFAEfv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2016 00:35:51 -0400
Date: Tue, 31 May 2016 21:35:49 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] iio: adc: ad7791: claim direct mode when writing
 frequency
Message-ID: <20160601043541.GA9875@d830.WORKGROUP>
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

 drivers/iio/adc/ad7791.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index cf172d58..1dfe641 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -272,30 +272,22 @@ static ssize_t ad7791_write_frequency(struct device *dev,
 	struct ad7791_state *st = iio_priv(indio_dev);
 	int i, ret;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
-		return -EBUSY;
-	}
-	mutex_unlock(&indio_dev->mlock);
-
-	ret = -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
-		if (sysfs_streq(ad7791_sample_freq_avail[i], buf)) {
-
-			mutex_lock(&indio_dev->mlock);
-			st->filter &= ~AD7791_FILTER_RATE_MASK;
-			st->filter |= i;
-			ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
-					 sizeof(st->filter), st->filter);
-			mutex_unlock(&indio_dev->mlock);
-			ret = 0;
+	for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++)
+		if (sysfs_streq(ad7791_sample_freq_avail[i], buf))
 			break;
-		}
-	}
+	if (i == ARRAY_SIZE(ad7791_sample_freq_avail))
+		return -EINVAL;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+	st->filter &= ~AD7791_FILTER_RATE_MASK;
+	st->filter |= i;
+	ad_sd_write_reg(&st->sd, AD7791_REG_FILTER, sizeof(st->filter),
+			st->filter);
+	iio_device_release_direct_mode(indio_dev);
 
-	return ret ? ret : len;
+	return len;
 }
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-- 
2.1.4

