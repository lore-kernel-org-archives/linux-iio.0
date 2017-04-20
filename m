Return-Path: <SRS0=+/oH=34=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>
Subject: [PATCH] iio: inkern: fix a static checker error
Date: Thu, 20 Apr 2017 23:01:57 +0200
Message-ID: <1492722117-19618-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Avoid this smatch error:
drivers/iio/inkern.c:751 iio_read_avail_channel_raw() error: double unlock 'mutex:&chan->indio_dev->info_exist_lock'

Fixes: 00c5f80c2fad ("iio: inkern: add helpers to query available values from channels")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/inkern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7a13535dc3e9..a3941bade6a7 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -750,11 +750,9 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 err_unlock:
 	mutex_unlock(&chan->indio_dev->info_exist_lock);
 
-	if (ret >= 0 && type != IIO_VAL_INT) {
+	if (ret >= 0 && type != IIO_VAL_INT)
 		/* raw values are assumed to be IIO_VAL_INT */
 		ret = -EINVAL;
-		goto err_unlock;
-	}
 
 	return ret;
 }
-- 
2.1.4
