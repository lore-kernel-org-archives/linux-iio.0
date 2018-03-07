Return-Path: <SRS0=cM/H=F5=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 6 Mar 2018 21:44:26 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging:iio:meter: Aligns open parenthesis
Message-ID: <e276c37521ce2520df734dff1a70663d2f4c0d9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl checks:

staging/iio/meter/ade7854-spi.c:19: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:44: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:70: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:97: CHECK: Alignment should match open
parenthesis
staging/iio/meter/ade7854-spi.c:125: CHECK: Alignment should match open
parenthesis

...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7758_trigger.c |  6 ++---
 drivers/staging/iio/meter/ade7854-spi.c     | 40 ++++++++++++++---------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 1f0d1a0cf889..3314aa298d99 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -30,7 +30,7 @@ static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
  * ade7758_data_rdy_trigger_set_state() set datardy interrupt state
  **/
 static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
+					      bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 
@@ -63,8 +63,8 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 
 	st->trig = iio_trigger_alloc("%s-dev%d",
-					spi_get_device_id(st->us)->name,
-					indio_dev->id);
+				     spi_get_device_id(st->us)->name,
+				     indio_dev->id);
 	if (!st->trig) {
 		ret = -ENOMEM;
 		goto error_ret;
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 72eddfec21f7..4419b8f06197 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -16,8 +16,8 @@
 #include "ade7854.h"
 
 static int ade7854_spi_write_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 val)
+				   u16 reg_address,
+				   u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -41,8 +41,8 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 }
 
 static int ade7854_spi_write_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 val)
+				    u16 reg_address,
+				    u16 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -67,8 +67,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 }
 
 static int ade7854_spi_write_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 val)
+				    u16 reg_address,
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -94,8 +94,8 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 }
 
 static int ade7854_spi_write_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 val)
+				    u16 reg_address,
+				    u32 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -122,8 +122,8 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 *val)
+				  u16 reg_address,
+				  u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -149,7 +149,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = st->rx[0];
@@ -160,8 +160,8 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 *val)
+				   u16 reg_address,
+				   u16 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -186,7 +186,7 @@ static int ade7854_spi_read_reg_16(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = be16_to_cpup((const __be16 *)st->rx);
@@ -197,8 +197,8 @@ static int ade7854_spi_read_reg_16(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 *val)
+				   u16 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -224,7 +224,7 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
@@ -235,8 +235,8 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 }
 
 static int ade7854_spi_read_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 *val)
+				   u16 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -262,7 +262,7 @@ static int ade7854_spi_read_reg_32(struct device *dev,
 	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = be32_to_cpup((const __be32 *)st->rx);
-- 
2.16.2
