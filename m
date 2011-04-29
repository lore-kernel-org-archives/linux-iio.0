Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:56871 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1D2M0Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 08:26:16 -0400
Received: from mail31-tx2 (localhost.localdomain [127.0.0.1])	by
 mail31-tx2-R.bigfish.com (Postfix) with ESMTP id B26032E2020E	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 12:26:14 +0000 (UTC)
Received: from TX2EHSMHS046.bigfish.com (unknown [10.9.14.249])	by
 mail31-tx2.bigfish.com (Postfix) with ESMTP id 7280B4308051	for
 <linux-iio@vger.kernel.org>; Fri, 29 Apr 2011 12:26:14 +0000 (UTC)
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<jic23@cam.ac.uk>, <device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/6] IIO: GYRO: ADXRS450: Don't issue two messages, use two transfers
Date: Fri, 29 Apr 2011 14:16:59 +0200
Message-ID: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Don't issue the same message twice, use two transfers and group them together

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
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


