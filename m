Return-Path: <SRS0=8i//=E7=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH 1/2] Staging: iio: ade7758: Remove iio_dev mlock
Date: Tue,  6 Feb 2018 01:08:47 +0530
Message-Id: <88eba335f73f931acb1e5d1be63992f8ae0fdc5b.1517845616.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1517845616.git.shreeya.patel23498@gmail.com>
References: <cover.1517845616.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

In the ade7758 file, read raw does not require iio_dev->mlock for
reads. It can run concurrently as resource protection is handled
by buf_lock in read register.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/meter/ade7758_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 7b7ffe5..227dbfc 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -526,9 +526,7 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&indio_dev->mlock);
 		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.7.4
