Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32804 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcEXTQ7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 15:16:59 -0400
Date: Tue, 24 May 2016 12:16:57 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iio: adc: ad7791: claim direct mode when writing
 frequency
Message-ID: <b115a245427767bd4c2fd4242b7ee04a243008b3.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1464115008.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode and trying to lock it, but
left a gap where mode could change before the desired operation.
Use iio_device_claim_direct_mode() to guarantee device stays in
direct mode.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/adc/ad7791.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index cf172d58..f7edacc 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -272,24 +272,17 @@ static ssize_t ad7791_write_frequency(struct device *dev,
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
 	for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
 		if (sysfs_streq(ad7791_sample_freq_avail[i], buf)) {
 
-			mutex_lock(&indio_dev->mlock);
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
 			st->filter &= ~AD7791_FILTER_RATE_MASK;
 			st->filter |= i;
 			ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
 					 sizeof(st->filter), st->filter);
-			mutex_unlock(&indio_dev->mlock);
+			iio_device_release_direct_mode(indio_dev);
 			ret = 0;
 			break;
 		}
-- 
2.1.4

