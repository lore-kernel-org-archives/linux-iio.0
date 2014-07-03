Return-Path: <spk.linux@gmail.com>
Sender: Sachin Kamat <spk.linux@gmail.com>
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	spk.linux@gmail.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] iio: adis16400: Remove unused variable
Date: Thu,  3 Jul 2014 12:08:01 +0530
Message-Id: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

'rx' is not used in this function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_buffer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
index f2cf829..6e727ff 100644
--- a/drivers/iio/imu/adis16400_buffer.c
+++ b/drivers/iio/imu/adis16400_buffer.c
@@ -18,7 +18,7 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
-	uint16_t *tx, *rx;
+	uint16_t *tx;
 
 	if (st->variant->flags & ADIS16400_NO_BURST)
 		return adis_update_scan_mode(indio_dev, scan_mask);
@@ -35,7 +35,6 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 	if (!adis->buffer)
 		return -ENOMEM;
 
-	rx = adis->buffer;
 	tx = adis->buffer + indio_dev->scan_bytes;
 
 	tx[0] = ADIS_READ_REG(ADIS16400_GLOB_CMD);
-- 
1.7.9.5
