Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 21/45] iio:dpot: drop assign iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:03 +0100
Message-Id: <20170723162627.22534-22-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/potentiometer/ds1803.c  | 1 -
 drivers/iio/potentiometer/max5481.c | 1 -
 drivers/iio/potentiometer/max5487.c | 1 -
 drivers/iio/potentiometer/mcp4131.c | 1 -
 drivers/iio/potentiometer/mcp4531.c | 1 -
 drivers/iio/potentiometer/tpl0102.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index fb9e2a337dc2..9b0ff4ab2f9c 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -110,7 +110,6 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ds1803_info = {
 	.read_raw = ds1803_read_raw,
 	.write_raw = ds1803_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ds1803_probe(struct i2c_client *client,
diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index 926554991244..2f9102544d57 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -119,7 +119,6 @@ static int max5481_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info max5481_info = {
 	.read_raw = max5481_read_raw,
 	.write_raw = max5481_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #if defined(CONFIG_OF)
diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index 6c50939a2e83..ec1a91a0a391 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -83,7 +83,6 @@ static int max5487_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info max5487_info = {
 	.read_raw = max5487_read_raw,
 	.write_raw = max5487_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int max5487_spi_probe(struct spi_device *spi)
diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index 4e7e2c6c522c..b3e30db246cc 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -237,7 +237,6 @@ static int mcp4131_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info mcp4131_info = {
 	.read_raw = mcp4131_read_raw,
 	.write_raw = mcp4131_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int mcp4131_probe(struct spi_device *spi)
diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index 314353d7ab59..114ab876fcc6 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -207,7 +207,6 @@ static const struct iio_info mcp4531_info = {
 	.read_raw = mcp4531_read_raw,
 	.read_avail = mcp4531_read_avail,
 	.write_raw = mcp4531_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index 7b6b54531ea2..93f9d4a8c9aa 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -106,7 +106,6 @@ static int tpl0102_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info tpl0102_info = {
 	.read_raw = tpl0102_read_raw,
 	.write_raw = tpl0102_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int tpl0102_probe(struct i2c_client *client,
-- 
2.13.3
