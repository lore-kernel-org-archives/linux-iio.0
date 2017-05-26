Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:39848 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1948807AbdEZWxP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 May 2017 18:53:15 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] staging: iio: ad7152: Fix deadlock in ad7152_write_raw_samp_freq()
Date: Sat, 27 May 2017 01:53:04 +0300
Message-Id: <1495839184-28468-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ad7152_write_raw_samp_freq() is called by ad7152_write_raw() with
chip->state_lock held. So, there is unavoidable deadlock when
ad7152_write_raw_samp_freq() locks the mutex itself.

The patch removes unneeded locking.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/staging/iio/cdc/ad7152.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index dc6ecd824365..ff10d1f0a7e4 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -231,16 +231,12 @@ static int ad7152_write_raw_samp_freq(struct device *dev, int val)
 	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
 		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
 
-	mutex_lock(&chip->state_lock);
 	ret = i2c_smbus_write_byte_data(chip->client,
 					AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
-	if (ret < 0) {
-		mutex_unlock(&chip->state_lock);
+	if (ret < 0)
 		return ret;
-	}
 
 	chip->filter_rate_setup = i;
-	mutex_unlock(&chip->state_lock);
 
 	return ret;
 }
-- 
2.7.4

