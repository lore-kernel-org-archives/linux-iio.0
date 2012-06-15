Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:adis16400: Fix ADIS16300 temperature address
Date: Fri, 15 Jun 2012 18:11:50 +0200
Message-Id: <1339776712-26059-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1339776712-26059-1-git-send-email-lars@metafoo.de>
References: <1339776712-26059-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The ADIS16300 uses the same address for the temperature register as the
ADIS16350 and not the same as the ADIS16400.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/imu/adis16400_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 1f6bd85..1c9931e 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -946,7 +946,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = temp,
+		.address = temp0,
 		.scan_index = ADIS16400_SCAN_TEMP,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
-- 
1.7.10
