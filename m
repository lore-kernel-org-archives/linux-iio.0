Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] iio:adis16130: Use spi_sync_transfer()
Date: Sat,  5 Oct 2013 09:45:04 +0200
Message-Id: <1380959108-21775-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-1-git-send-email-lars@metafoo.de>
References: <1380959108-21775-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use the spi_sync_transfer() helper function instead of open-coding it. Makes
the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adis16130.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index 9155cf6..445c2ae 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -47,7 +47,6 @@ static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
 {
 	int ret;
 	struct adis16130_state *st = iio_priv(indio_dev);
-	struct spi_message msg;
 	struct spi_transfer xfer = {
 		.tx_buf = st->buf,
 		.rx_buf = st->buf,
@@ -59,10 +58,7 @@ static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
 	st->buf[0] = ADIS16130_CON_RD | reg_addr;
 	st->buf[1] = st->buf[2] = st->buf[3] = 0;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->us, &msg);
-
+	ret = spi_sync_transfer(st->us, &xfer, 1);
 	if (ret == 0)
 		*val = (st->buf[1] << 16) | (st->buf[2] << 8) | st->buf[3];
 	mutex_unlock(&st->buf_lock);
-- 
1.8.0
