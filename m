Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/50] staging:iio:adc:ad799x clear out last few uses of iio_dev->dev_data.
Date: Fri, 27 May 2011 19:35:51 +0100
Message-Id: <1306521390-24897-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x_core.c |   13 ++++++-------
 drivers/staging/iio/adc/ad799x_ring.c |    4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 29bfbcf..92cfe2e 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -143,7 +143,7 @@ static int ad799x_read_raw(struct iio_dev *dev_info,
 			   long m)
 {
 	int ret;
-	struct ad799x_state *st = dev_info->dev_data;
+	struct ad799x_state *st = iio_priv(dev_info);
 	unsigned int scale_uv;
 
 	switch (m) {
@@ -176,7 +176,7 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 					char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
+	struct ad799x_state *st = iio_priv(dev_info);
 
 	int ret, len = 0;
 	u8 val;
@@ -221,7 +221,7 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 					 size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
+	struct ad799x_state *st = iio_priv(dev_info);
 
 	long val;
 	int ret;
@@ -281,7 +281,7 @@ static ssize_t ad799x_read_channel_config(struct device *dev,
 					char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
+	struct ad799x_state *st = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	int ret;
@@ -299,7 +299,7 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 					 size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
+	struct ad799x_state *st = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	long val;
@@ -319,7 +319,7 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 static irqreturn_t ad799x_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct ad799x_state *st = iio_dev_get_devdata(private);
+	struct ad799x_state *st = iio_priv(private);
 	u8 status;
 	int i, ret;
 
@@ -686,7 +686,6 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->info = st->chip_info->info;
 	indio_dev->name = id->name;
-	indio_dev->dev_data = (void *)(st);
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channel;
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 1ae8857..0376a82 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -72,7 +72,7 @@ error_ret:
 static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	struct ad799x_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad799x_state *st = iio_priv(indio_dev);
 
 	/*
 	 * Need to figure out the current mode based upon the requested
@@ -109,7 +109,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct ad799x_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad799x_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
 	__u8 *rxbuf;
-- 
1.7.3.4
