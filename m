Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/25] staging:iio:gyro:adxrs450 make more use of spi_read and spi_write.
Date: Fri,  1 Jul 2011 11:10:55 +0100
Message-Id: <1309515076-12323-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This needs confirmation that the devices is happy if another part is
talked to in between the request for a register and the read back.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |   63 ++++++++----------------------
 1 files changed, 17 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 97a07f9..967a772 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -35,21 +35,8 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
 				    u8 reg_address,
 				    u16 *val)
 {
-	struct spi_message msg;
 	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 4,
-			.cs_change = 1,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 4,
-		},
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADXRS450_READ_DATA | (reg_address >> 7);
@@ -60,10 +47,13 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
 	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
 		st->tx[3]  |= ADXRS450_P;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 4);
+	if (ret) {
+		dev_err(&st->us->dev, "problem while reading 16 bit register 0x%02x\n",
+			reg_address);
+		goto error_ret;
+	}
+	ret = spi_read(st->us, st->rx, 4);
 	if (ret) {
 		dev_err(&st->us->dev, "problem while reading 16 bit register 0x%02x\n",
 				reg_address);
@@ -88,15 +78,8 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
 				     u8 reg_address,
 				     u16 val)
 {
-	struct spi_message msg;
 	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
-	struct spi_transfer xfers = {
-		.tx_buf = st->tx,
-		.rx_buf = st->rx,
-		.bits_per_word = 8,
-		.len = 4,
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADXRS450_WRITE_DATA | reg_address >> 7;
@@ -105,14 +88,12 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
 	st->tx[3] = val << 1;
 
 	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
-		st->tx[3]  |= ADXRS450_P;
+		st->tx[3] |= ADXRS450_P;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers, &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 4);
 	if (ret)
 		dev_err(&st->us->dev, "problem while writing 16 bit register 0x%02x\n",
-				reg_address);
+			reg_address);
 	msleep(1); /* enforce sequential transfer delay 0.1ms */
 	mutex_unlock(&st->buf_lock);
 	return ret;
@@ -125,21 +106,8 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
  **/
 static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
 {
-	struct spi_message msg;
 	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 4,
-			.cs_change = 1,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 4,
-		},
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADXRS450_SENSOR_DATA;
@@ -147,10 +115,13 @@ static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
 	st->tx[2] = 0;
 	st->tx[3] = 0;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 4);
+	if (ret) {
+		dev_err(&st->us->dev, "Problem while reading sensor data\n");
+		goto error_ret;
+	}
+
+	ret = spi_read(st->us, st->rx, 4);
 	if (ret) {
 		dev_err(&st->us->dev, "Problem while reading sensor data\n");
 		goto error_ret;
-- 
1.7.3.4
