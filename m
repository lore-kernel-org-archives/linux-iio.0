Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 2/6] IIO-work: meter: ade7758: Fix timing on SPI read accessor functions.
Date: Wed, 11 May 2011 16:26:56 +0200
Message-ID: <1305124020-2526-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
References: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

According to the ADE7758 datasheet the minimum time between read command
(that is, a write to communication register) and data read must not be
less than 4us.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
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
1.6.0.2
