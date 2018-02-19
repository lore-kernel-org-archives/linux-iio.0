Return-Path: <SRS0=RhpT=FN=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Mon, 19 Feb 2018 13:28:32 -0300
From: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging:iio:meter: Add name to function definition
 arguments
Message-ID: <20180219162832.qbkogggfzwbgsqlt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl warning:

drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
argument 'struct device *' should also have an identifier name...

This commit adds arguments names to the signature declared in the
ade7854_state struct. For consistency reason, It also renames all
arguments in function definitions.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
  - Make the commit message clearer.
  - Use the same arguments name across signatures and definitions.

 drivers/staging/iio/meter/ade7754.c     |  6 +++---
 drivers/staging/iio/meter/ade7854-i2c.c | 28 ++++++++++++++--------------
 drivers/staging/iio/meter/ade7854-spi.c | 28 ++++++++++++++--------------
 drivers/staging/iio/meter/ade7854.h     | 28 ++++++++++++++--------------
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 3a1e342d75fb..9aa067736715 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -132,7 +132,7 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
 }
 
 static int ade7754_spi_write_reg_16(struct device *dev,
-				    u8 reg_address, u16 value)
+				    u8 reg_address, u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -140,8 +140,8 @@ static int ade7754_spi_write_reg_16(struct device *dev,
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7754_WRITE_REG(reg_address);
-	st->tx[1] = (value >> 8) & 0xFF;
-	st->tx[2] = value & 0xFF;
+	st->tx[1] = (val >> 8) & 0xFF;
+	st->tx[2] = val & 0xFF;
 	ret = spi_write(st->us, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 8106f8cceeab..317e4f0d8176 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -17,7 +17,7 @@
 
 static int ade7854_i2c_write_reg_8(struct device *dev,
 				   u16 reg_address,
-				   u8 value)
+				   u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -26,7 +26,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = value;
+	st->tx[2] = val;
 
 	ret = i2c_master_send(st->i2c, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
@@ -36,7 +36,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 
 static int ade7854_i2c_write_reg_16(struct device *dev,
 				    u16 reg_address,
-				    u16 value)
+				    u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -45,8 +45,8 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (value >> 8) & 0xFF;
-	st->tx[3] = value & 0xFF;
+	st->tx[2] = (val >> 8) & 0xFF;
+	st->tx[3] = val & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 4);
 	mutex_unlock(&st->buf_lock);
@@ -56,7 +56,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
 				    u16 reg_address,
-				    u32 value)
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -65,9 +65,9 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (value >> 16) & 0xFF;
-	st->tx[3] = (value >> 8) & 0xFF;
-	st->tx[4] = value & 0xFF;
+	st->tx[2] = (val >> 16) & 0xFF;
+	st->tx[3] = (val >> 8) & 0xFF;
+	st->tx[4] = val & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 5);
 	mutex_unlock(&st->buf_lock);
@@ -77,7 +77,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
 				    u16 reg_address,
-				    u32 value)
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -86,10 +86,10 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
 	st->tx[1] = reg_address & 0xFF;
-	st->tx[2] = (value >> 24) & 0xFF;
-	st->tx[3] = (value >> 16) & 0xFF;
-	st->tx[4] = (value >> 8) & 0xFF;
-	st->tx[5] = value & 0xFF;
+	st->tx[2] = (val >> 24) & 0xFF;
+	st->tx[3] = (val >> 16) & 0xFF;
+	st->tx[4] = (val >> 8) & 0xFF;
+	st->tx[5] = val & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 6);
 	mutex_unlock(&st->buf_lock);
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 63e200ffd1f2..72eddfec21f7 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -17,7 +17,7 @@
 
 static int ade7854_spi_write_reg_8(struct device *dev,
 		u16 reg_address,
-		u8 value)
+		u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -32,7 +32,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = value & 0xFF;
+	st->tx[3] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
@@ -42,7 +42,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 
 static int ade7854_spi_write_reg_16(struct device *dev,
 		u16 reg_address,
-		u16 value)
+		u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -57,8 +57,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 8) & 0xFF;
-	st->tx[4] = value & 0xFF;
+	st->tx[3] = (val >> 8) & 0xFF;
+	st->tx[4] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
@@ -68,7 +68,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 
 static int ade7854_spi_write_reg_24(struct device *dev,
 		u16 reg_address,
-		u32 value)
+		u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -83,9 +83,9 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 16) & 0xFF;
-	st->tx[4] = (value >> 8) & 0xFF;
-	st->tx[5] = value & 0xFF;
+	st->tx[3] = (val >> 16) & 0xFF;
+	st->tx[4] = (val >> 8) & 0xFF;
+	st->tx[5] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
@@ -95,7 +95,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 
 static int ade7854_spi_write_reg_32(struct device *dev,
 		u16 reg_address,
-		u32 value)
+		u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -110,10 +110,10 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 	st->tx[0] = ADE7854_WRITE_REG;
 	st->tx[1] = (reg_address >> 8) & 0xFF;
 	st->tx[2] = reg_address & 0xFF;
-	st->tx[3] = (value >> 24) & 0xFF;
-	st->tx[4] = (value >> 16) & 0xFF;
-	st->tx[5] = (value >> 8) & 0xFF;
-	st->tx[6] = value & 0xFF;
+	st->tx[3] = (val >> 24) & 0xFF;
+	st->tx[4] = (val >> 16) & 0xFF;
+	st->tx[5] = (val >> 8) & 0xFF;
+	st->tx[6] = val & 0xFF;
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	mutex_unlock(&st->buf_lock);
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index c27247a7891a..a82d38224cbd 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -152,20 +152,20 @@
  * @rx:			receive buffer
  **/
 struct ade7854_state {
-	struct spi_device	*spi;
-	struct i2c_client	*i2c;
-	int			(*read_reg_8)(struct device *, u16, u8 *);
-	int			(*read_reg_16)(struct device *, u16, u16 *);
-	int			(*read_reg_24)(struct device *, u16, u32 *);
-	int			(*read_reg_32)(struct device *, u16, u32 *);
-	int			(*write_reg_8)(struct device *, u16, u8);
-	int			(*write_reg_16)(struct device *, u16, u16);
-	int			(*write_reg_24)(struct device *, u16, u32);
-	int			(*write_reg_32)(struct device *, u16, u32);
-	int			irq;
-	struct mutex		buf_lock;
-	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
-	u8			rx[ADE7854_MAX_RX];
+	struct spi_device *spi;
+	struct i2c_client *i2c;
+	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
+	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
+	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
+	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
+	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
+	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
+	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
+	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
+	int irq;
+	struct mutex buf_lock;
+	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
+	u8 rx[ADE7854_MAX_RX];
 
 };
 
-- 
2.16.1
