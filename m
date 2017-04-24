Return-Path: <SRS0=J3Le=4A=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2] iio: inkern: fix endless loop in error path
Date: Mon, 24 Apr 2017 10:57:37 +0200
Message-ID: <1493024257-17378-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

If ret ends up negative, mutex_unlock is called repeatedly in an infinite
loop, which of course is pretty nasty...

Issue found by smatch:
drivers/iio/inkern.c:751 iio_read_avail_channel_raw() error: double unlock 'mutex:&chan->indio_dev->info_exist_lock'

Fixes: 00c5f80c2fad ("iio: inkern: add helpers to query available values from channels")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/inkern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

v1 -> v2 changes:
- Be clear about that there is a real nasty issue and that it isn't only
  about avoiding some insignificant static checker issue.

v1:  https://lkml.org/lkml/2017/4/20/887

Cheers,
peda

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
