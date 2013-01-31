Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1117 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab3AaO1A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:00 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] staging:iio:adxrs450: Make transfer buffers __be32
Date: Thu, 31 Jan 2013 15:27:49 +0100
Message-Id: <1359642478-9622-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following sparse warnings:

	drivers/staging/iio/gyro/adxrs450_core.c:46:15: warning: cast to restricted __be32
	drivers/staging/iio/gyro/adxrs450_core.c:62:17: warning: cast to restricted __be32
	drivers/staging/iio/gyro/adxrs450_core.c:89:15: warning: cast to restricted __be32
	drivers/staging/iio/gyro/adxrs450_core.c:129:17: warning: cast to restricted __be32
	drivers/staging/iio/gyro/adxrs450_core.c:168:16: warning: cast to restricted __be32

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450.h      | 10 ++---
 drivers/staging/iio/gyro/adxrs450_core.c | 66 +++++++++++++++-----------------
 2 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450.h b/drivers/staging/iio/gyro/adxrs450.h
index f8cf21f..97abea3 100644
--- a/drivers/staging/iio/gyro/adxrs450.h
+++ b/drivers/staging/iio/gyro/adxrs450.h
@@ -4,9 +4,9 @@
 #define ADXRS450_STARTUP_DELAY	50 /* ms */
 
 /* The MSB for the spi commands */
-#define ADXRS450_SENSOR_DATA    0x20
-#define ADXRS450_WRITE_DATA	0x40
-#define ADXRS450_READ_DATA	0x80
+#define ADXRS450_SENSOR_DATA    (0x20 << 24)
+#define ADXRS450_WRITE_DATA	(0x40 << 24)
+#define ADXRS450_READ_DATA	(0x80 << 24)
 
 #define ADXRS450_RATE1	0x00	/* Rate Registers */
 #define ADXRS450_TEMP1	0x02	/* Temperature Registers */
@@ -54,8 +54,8 @@ enum {
 struct adxrs450_state {
 	struct spi_device	*us;
 	struct mutex		buf_lock;
-	u8			tx[ADXRS450_MAX_RX] ____cacheline_aligned;
-	u8			rx[ADXRS450_MAX_TX];
+	__be32			tx ____cacheline_aligned;
+	__be32			rx;
 
 };
 
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 318e8c9..91a2fae 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -36,29 +36,28 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
 {
 	struct spi_message msg;
 	struct adxrs450_state *st = iio_priv(indio_dev);
+	u32 tx;
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
-			.tx_buf = st->tx,
+			.tx_buf = &st->tx,
 			.bits_per_word = 8,
-			.len = 4,
+			.len = sizeof(st->tx),
 			.cs_change = 1,
 		}, {
-			.rx_buf = st->rx,
+			.rx_buf = &st->rx,
 			.bits_per_word = 8,
-			.len = 4,
+			.len = sizeof(st->rx),
 		},
 	};
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADXRS450_READ_DATA | (reg_address >> 7);
-	st->tx[1] = reg_address << 1;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
+	tx = ADXRS450_READ_DATA | (reg_address << 17);
 
-	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
-		st->tx[3]  |= ADXRS450_P;
+	if (!(hweight32(tx) & 1))
+		tx |= ADXRS450_P;
 
+	st->tx = cpu_to_be32(tx);
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
@@ -69,7 +68,7 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
 		goto error_ret;
 	}
 
-	*val = (be32_to_cpu(*(u32 *)st->rx) >> 5) & 0xFFFF;
+	*val = (be32_to_cpu(st->rx) >> 5) & 0xFFFF;
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -88,18 +87,17 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
 				     u16 val)
 {
 	struct adxrs450_state *st = iio_priv(indio_dev);
+	u32 tx;
 	int ret;
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADXRS450_WRITE_DATA | reg_address >> 7;
-	st->tx[1] = reg_address << 1 | val >> 15;
-	st->tx[2] = val >> 7;
-	st->tx[3] = val << 1;
+	tx = ADXRS450_WRITE_DATA | (reg_address << 17) | (val << 1);
 
-	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
-		st->tx[3] |= ADXRS450_P;
+	if (!(hweight32(tx) & 1))
+		tx |= ADXRS450_P;
 
-	ret = spi_write(st->us, st->tx, 4);
+	st->tx = cpu_to_be32(tx);
+	ret = spi_write(st->us, &st->tx, sizeof(st->tx));
 	if (ret)
 		dev_err(&st->us->dev, "problem while writing 16 bit register 0x%02x\n",
 			reg_address);
@@ -120,22 +118,19 @@ static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
-			.tx_buf = st->tx,
+			.tx_buf = &st->tx,
 			.bits_per_word = 8,
-			.len = 4,
+			.len = sizeof(st->tx),
 			.cs_change = 1,
 		}, {
-			.rx_buf = st->rx,
+			.rx_buf = &st->rx,
 			.bits_per_word = 8,
-			.len = 4,
+			.len = sizeof(st->rx),
 		},
 	};
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADXRS450_SENSOR_DATA;
-	st->tx[1] = 0;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
+	st->tx = cpu_to_be32(ADXRS450_SENSOR_DATA);
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
@@ -146,7 +141,7 @@ static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
 		goto error_ret;
 	}
 
-	*val = (be32_to_cpu(*(u32 *)st->rx) >> 10) & 0xFFFF;
+	*val = (be32_to_cpu(st->rx) >> 10) & 0xFFFF;
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -163,20 +158,19 @@ static int adxrs450_spi_initial(struct adxrs450_state *st,
 {
 	struct spi_message msg;
 	int ret;
+	u32 tx;
 	struct spi_transfer xfers = {
-		.tx_buf = st->tx,
-		.rx_buf = st->rx,
+		.tx_buf = &st->tx,
+		.rx_buf = &st->rx,
 		.bits_per_word = 8,
-		.len = 4,
+		.len = sizeof(st->tx),
 	};
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADXRS450_SENSOR_DATA;
-	st->tx[1] = 0;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
+	tx = ADXRS450_SENSOR_DATA;
 	if (chk)
-		st->tx[3] |= (ADXRS450_CHK | ADXRS450_P);
+		tx |= (ADXRS450_CHK | ADXRS450_P);
+	st->tx = cpu_to_be32(tx);
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers, &msg);
 	ret = spi_sync(st->us, &msg);
@@ -185,7 +179,7 @@ static int adxrs450_spi_initial(struct adxrs450_state *st,
 		goto error_ret;
 	}
 
-	*val = be32_to_cpu(*(u32 *)st->rx);
+	*val = be32_to_cpu(st->rx);
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
-- 
1.8.0

