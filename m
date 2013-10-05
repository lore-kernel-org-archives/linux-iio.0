Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-061.synserver.de ([212.40.185.61]:1029 "EHLO
	smtp-out-061.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab3JEHnS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 03:43:18 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] iio:ad5449: Use spi_sync_transfer()
Date: Sat,  5 Oct 2013 09:45:01 +0200
Message-Id: <1380959108-21775-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the spi_sync_transfer() helper function instead of open-coding it. Makes
the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5449.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index fff7d07..82e208f 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -101,7 +101,6 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
 {
 	struct ad5449 *st = iio_priv(indio_dev);
 	int ret;
-	struct spi_message msg;
 	struct spi_transfer t[] = {
 		{
 			.tx_buf = &st->data[0],
@@ -114,15 +113,11 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
 		},
 	};
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&t[0], &msg);
-	spi_message_add_tail(&t[1], &msg);
-
 	mutex_lock(&indio_dev->mlock);
 	st->data[0] = cpu_to_be16(addr << 12);
 	st->data[1] = cpu_to_be16(AD5449_CMD_NOOP);
 
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
 	if (ret < 0)
 		goto out_unlock;
 
-- 
1.8.0

