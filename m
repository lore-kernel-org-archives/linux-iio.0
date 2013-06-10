Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:adis16130: Fix sample reading
Date: Mon, 10 Jun 2013 16:00:13 +0200
Message-Id: <1370872815-14386-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1370872815-14386-1-git-send-email-lars@metafoo.de>
References: <1370872815-14386-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The driver first does a proper read of the data register, but right after that
it does a spi_read, which will overwrite the initial result.

It looks as if the extra spi_read was accidentally introduced in commit
a5e7363ca ("staging:iio:gyro:adis16130 drop control of adc resolution."), quite
likely due to a bad rebase.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16130_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 5288635..2537f59 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -62,7 +62,6 @@ static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
 	ret = spi_sync(st->us, &msg);
-	ret = spi_read(st->us, st->buf, 4);
 
 	if (ret == 0)
 		*val = (st->buf[1] << 16) | (st->buf[2] << 8) | st->buf[3];
-- 
1.8.0
