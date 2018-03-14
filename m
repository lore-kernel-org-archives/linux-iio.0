Return-Path: <SRS0=Zfd2=GE=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Wed, 14 Mar 2018 15:10:37 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging:iio:ade7854: Rework SPI write function
Message-ID: <0dd616ddca93968c254006b379b2817db819bb39.1521037060.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The write operation using SPI has a many code duplications (similar to
I2C) and four different interfaces per data size. This patch introduces
a single function that centralizes the main task related to SPI.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854-spi.c | 100 ++++++++++++++------------------
 1 file changed, 45 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 4419b8f06197..0dae118428cf 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -15,9 +15,10 @@
 #include <linux/iio/iio.h>
 #include "ade7854.h"
 
-static int ade7854_spi_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
+static int ade7854_spi_write_reg(struct device *dev,
+				 u16 reg_address,
+				 u32 val,
+				 enum data_size type)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -32,36 +33,58 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = val & 0xFF;
+	switch (type) {
+	case DATA_SIZE_8_BITS:
+		st->tx[3] = val & 0xFF;
+		break;
+	case DATA_SIZE_16_BITS:
+		xfer.len = 5;
+		st->tx[3] = (val >> 8) & 0xFF;
+		st->tx[4] = val & 0xFF;
+		break;
+	case DATA_SIZE_24_BITS:
+		xfer.len = 6;
+		st->tx[3] = (val >> 16) & 0xFF;
+		st->tx[4] = (val >> 8) & 0xFF;
+		st->tx[5] = val & 0xFF;
+		break;
+	case DATA_SIZE_32_BITS:
+		xfer.len = 7;
+		st->tx[3] = (val >> 24) & 0xFF;
+		st->tx[4] = (val >> 16) & 0xFF;
+		st->tx[5] = (val >> 8) & 0xFF;
+		st->tx[6] = val & 0xFF;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_spi_mutex_unlock;
+	}
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
+error_spi_mutex_unlock:
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
 }
 
+static int ade7854_spi_write_reg_8(struct device *dev,
+				   u16 reg_address,
+				   u8 val)
+{
+	int ret;
+
+	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
+
+	return ret;
+}
+
 static int ade7854_spi_write_reg_16(struct device *dev,
 				    u16 reg_address,
 				    u16 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 5,
-	};
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (val >> 8) & 0xFF;
-	st->tx[4] = val & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
-	mutex_unlock(&st->buf_lock);
+	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
 
 	return ret;
 }
@@ -71,24 +94,8 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 				    u32 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 6,
-	};
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (val >> 16) & 0xFF;
-	st->tx[4] = (val >> 8) & 0xFF;
-	st->tx[5] = val & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
-	mutex_unlock(&st->buf_lock);
+	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
 
 	return ret;
 }
@@ -98,25 +105,8 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 				    u32 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 7,
-	};
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADE7854_WRITE_REG;
-	st->tx[1] = (reg_address >> 8) & 0xFF;
-	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (val >> 24) & 0xFF;
-	st->tx[4] = (val >> 16) & 0xFF;
-	st->tx[5] = (val >> 8) & 0xFF;
-	st->tx[6] = val & 0xFF;
-
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
-	mutex_unlock(&st->buf_lock);
+	ret = ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
 
 	return ret;
 }
-- 
2.16.2
