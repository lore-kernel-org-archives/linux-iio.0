Return-Path: <SRS0=O4k9=GG=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 16 Mar 2018 19:48:33 -0300
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
Subject: [PATCH v2 1/8] staging:iio:ade7854: Fix error handling on read/write
Message-ID: <c6329504bb92726dd1ca45cd5b44e180e86a407e.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The original code does not correctly handle the error related to I2C
read and write. This patch fixes the error handling related to all
read/write functions for I2C. This patch is an adaptation of the John
Syne patches.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 24 ++++++++++++------------
 drivers/staging/iio/meter/ade7854.c     | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 317e4f0d8176..4437f1e33261 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -31,7 +31,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_16(struct device *dev,
@@ -51,7 +51,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 4);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
@@ -72,7 +72,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 5);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
@@ -94,7 +94,7 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
 	ret = i2c_master_send(st->i2c, st->tx, 6);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_read_reg_8(struct device *dev,
@@ -110,11 +110,11 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 1);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = st->rx[0];
@@ -136,11 +136,11 @@ static int ade7854_i2c_read_reg_16(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 8) | st->rx[1];
@@ -162,11 +162,11 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
@@ -188,11 +188,11 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 90d07cdca4b8..0193ae3aae29 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -33,7 +33,7 @@ static ssize_t ade7854_read_8bit(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_8(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -50,7 +50,7 @@ static ssize_t ade7854_read_16bit(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_16(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -67,7 +67,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_24(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -84,7 +84,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
 	struct ade7854_state *st = iio_priv(indio_dev);
 
 	ret = st->read_reg_32(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -416,7 +416,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 	u32 irqen;
 
 	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (enable)
-- 
2.16.2
