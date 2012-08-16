Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH 2/3] iio: use IIO_CHAN_INFO_RAW rather than 0
Date: Thu, 16 Aug 2012 07:39:29 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EEFD76@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

(a) For better readability, replace 0 with IIO_CHAN_INFO_RAW.
(b) Make same line-format as other apis()
    : iio_read_channel_scale() and iio_read_channel_offset()

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/inkern.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index bd09245..5103337 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -239,8 +239,10 @@ int iio_read_channel_raw(struct iio_channel *chan, int=
 *val)
 		goto err_unlock;
 	}
=20
-	ret =3D chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
-					      val, &val2, 0);
+	ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
+					      chan->channel,
+					      val, &val2,
+					      IIO_CHAN_INFO_RAW);
 err_unlock:
 	mutex_unlock(&chan->indio_dev->info_exist_lock);
=20
--=20
1.7.2.5


Best Regards,
Milo
