Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] iio:adis16080: Use spi_sync_transfer()
Date: Sat,  5 Oct 2013 09:45:02 +0200
Message-Id: <1380959108-21775-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-1-git-send-email-lars@metafoo.de>
References: <1380959108-21775-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use the spi_sync_transfer() helper function instead of open-coding it. Makes
the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adis16080.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index e9ec022..add5098 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -51,7 +51,6 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
 		u16 addr, int *val)
 {
 	struct adis16080_state *st = iio_priv(indio_dev);
-	struct spi_message m;
 	int ret;
 	struct spi_transfer	t[] = {
 		{
@@ -66,11 +65,7 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
 
 	st->buf = cpu_to_be16(addr | ADIS16080_DIN_WRITE);
 
-	spi_message_init(&m);
-	spi_message_add_tail(&t[0], &m);
-	spi_message_add_tail(&t[1], &m);
-
-	ret = spi_sync(st->us, &m);
+	ret = spi_sync_transfer(st->us, t, ARRAY_SIZE(t));
 	if (ret == 0)
 		*val = sign_extend32(be16_to_cpu(st->buf), 11);
 
-- 
1.8.0
