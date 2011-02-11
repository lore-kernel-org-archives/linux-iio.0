Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:43639 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217Ab1BKPjI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2011 10:39:08 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio:meter:ade7854 move to spi_write and spi_write_the_read
Date: Fri, 11 Feb 2011 15:39:15 +0000
Message-Id: <1297438756-26920-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297438756-26920-1-git-send-email-jic23@cam.ac.uk>
References: <1297438756-26920-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7854-spi.c |  111 ++----------------------------
 1 files changed, 8 insertions(+), 103 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 84da8fb..113f1f6 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -19,14 +19,8 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 		u8 value)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 4,
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7854_WRITE_REG;
@@ -34,9 +28,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	st->tx[2] = reg_address & 0xFF;
 	st->tx[3] = value & 0xFF;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write(st->spi, st->tx, 4);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -47,14 +39,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 		u16 value)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 5,
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7854_WRITE_REG;
@@ -62,10 +48,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 	st->tx[2] = reg_address & 0xFF;
 	st->tx[3] = (value >> 8) & 0xFF;
 	st->tx[4] = value & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write(st->spi, st->tx, 5);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -76,14 +59,8 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 		u32 value)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 6,
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7854_WRITE_REG;
@@ -92,10 +69,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 	st->tx[3] = (value >> 16) & 0xFF;
 	st->tx[4] = (value >> 8) & 0xFF;
 	st->tx[5] = value & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write(st->spi, st->tx, 6);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -106,14 +80,8 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 		u32 value)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 7,
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7854_WRITE_REG;
@@ -123,10 +91,7 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 	st->tx[4] = (value >> 16) & 0xFF;
 	st->tx[5] = (value >> 8) & 0xFF;
 	st->tx[6] = value & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write(st->spi, st->tx, 6);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -136,21 +101,9 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 		u16 reg_address,
 		u8 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 1,
-		}
-	};
 
 	mutex_lock(&st->buf_lock);
 
@@ -158,10 +111,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 1);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
 				reg_address);
@@ -178,31 +128,16 @@ static int ade7854_spi_read_reg_16(struct device *dev,
 		u16 reg_address,
 		u16 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 2,
-		}
-	};
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7854_READ_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 2);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
 				reg_address);
@@ -219,21 +154,9 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 		u16 reg_address,
 		u32 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 3,
-		}
-	};
 
 	mutex_lock(&st->buf_lock);
 
@@ -241,10 +164,7 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 3);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
 				reg_address);
@@ -261,21 +181,9 @@ static int ade7854_spi_read_reg_32(struct device *dev,
 		u16 reg_address,
 		u32 *val)
 {
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 3,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 4,
-		}
-	};
 
 	mutex_lock(&st->buf_lock);
 
@@ -283,10 +191,7 @@ static int ade7854_spi_read_reg_32(struct device *dev,
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->spi, &msg);
+	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 4);
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
 				reg_address);
-- 
1.7.3.4

