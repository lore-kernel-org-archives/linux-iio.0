Return-Path: <SRS0=zXoK=GN=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 23 Mar 2018 11:26:41 -0300
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
Subject: [PATCH v3 5/8] staging:iio:ade7854: Remove write_reg_* duplications
Message-ID: <f653606d784c5b4dd1b502030a4b0ce43df8e913.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch removes code duplications related to the write_reg_*
functions and centralizes them in a single function. Also, it eliminates
the legacy functions and replaces them by a unique signature that is
used by SPI and I2C.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v3:
 - Update commit message

 drivers/staging/iio/meter/ade7854-i2c.c | 33 +--------------------------------
 drivers/staging/iio/meter/ade7854-spi.c | 33 +--------------------------------
 drivers/staging/iio/meter/ade7854.c     | 12 ++++++------
 drivers/staging/iio/meter/ade7854.h     |  9 ++++-----
 4 files changed, 12 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index c9f46d26b752..29e959fdb932 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -65,34 +65,6 @@ static int ade7854_i2c_write_reg(struct device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-static int ade7854_i2c_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 8);
-}
-
-static int ade7854_i2c_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 16);
-}
-
-static int ade7854_i2c_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 24);
-}
-
-static int ade7854_i2c_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_i2c_write_reg(dev, reg_address, val, 32);
-}
-
 static int ade7854_i2c_read_reg_8(struct device *dev,
 				  u16 reg_address,
 				  u8 *val)
@@ -213,10 +185,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
 	st->read_reg_16 = ade7854_i2c_read_reg_16;
 	st->read_reg_24 = ade7854_i2c_read_reg_24;
 	st->read_reg_32 = ade7854_i2c_read_reg_32;
-	st->write_reg_8 = ade7854_i2c_write_reg_8;
-	st->write_reg_16 = ade7854_i2c_write_reg_16;
-	st->write_reg_24 = ade7854_i2c_write_reg_24;
-	st->write_reg_32 = ade7854_i2c_write_reg_32;
+	st->write_reg = ade7854_i2c_write_reg;
 	st->i2c = client;
 	st->irq = client->irq;
 
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 9c5c16c4d6e0..be7397042850 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -67,34 +67,6 @@ static int ade7854_spi_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_spi_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 8);
-}
-
-static int ade7854_spi_write_reg_16(struct device *dev,
-				    u16 reg_address,
-				    u16 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 16);
-}
-
-static int ade7854_spi_write_reg_24(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 24);
-}
-
-static int ade7854_spi_write_reg_32(struct device *dev,
-				    u16 reg_address,
-				    u32 val)
-{
-	return ade7854_spi_write_reg(dev, reg_address, val, 32);
-}
-
 static int ade7854_spi_read_reg_8(struct device *dev,
 				  u16 reg_address,
 				  u8 *val)
@@ -260,10 +232,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
 	st->read_reg_16 = ade7854_spi_read_reg_16;
 	st->read_reg_24 = ade7854_spi_read_reg_24;
 	st->read_reg_32 = ade7854_spi_read_reg_32;
-	st->write_reg_8 = ade7854_spi_write_reg_8;
-	st->write_reg_16 = ade7854_spi_write_reg_16;
-	st->write_reg_24 = ade7854_spi_write_reg_24;
-	st->write_reg_32 = ade7854_spi_write_reg_32;
+	st->write_reg = ade7854_spi_write_reg;
 	st->irq = spi->irq;
 	st->spi = spi;
 
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 0193ae3aae29..45984b9a2bee 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -105,7 +105,7 @@ static ssize_t ade7854_write_8bit(struct device *dev,
 	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_8(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 8);
 
 error_ret:
 	return ret ? ret : len;
@@ -126,7 +126,7 @@ static ssize_t ade7854_write_16bit(struct device *dev,
 	ret = kstrtou16(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_16(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 16);
 
 error_ret:
 	return ret ? ret : len;
@@ -147,7 +147,7 @@ static ssize_t ade7854_write_24bit(struct device *dev,
 	ret = kstrtou32(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_24(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 24);
 
 error_ret:
 	return ret ? ret : len;
@@ -168,7 +168,7 @@ static ssize_t ade7854_write_32bit(struct device *dev,
 	ret = kstrtou32(buf, 10, &val);
 	if (ret)
 		goto error_ret;
-	ret = st->write_reg_32(dev, this_attr->address, val);
+	ret = st->write_reg(dev, this_attr->address, val, 32);
 
 error_ret:
 	return ret ? ret : len;
@@ -183,7 +183,7 @@ static int ade7854_reset(struct device *dev)
 	st->read_reg_16(dev, ADE7854_CONFIG, &val);
 	val |= BIT(7); /* Software Chip Reset */
 
-	return st->write_reg_16(dev, ADE7854_CONFIG, val);
+	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
 }
 
 static IIO_DEV_ATTR_AIGAIN(0644,
@@ -426,7 +426,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	else
 		irqen &= ~BIT(17);
 
-	return st->write_reg_32(dev, ADE7854_MASK0, irqen);
+	return st->write_reg(dev, ADE7854_MASK0, irqen, 32);
 }
 
 static int ade7854_initial_setup(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index a82d38224cbd..290adbf56951 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -145,7 +145,8 @@
 
 /**
  * struct ade7854_state - device instance specific data
- * @spi:			actual spi_device
+ * @spi:		actual spi_device
+ * @write_reg		Wrapper function for I2C and SPI write
  * @indio_dev:		industrial I/O device structure
  * @buf_lock:		mutex to protect tx and rx
  * @tx:			transmit buffer
@@ -158,10 +159,8 @@ struct ade7854_state {
 	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
 	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
 	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
-	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
-	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
-	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
-	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
+	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
+			 int bits);
 	int irq;
 	struct mutex buf_lock;
 	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
-- 
2.16.2
