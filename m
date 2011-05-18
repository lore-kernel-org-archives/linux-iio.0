Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54080 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933238Ab1ERNkH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:07 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 074/111] staging:iio:meter:ade7758: Fix timing on SPI read accessor functions.
Date: Wed, 18 May 2011 14:42:04 +0100
Message-Id: <1305726161-5606-75-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

According to the ADE7758 datasheet the minimum time between read command
(that is, a write to communication register) and data read must not be
less than 4us.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7758_core.c |   43 +++++++++++++++++++++++-------
 1 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index c9956c4..8cfb617 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -100,7 +100,7 @@ static int ade7758_spi_write_reg_24(struct device *dev,
 	return ret;
 }
 
-static int ade7758_spi_read_reg_8(struct device *dev,
+int ade7758_spi_read_reg_8(struct device *dev,
 		u8 reg_address,
 		u8 *val)
 {
@@ -111,9 +111,15 @@ static int ade7758_spi_read_reg_8(struct device *dev,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 1,
+			.delay_usecs = 4,
+		},
+		{
+			.tx_buf = &st->tx[1],
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
-			.len = 2,
+			.len = 1,
 		},
 	};
 
@@ -122,14 +128,15 @@ static int ade7758_spi_read_reg_8(struct device *dev,
 	st->tx[1] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->us, &msg);
 	if (ret) {
 		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = st->rx[1];
+	*val = st->rx[0];
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -147,26 +154,35 @@ static int ade7758_spi_read_reg_16(struct device *dev,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 1,
+			.delay_usecs = 4,
+		},
+		{
+			.tx_buf = &st->tx[1],
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
-			.len = 3,
+			.len = 2,
 		},
 	};
 
+
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7758_READ_REG(reg_address);
 	st->tx[1] = 0;
 	st->tx[2] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->us, &msg);
 	if (ret) {
 		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = (st->rx[1] << 8) | st->rx[2];
+
+	*val = (st->rx[0] << 8) | st->rx[1];
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -184,9 +200,15 @@ static int ade7758_spi_read_reg_24(struct device *dev,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 1,
+			.delay_usecs = 4,
+		},
+		{
+			.tx_buf = &st->tx[1],
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
-			.len = 4,
+			.len = 3,
 		},
 	};
 
@@ -197,14 +219,15 @@ static int ade7758_spi_read_reg_24(struct device *dev,
 	st->tx[3] = 0;
 
 	spi_message_init(&msg);
-	spi_message_add_tail(xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->us, &msg);
 	if (ret) {
 		dev_err(&st->us->dev, "problem when reading 24 bit register 0x%02X",
 				reg_address);
 		goto error_ret;
 	}
-	*val = (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
-- 
1.7.3.4

