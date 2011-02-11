Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] staging:iio:meter:ade7854 spi - use macros for the whole series of nearly identical read and write functions.
Date: Fri, 11 Feb 2011 15:39:16 +0000
Message-Id: <1297438756-26920-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1297438756-26920-1-git-send-email-jic23@cam.ac.uk>
References: <1297438756-26920-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I'm not entirely convinced this is a good idea even assuming I got the macros
right.  On the one hand there was an awful lot of repeated code without
them. On the other it was marginally more obvious what the code did.

What do people think of doing this? If people are happy with it in principal,
there are quite a few other places where this will lead to much shorter drivers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7854-spi.c |  244 +++++++------------------------
 1 files changed, 56 insertions(+), 188 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 113f1f6..f0140c4 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -14,195 +14,63 @@
 #include "../iio.h"
 #include "ade7854.h"
 
-static int ade7854_spi_write_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 value)
-{
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = value & 0xFF;
-
-	ret = spi_write(st->spi, st->tx, 4);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-static int ade7854_spi_write_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 value)
-{
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 8) & 0xFF;
-	st->tx[4] = value & 0xFF;
-	ret = spi_write(st->spi, st->tx, 5);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-static int ade7854_spi_write_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 value)
-{
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 16) & 0xFF;
-	st->tx[4] = (value >> 8) & 0xFF;
-	st->tx[5] = value & 0xFF;
-	ret = spi_write(st->spi, st->tx, 6);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-static int ade7854_spi_write_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 value)
-{
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 24) & 0xFF;
-	st->tx[4] = (value >> 16) & 0xFF;
-	st->tx[5] = (value >> 8) & 0xFF;
-	st->tx[6] = value & 0xFF;
-	ret = spi_write(st->spi, st->tx, 6);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-static int ade7854_spi_read_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 *val)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 1);
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
-				reg_address);
-		goto error_ret;
+#define ADE7854_SPI_WRITE_REG_BITS(bits, value_type)			\
+	int ade7854_spi_write_reg_##bits (struct device *dev,		\
+					  u16 reg_address,		\
+					  value_type value)		\
+	{								\
+		int ret, i;						\
+									\
+		struct iio_dev *indio_dev = dev_get_drvdata(dev);	\
+		struct ade7854_state *st = iio_dev_get_devdata(indio_dev); \
+									\
+		mutex_lock(&st->buf_lock);				\
+		st->tx[0] = ADE7854_WRITE_REG;				\
+		st->tx[1] = (reg_address >> 8) & 0xFF;			\
+		st->tx[2] = reg_address & 0xFF;				\
+		for (i = 0; i < bits/8; i++)				\
+			st->tx[3 + i] = value >> 8*(bits/8 - i);	\
+		ret = spi_write(st->spi, st->tx, 3+bits/8);		\
+		mutex_unlock(&st->buf_lock);				\
+									\
+		return ret;						\
 	}
-	*val = st->rx[0];
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
-
-static int ade7854_spi_read_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 *val)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 2);
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
-				reg_address);
-		goto error_ret;
-	}
-	*val = be16_to_cpup((const __be16 *)st->rx);
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
-
-static int ade7854_spi_read_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 *val)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 3);
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
-				reg_address);
-		goto error_ret;
-	}
-	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
-
-static int ade7854_spi_read_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 *val)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, 4);
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
-				reg_address);
-		goto error_ret;
-	}
-	*val = be32_to_cpup((const __be32 *)st->rx);
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
+static ADE7854_SPI_WRITE_REG_BITS(8, u8);
+static ADE7854_SPI_WRITE_REG_BITS(16, u16);
+static ADE7854_SPI_WRITE_REG_BITS(24, u32);
+static ADE7854_SPI_WRITE_REG_BITS(32, u32);
+
+#define ADE7854_SPI_READ_REG_BITS(bits, value_type)			\
+	int ade7854_spi_read_reg_##bits (struct device *dev,		\
+					 u16 reg_address,		\
+					 value_type *val)		\
+	{								\
+		struct iio_dev *indio_dev = dev_get_drvdata(dev);	\
+		struct ade7854_state *st = iio_dev_get_devdata(indio_dev); \
+		int ret, i;						\
+									\
+		mutex_lock(&st->buf_lock);				\
+		st->tx[0] = ADE7854_READ_REG;				\
+		st->tx[1] = (reg_address >> 8) & 0xFF;			\
+		st->tx[2] = reg_address & 0xFF;				\
+		ret = spi_write_then_read(st->spi, st->tx, 3, st->rx, bits/8); \
+		if (ret) {						\
+			dev_err(&st->spi->dev,				\
+				"problem when reading register 0x%02X",	\
+				reg_address);				\
+			goto error_ret;					\
+		}							\
+		*val = 0;						\
+		for (i = 0; i < bits/8; i++)				\
+			*val |= st->rx[i] << (bits - (i + 1)*8);	\
+	error_ret:							\
+		mutex_unlock(&st->buf_lock);				\
+		return ret;						\
+	}			
+static ADE7854_SPI_READ_REG_BITS(8, u8);
+static ADE7854_SPI_READ_REG_BITS(16, u16);
+static ADE7854_SPI_READ_REG_BITS(24, u32);
+static ADE7854_SPI_READ_REG_BITS(32, u32);
 
 static int __devinit ade7854_spi_probe(struct spi_device *spi)
 {
-- 
1.7.3.4
