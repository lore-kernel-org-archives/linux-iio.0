Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-168.synserver.de ([212.40.185.168]:1070 "EHLO
	smtp-out-168.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934850AbbEOPSp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2015 11:18:45 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Paul Cercueil <paul.cercueil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] iio: adis16400: Fix burst mode
Date: Fri, 15 May 2015 17:18:37 +0200
Message-Id: <1431703118-32676-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1431703118-32676-1-git-send-email-lars@metafoo.de>
References: <1431703118-32676-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Paul Cercueil <paul.cercueil@analog.com>

There are a few issues with the burst mode support. For one we don't setup
the rx buffer, so the buffer will never be filled and all samples will read
as the zero. Furthermore the tx buffer has the wrong type, which means the
driver sends the wrong command and not the right data is returned.

The final issue is that in burst mode all channels are transferred. Hence
the length of the transfer length should be the number of hardware
channels * 2 bytes. Currently the driver uses indio_dev->scan_bytes for
this. But if the timestamp channel is enabled the scan_bytes will be larger
than the burst length. Fix this by just calculating the burst length based
on the number of hardware channels.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Fixes: 5eda3550a3cc ("staging:iio:adis16400: Preallocate transfer message")
---
 drivers/iio/imu/adis16400_buffer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
index 6e727ff..629ae84 100644
--- a/drivers/iio/imu/adis16400_buffer.c
+++ b/drivers/iio/imu/adis16400_buffer.c
@@ -18,7 +18,8 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
-	uint16_t *tx;
+	unsigned int burst_length;
+	u8 *tx;
 
 	if (st->variant->flags & ADIS16400_NO_BURST)
 		return adis_update_scan_mode(indio_dev, scan_mask);
@@ -26,26 +27,27 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 	kfree(adis->xfer);
 	kfree(adis->buffer);
 
+	/* All but the timestamp channel */
+	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
+
 	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
 	if (!adis->xfer)
 		return -ENOMEM;
 
-	adis->buffer = kzalloc(indio_dev->scan_bytes + sizeof(u16),
-		GFP_KERNEL);
+	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
 	if (!adis->buffer)
 		return -ENOMEM;
 
-	tx = adis->buffer + indio_dev->scan_bytes;
-
+	tx = adis->buffer + burst_length;
 	tx[0] = ADIS_READ_REG(ADIS16400_GLOB_CMD);
 	tx[1] = 0;
 
 	adis->xfer[0].tx_buf = tx;
 	adis->xfer[0].bits_per_word = 8;
 	adis->xfer[0].len = 2;
-	adis->xfer[1].tx_buf = tx;
+	adis->xfer[1].rx_buf = adis->buffer;
 	adis->xfer[1].bits_per_word = 8;
-	adis->xfer[1].len = indio_dev->scan_bytes;
+	adis->xfer[1].len = burst_length;
 
 	spi_message_init(&adis->msg);
 	spi_message_add_tail(&adis->xfer[0], &adis->msg);
-- 
1.8.0

