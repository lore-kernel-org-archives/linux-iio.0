Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/54] staging:iio:adc:ad7887 clear out last few uses of iio_dev->dev_data.
Date: Mon, 27 Jun 2011 11:04:24 +0100
Message-Id: <1309169104-22139-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7887_core.c |    3 +--
 drivers/staging/iio/adc/ad7887_ring.c |    6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index de14b17..3d9121e 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -37,7 +37,7 @@ static int ad7887_read_raw(struct iio_dev *dev_info,
 			   long m)
 {
 	int ret;
-	struct ad7887_state *st = dev_info->dev_data;
+	struct ad7887_state *st = iio_priv(dev_info);
 	unsigned int scale_uv;
 
 	switch (m) {
@@ -118,7 +118,6 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	/* Estabilish that the iio_dev is a child of the spi device */
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->dev_data = (void *)(st);
 	indio_dev->info = &ad7887_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 0e4a5f4..0ac7c0b 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -64,7 +64,7 @@ error_ret:
  **/
 static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct ad7887_state *st = indio_dev->dev_data;
+	struct ad7887_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	st->d_size = ring->scan_count *
@@ -100,7 +100,7 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 
 static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
 {
-	struct ad7887_state *st = indio_dev->dev_data;
+	struct ad7887_state *st = iio_priv(indio_dev);
 
 	/* dummy read: restore default CH0 settin */
 	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
@@ -116,7 +116,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct ad7887_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7887_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
 	__u8 *buf;
-- 
1.7.3.4
