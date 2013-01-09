Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-052.synserver.de ([212.40.185.52]:1086 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757811Ab3AIOAs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 09:00:48 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] staging:iio:adis16080: Remove unnecessary lock
Date: Wed,  9 Jan 2013 15:01:17 +0100
Message-Id: <1357740079-12326-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1357740079-12326-1-git-send-email-lars@metafoo.de>
References: <1357740079-12326-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All sections in which the transfer buffer is accessed are already protected by
the IIO device's mlock. So we do not need the extra mutex protecting the buffer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16080_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 6ff9ffc..55ffe39 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -33,11 +33,9 @@
  * struct adis16080_state - device instance specific data
  * @us:			actual spi_device to write data
  * @buf:		transmit or receive buffer
- * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16080_state {
 	struct spi_device		*us;
-	struct mutex			buf_lock;
 
 	__be16 buf ____cacheline_aligned;
 };
@@ -59,7 +57,6 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
 		},
 	};
 
-	mutex_lock(&st->buf_lock);
 	st->buf = cpu_to_be16(addr | ADIS16080_DIN_WRITE);
 
 	spi_message_init(&m);
@@ -69,7 +66,6 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
 	ret = spi_sync(st->us, &m);
 	if (ret == 0)
 		*val = sign_extend32(12, be16_to_cpu(st->buf));
-	mutex_unlock(&st->buf_lock);
 
 	return ret;
 }
@@ -144,7 +140,6 @@ static int adis16080_probe(struct spi_device *spi)
 
 	/* Allocate the comms buffers */
 	st->us = spi;
-	mutex_init(&st->buf_lock);
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->channels = adis16080_channels;
-- 
1.8.0

