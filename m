Return-Path: <SRS0=O4k9=GG=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 16 Mar 2018 19:50:15 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] staging:iio:ade7854: Rework SPI read function
Message-ID: <9aa718713752ddbc54b0ecdd8dad7fbe85854781.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Rework read SPI function to reduce the code duplication and centralizes
all the task in a single function.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-spi.c | 140 +++++++++-----------------------
 1 file changed, 37 insertions(+), 103 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 1eba3044b86f..964d6c6e76d1 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -67,9 +67,10 @@ static int ade7854_spi_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
+static int ade7854_spi_read_reg(struct device *dev,
+				u16 reg_address,
+				u32 *val,
+				int bytes)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -82,7 +83,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
-			.len = 1,
+			.len = bytes,
 		}
 	};
 
@@ -94,128 +95,61 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
+		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
 			reg_address);
-		goto error_ret;
+		goto unlock;
+	}
+
+	switch (bytes) {
+	case DATA_SIZE_8_BITS:
+		*val = st->rx[0];
+		break;
+	case DATA_SIZE_16_BITS:
+		*val = be16_to_cpup((const __be16 *)st->rx);
+		break;
+	case DATA_SIZE_24_BITS:
+		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+		break;
+	case DATA_SIZE_32_BITS:
+		*val = be32_to_cpup((const __be32 *)st->rx);
+		break;
 	}
-	*val = st->rx[0];
 
-error_ret:
+unlock:
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
+static int ade7854_spi_read_reg_8(struct device *dev,
+				  u16 reg_address,
+				  u8 *val)
+{
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_8_BITS);
+}
+
 static int ade7854_spi_read_reg_16(struct device *dev,
 				   u16 reg_address,
 				   u16 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
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
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
-			reg_address);
-		goto error_ret;
-	}
-	*val = be16_to_cpup((const __be16 *)st->rx);
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_16_BITS);
 }
 
 static int ade7854_spi_read_reg_24(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
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
-
-	mutex_lock(&st->buf_lock);
-
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
-			reg_address);
-		goto error_ret;
-	}
-	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_24_BITS);
 }
 
 static int ade7854_spi_read_reg_32(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
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
-
-	mutex_lock(&st->buf_lock);
-
-	st->tx[0] = ADE7854_READ_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret) {
-		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
-			reg_address);
-		goto error_ret;
-	}
-	*val = be32_to_cpup((const __be32 *)st->rx);
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val,
+				    DATA_SIZE_32_BITS);
 }
 
 static int ade7854_spi_probe(struct spi_device *spi)
-- 
2.16.2
