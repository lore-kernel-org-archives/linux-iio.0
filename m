Return-Path: <SRS0=zXoK=GN=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 23 Mar 2018 11:26:06 -0300
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
Subject: [PATCH v3 3/8] staging:iio:ade7854: Rework I2C write function
Message-ID: <c87da79c773f417c94b4609476c54f7de085b697.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The write operation using I2C has many code duplications and four
different interfaces per data size. This patch introduces a single
function that centralizes the main tasks.

The central function inserted by this patch can easily replace all the
four functions related to the data size. However, this patch does not
remove any code signature for keeping the meter module work and make
easier to review this patch.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v3:
 - Remove the use of defines that not improve the readability
 - Replace variable name "bytes" for "bits"

 drivers/staging/iio/meter/ade7854-i2c.c | 96 ++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 37c957482493..c9f46d26b752 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -15,86 +15,82 @@
 #include <linux/iio/iio.h>
 #include "ade7854.h"
 
-static int ade7854_i2c_write_reg_8(struct device *dev,
-				   u16 reg_address,
-				   u8 val)
+static int ade7854_i2c_write_reg(struct device *dev,
+				 u16 reg_address,
+				 u32 val,
+				 int bits)
 {
 	int ret;
+	int count;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = val;
 
-	ret = i2c_master_send(st->i2c, st->tx, 3);
+	switch (bits) {
+	case 8:
+		st->tx[2] = val & 0xFF;
+		count = 3;
+		break;
+	case 16:
+		st->tx[2] = (val >> 8) & 0xFF;
+		st->tx[3] = val & 0xFF;
+		count = 4;
+		break;
+	case 24:
+		st->tx[2] = (val >> 16) & 0xFF;
+		st->tx[3] = (val >> 8) & 0xFF;
+		st->tx[4] = val & 0xFF;
+		count = 5;
+		break;
+	case 32:
+		st->tx[2] = (val >> 24) & 0xFF;
+		st->tx[3] = (val >> 16) & 0xFF;
+		st->tx[4] = (val >> 8) & 0xFF;
+		st->tx[5] = val & 0xFF;
+		count = 6;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = i2c_master_send(st->i2c, st->tx, count);
+
+unlock:
 	mutex_unlock(&st->buf_lock);
 
 	return ret < 0 ? ret : 0;
 }
 
+static int ade7854_i2c_write_reg_8(struct device *dev,
+				   u16 reg_address,
+				   u8 val)
+{
+	return ade7854_i2c_write_reg(dev, reg_address, val, 8);
+}
+
 static int ade7854_i2c_write_reg_16(struct device *dev,
 				    u16 reg_address,
 				    u16 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 8) & 0xFF;
-	st->tx[3] = val & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 4);
-	mutex_unlock(&st->buf_lock);
-
-	return ret < 0 ? ret : 0;
+	return ade7854_i2c_write_reg(dev, reg_address, val, 16);
 }
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
 				    u16 reg_address,
 				    u32 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 16) & 0xFF;
-	st->tx[3] = (val >> 8) & 0xFF;
-	st->tx[4] = val & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 5);
-	mutex_unlock(&st->buf_lock);
-
-	return ret < 0 ? ret : 0;
+	return ade7854_i2c_write_reg(dev, reg_address, val, 24);
 }
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
 				    u16 reg_address,
 				    u32 val)
 {
-	int ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7854_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = (reg_address >> 8) & 0xFF;
-	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (val >> 24) & 0xFF;
-	st->tx[3] = (val >> 16) & 0xFF;
-	st->tx[4] = (val >> 8) & 0xFF;
-	st->tx[5] = val & 0xFF;
-
-	ret = i2c_master_send(st->i2c, st->tx, 6);
-	mutex_unlock(&st->buf_lock);
-
-	return ret < 0 ? ret : 0;
+	return ade7854_i2c_write_reg(dev, reg_address, val, 32);
 }
 
 static int ade7854_i2c_read_reg_8(struct device *dev,
-- 
2.16.2
