Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-061.synserver.de ([212.40.185.61]:1072 "EHLO
	smtp-out-061.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3JEHnV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 03:43:21 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] staging:iio:ad9852: Use spi_sync_transfer()
Date: Sat,  5 Oct 2013 09:45:06 +0200
Message-Id: <1380959108-21775-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-1-git-send-email-lars@metafoo.de>
References: <1380959108-21775-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the spi_sync_transfer() helper function instead of open-coding it. Makes
the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/frequency/ad9852.c | 45 +++++++++-------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
index 4be2cf8..11e4367 100644
--- a/drivers/staging/iio/frequency/ad9852.c
+++ b/drivers/staging/iio/frequency/ad9852.c
@@ -67,7 +67,6 @@ static ssize_t ad9852_set_parameter(struct device *dev,
 					const char *buf,
 					size_t len)
 {
-	struct spi_message msg;
 	struct spi_transfer xfer;
 	int ret;
 	struct ad9852_config *config = (struct ad9852_config *)buf;
@@ -78,99 +77,77 @@ static ssize_t ad9852_set_parameter(struct device *dev,
 	xfer.tx_buf = &config->phajst0[0];
 	mutex_lock(&st->lock);
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 3;
 	xfer.tx_buf = &config->phajst1[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 6;
 	xfer.tx_buf = &config->fretun1[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 6;
 	xfer.tx_buf = &config->fretun2[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 6;
 	xfer.tx_buf = &config->dltafre[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 5;
 	xfer.tx_buf = &config->updtclk[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 4;
 	xfer.tx_buf = &config->ramprat[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 5;
 	xfer.tx_buf = &config->control[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 3;
 	xfer.tx_buf = &config->outpskm[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 2;
 	xfer.tx_buf = &config->outpskr[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 
 	xfer.len = 3;
 	xfer.tx_buf = &config->daccntl[0];
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret)
 		goto error_ret;
 error_ret:
-- 
1.8.0

