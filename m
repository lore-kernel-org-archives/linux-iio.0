Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/12] staging:iio:gyro:adis16130 fix adis16130_spi_read which was never selecting the channel
Date: Fri, 12 Aug 2011 16:55:28 +0100
Message-Id: <1313164538-1769-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adis16130_core.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index c80e908..caf067c 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -75,15 +75,24 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16130_state *st = iio_priv(indio_dev);
+	struct spi_message msg;
+	struct spi_transfer xfer = {
+		.tx_buf = st->buf,
+		.rx_buf = st->buf,
+	};
 
 	mutex_lock(&st->buf_lock);
 
 	st->buf[0] = ADIS16130_CON_RD | reg_addr;
+	st->buf[1] = st->buf[2] = st->buf[3] = 0;
+
 	if (st->mode)
-		ret = spi_read(st->us, st->buf, 4);
+		xfer.len = 4;
 	else
-		ret = spi_read(st->us, st->buf, 3);
-
+		xfer.len = 3;
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(st->us, &msg);
 	if (ret == 0) {
 		if (st->mode)
 			*val = (st->buf[1] << 16) |
-- 
1.7.3.4
