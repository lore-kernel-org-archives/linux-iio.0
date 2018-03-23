Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42803 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbeCWO1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Mar 2018 10:27:03 -0400
Date: Fri, 23 Mar 2018 11:26:57 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] staging:iio:ade7854: Rework I2C read function
Message-ID: <c7f86bb795b71e693692b228da854939be67cb1d.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The read operation for the I2C function has many duplications that can
be generalized into a single function. This patch reworks the read
operation for I2C to centralizes all similar code in a single function.

It is possible to remove all the old interface to use the new one,
however, for keeping the things simple and working this patch maintain
legacy interface.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v3:
 - Remove the use of defines that not improve the readability
 - Replace variable name "bytes" for "bits"
 - Update commit message

 drivers/staging/iio/meter/ade7854-i2c.c | 106 +++++++++++---------------------
 1 file changed, 37 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 29e959fdb932..63793f9664c7 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -65,9 +65,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-static int ade7854_i2c_read_reg_8(struct device *dev,
-				  u16 reg_address,
-				  u8 *val)
+static int ade7854_i2c_read_reg(struct device *dev,
+				u16 reg_address,
+				u32 *val,
+				int bits)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -79,95 +80,62 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
 	if (ret < 0)
-		goto out;
+		goto unlock;
 
-	ret = i2c_master_recv(st->i2c, st->rx, 1);
+	ret = i2c_master_recv(st->i2c, st->rx, bits);
 	if (ret < 0)
-		goto out;
+		goto unlock;
+
+	switch (bits) {
+	case 8:
+		*val = st->rx[0];
+		break;
+	case 16:
+		*val = (st->rx[0] << 8) | st->rx[1];
+		break;
+	case 24:
+		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
+		break;
+	case 32:
+		*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
+			(st->rx[2] << 8) | st->rx[3];
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
 
-	*val = st->rx[0];
-out:
+unlock:
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
+static int ade7854_i2c_read_reg_8(struct device *dev,
+				  u16 reg_address,
+				  u8 *val)
+{
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 8);
+}
+
 static int ade7854_i2c_read_reg_16(struct device *dev,
 				   u16 reg_address,
 				   u16 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret < 0)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 2);
-	if (ret < 0)
-		goto out;
-
-	*val = (st->rx[0] << 8) | st->rx[1];
-out:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 16);
 }
 
 static int ade7854_i2c_read_reg_24(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret < 0)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret < 0)
-		goto out;
-
-	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
-out:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 24);
 }
 
 static int ade7854_i2c_read_reg_32(struct device *dev,
 				   u16 reg_address,
 				   u32 *val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret < 0)
-		goto out;
-
-	ret = i2c_master_recv(st->i2c, st->rx, 4);
-	if (ret < 0)
-		goto out;
-
-	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
-		(st->rx[2] << 8) | st->rx[3];
-out:
-	mutex_unlock(&st->buf_lock);
-	return ret;
+	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 32);
 }
 
 static int ade7854_i2c_probe(struct i2c_client *client,
-- 
2.16.2

