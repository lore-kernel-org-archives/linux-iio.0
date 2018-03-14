Return-Path: <SRS0=Zfd2=GE=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Wed, 14 Mar 2018 15:11:05 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] staging:iio:ade7854: Rework I2C read function
Message-ID: <b6dbb1063924dacfc4b5f48abe8e8c8c52714a99.1521037060.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The read operation for the I2C function has many duplications that can
be generalized into a single function. This patch reworks the read
operation for I2C to centralizes all similar code in a single function.
Part of the rework includes a proper error handling and a fix on the
i2c_master_recv for 32 bits as pointed by John Syne patches.

It is possible to remove all the old interface to use the new one,
however, for keeping the things simple and working this patch maintain
legacy interface.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 106 ++++++++++++++------------------
 1 file changed, 47 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index f302359d2265..845f8c348945 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -65,9 +65,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
 	return ret;
 }
 
-static int ade7854_i2c_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
+static int ade7854_i2c_read_reg(struct device *dev,
+				u16 reg_address,
+				u32 *val,
+				enum data_size type)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -78,42 +79,58 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
-		goto out;
+	if (ret < 0)
+		goto error_i2c_read_unlock;
 
-	ret = i2c_master_recv(st->i2c, st->rx, 1);
-	if (ret)
-		goto out;
+	ret = i2c_master_recv(st->i2c, st->rx, type);
+	if (ret < 0)
+		goto error_i2c_read_unlock;
 
-	*val = st->rx[0];
-out:
+	switch (type) {
+	case DATA_SIZE_8_BITS:
+		*val = st->rx[0];
+		break;
+	case DATA_SIZE_16_BITS:
+		*val = (st->rx[0] << 8) | st->rx[1];
+		break;
+	case DATA_SIZE_24_BITS:
+		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+		break;
+	case DATA_SIZE_32_BITS:
+		*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
+			(st->rx[2] << 8) | st->rx[3];
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_i2c_read_unlock;
+	}
+
+error_i2c_read_unlock:
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
+static int ade7854_i2c_read_reg_8(struct device *dev,
+				  u16 reg_address,
+				  u8 *val)
+{
+	int ret;
+
+	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				   DATA_SIZE_8_BITS);
+
+	return ret;
+}
+
 static int ade7854_i2c_read_reg_16(struct device *dev,
 				   u16 reg_address,
 				   u16 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 2);
-	if (ret)
-		goto out;
+	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				   DATA_SIZE_16_BITS);
 
-	*val = (st->rx[0] << 8) | st->rx[1];
-out:
-	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
@@ -121,25 +138,11 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
-		goto out;
+	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				   DATA_SIZE_24_BITS);
 
-	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
-out:
-	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
@@ -147,26 +150,11 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
-		goto out;
+	ret = ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
+				   DATA_SIZE_32_BITS);
 
-	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
-		(st->rx[2] << 8) | st->rx[3];
-out:
-	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
-- 
2.16.2
