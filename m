Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] staging:iio:adis16220: Use spi_sync_transfer()
Date: Sat,  5 Oct 2013 09:45:05 +0200
Message-Id: <1380959108-21775-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-1-git-send-email-lars@metafoo.de>
References: <1380959108-21775-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use the spi_sync_transfer() helper function instead of open-coding it. Makes
the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16220_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 5c28961..4c9364b 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -102,7 +102,6 @@ static ssize_t adis16220_capture_buffer_read(struct iio_dev *indio_dev,
 					int addr)
 {
 	struct adis16220_state *st = iio_priv(indio_dev);
-	struct spi_message msg;
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -147,10 +146,7 @@ static ssize_t adis16220_capture_buffer_read(struct iio_dev *indio_dev,
 	}
 	xfers[1].len = count;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->adis.spi, &msg);
+	ret = spi_sync_transfer(st->adis.spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 
 		mutex_unlock(&st->buf_lock);
-- 
1.8.0
