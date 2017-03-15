Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33843 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdCORIq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 13:08:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so5710108wmg.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Mar 2017 10:08:45 -0700 (PDT)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH] staging: iio: adis16209: Remove mutex_lock() and mutex_unlock() calls
Date: Wed, 15 Mar 2017 19:00:14 +0200
Message-Id: <1489597214-24564-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The function adis16209_read_raw() is safe to be run in parallel.
The call to adis_read_reg_16() is safe since adis_read_reg() uses the
txrx_lock from struct adis to protect simultaneous changes.

Remove mutex.h inclusion since it is no longer needed.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 8ff537f..f8c1fb0 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
@@ -252,17 +251,14 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		mutex_lock(&indio_dev->mlock);
 		addr = adis16209_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
1.9.1

