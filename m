Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/8] staging:iio:accel:adis16204 fix bug in channel modifier handling
Date: Wed, 30 May 2012 20:41:03 +0100
Message-Id: <1338406866-3833-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-1-git-send-email-jic23@kernel.org>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Will result in the correct scale value for the x axis.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16204_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 5c02bc6..a36135d 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -362,7 +362,7 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			*val = 0;
-			if (chan->channel == 'x')
+			if (chan->channel2 == IIO_CHAN_MOD_X)
 				*val2 = 17125;
 			else
 				*val2 = 8407;
-- 
1.7.10.2
