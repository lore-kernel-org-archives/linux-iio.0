Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 1/6] IIO: GYRO: ADXRS450: Don't issue two messages, use two transfers
Date: Fri, 29 Apr 2011 12:58:36 +0200
Message-ID: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Don't issue the same message twice, use two transfers and group them together

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |   58 ++++++++++++++---------------
 1 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index dcd88ff..a1a71b7 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -40,29 +40,28 @@ static int adxrs450_spi_read_reg_16(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adxrs450_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers = {
-		.tx_buf = st->tx,
-		.rx_buf = st->rx,
-		.bits_per_word = 8,
-		.len = 4,
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 4,
+		},
 	};
-	/* Needs to send the command twice to get the wanted value */
+
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADXRS450_READ_DATA | reg_address >> 7;
+	st->tx[0] = ADXRS450_READ_DATA | (reg_address >> 7);
 	st->tx[1] = reg_address << 1;
 	st->tx[2] = 0;
 	st->tx[3] = 0;
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
-		dev_err(&st->us->dev, "problem while reading 16 bit register 0x%02x\n",
-				reg_address);
-		goto error_ret;
-	}

 	spi_message_init(&msg);
-	spi_message_add_tail(&xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->us, &msg);
 	if (ret) {
 		dev_err(&st->us->dev, "problem while reading 16 bit register 0x%02x\n",
@@ -125,11 +124,17 @@ static int adxrs450_spi_sensor_data(struct device *dev, u16 *val)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adxrs450_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers = {
-		.tx_buf = st->tx,
-		.rx_buf = st->rx,
-		.bits_per_word = 8,
-		.len = 4,
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx,
+			.bits_per_word = 8,
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.rx_buf = st->rx,
+			.bits_per_word = 8,
+			.len = 4,
+		},
 	};

 	mutex_lock(&st->buf_lock);
@@ -139,15 +144,8 @@ static int adxrs450_spi_sensor_data(struct device *dev, u16 *val)
 	st->tx[3] = 0;

 	spi_message_init(&msg);
-	spi_message_add_tail(&xfers, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
-		dev_err(&st->us->dev, "Problem while reading sensor data\n");
-		goto error_ret;
-	}
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers, &msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->us, &msg);
 	if (ret) {
 		dev_err(&st->us->dev, "Problem while reading sensor data\n");
--
1.6.0.2
