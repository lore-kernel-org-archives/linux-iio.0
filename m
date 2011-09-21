Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/14] staging:iio: replacing term ring with buffer in the IIO core.
Date: Wed, 21 Sep 2011 11:15:57 +0100
Message-Id: <1316600162-15581-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
References: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

They aren't always ring buffers, so just use buffer for all naming.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Makefile                    |    2 +-
 drivers/staging/iio/accel/adis16201_core.c      |   10 +-
 drivers/staging/iio/accel/adis16201_ring.c      |   14 +-
 drivers/staging/iio/accel/adis16203_core.c      |   10 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   14 +-
 drivers/staging/iio/accel/adis16204_core.c      |   10 +-
 drivers/staging/iio/accel/adis16204_ring.c      |   14 +-
 drivers/staging/iio/accel/adis16209_core.c      |   10 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   14 +-
 drivers/staging/iio/accel/adis16240_core.c      |   10 +-
 drivers/staging/iio/accel/adis16240_ring.c      |   14 +-
 drivers/staging/iio/accel/lis3l02dq.h           |    4 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   12 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   30 +-
 drivers/staging/iio/accel/sca3000.h             |    2 +-
 drivers/staging/iio/accel/sca3000_core.c        |   20 +-
 drivers/staging/iio/accel/sca3000_ring.c        |   48 +-
 drivers/staging/iio/adc/ad7192.c                |   44 +-
 drivers/staging/iio/adc/ad7298_core.c           |   12 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   24 +-
 drivers/staging/iio/adc/ad7476_core.c           |   12 +-
 drivers/staging/iio/adc/ad7476_ring.c           |   30 +-
 drivers/staging/iio/adc/ad7606_core.c           |   14 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   24 +-
 drivers/staging/iio/adc/ad7793.c                |   42 +-
 drivers/staging/iio/adc/ad7887_core.c           |   12 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   28 +-
 drivers/staging/iio/adc/ad799x_core.c           |   10 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   30 +-
 drivers/staging/iio/adc/max1363_core.c          |   12 +-
 drivers/staging/iio/adc/max1363_ring.c          |   20 +-
 drivers/staging/iio/buffer_generic.h            |  194 ++++----
 drivers/staging/iio/gyro/adis16260_core.c       |   22 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |   14 +-
 drivers/staging/iio/iio.h                       |   10 +-
 drivers/staging/iio/iio_core.h                  |   24 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   36 +-
 drivers/staging/iio/imu/adis16400_core.c        |   10 +-
 drivers/staging/iio/imu/adis16400_ring.c        |   25 +-
 drivers/staging/iio/industrialio-buffer.c       |  632 +++++++++++++++++++++++
 drivers/staging/iio/industrialio-core.c         |   16 +-
 drivers/staging/iio/industrialio-ring.c         |  631 ----------------------
 drivers/staging/iio/kfifo_buf.c                 |   48 +-
 drivers/staging/iio/kfifo_buf.h                 |    6 +-
 drivers/staging/iio/meter/ade7758_core.c        |    6 +-
 drivers/staging/iio/meter/ade7758_ring.c        |   28 +-
 drivers/staging/iio/ring_hw.h                   |    6 +-
 drivers/staging/iio/ring_sw.c                   |   44 +-
 drivers/staging/iio/ring_sw.h                   |    6 +-
 49 files changed, 1156 insertions(+), 1154 deletions(-)

diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 67a1d9c..788397d 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o
-industrialio-$(CONFIG_IIO_BUFFER) += industrialio-ring.o
+industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
 obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index eb6a1a8..e5364b7 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -492,9 +492,9 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       adis16201_channels,
-				       ARRAY_SIZE(adis16201_channels));
+	ret = iio_buffer_register(indio_dev,
+				  adis16201_channels,
+				  ARRAY_SIZE(adis16201_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -519,7 +519,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16201_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16201_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -533,7 +533,7 @@ static int adis16201_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16201_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 52679b9..dbd8832 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -61,7 +61,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16201_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
@@ -94,11 +94,11 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 void adis16201_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
-static const struct iio_ring_setup_ops adis16201_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops adis16201_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -106,14 +106,14 @@ static const struct iio_ring_setup_ops adis16201_ring_setup_ops = {
 int adis16201_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
@@ -135,6 +135,6 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 561e7a9..34975dc 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -446,9 +446,9 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       adis16203_channels,
-				       ARRAY_SIZE(adis16203_channels));
+	ret = iio_buffer_register(indio_dev,
+				  adis16203_channels,
+				  ARRAY_SIZE(adis16203_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -474,7 +474,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16203_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16203_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -488,7 +488,7 @@ static int adis16203_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16203_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index c694e87..838d301 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -61,7 +61,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16203_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
@@ -96,11 +96,11 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 void adis16203_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
-static const struct iio_ring_setup_ops adis16203_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops adis16203_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -108,14 +108,14 @@ static const struct iio_ring_setup_ops adis16203_ring_setup_ops = {
 int adis16203_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->bpe = 2;
 	ring->scan_timestamp = true;
@@ -138,6 +138,6 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 507f282..7a4c680 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -521,9 +521,9 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       adis16204_channels,
-				       ARRAY_SIZE(adis16204_channels));
+	ret = iio_buffer_register(indio_dev,
+				  adis16204_channels,
+				  ARRAY_SIZE(adis16204_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -548,7 +548,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16204_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16204_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -562,7 +562,7 @@ static int adis16204_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16204_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 8e2a976..08551bb 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -59,7 +59,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16204_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 	size_t datasize = ring->access->get_bytes_per_datum(ring);
@@ -91,11 +91,11 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
-static const struct iio_ring_setup_ops adis16204_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops adis16204_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -103,14 +103,14 @@ static const struct iio_ring_setup_ops adis16204_ring_setup_ops = {
 int adis16204_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
@@ -134,6 +134,6 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 2dd24c3..1824e72 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -494,9 +494,9 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       adis16209_channels,
-				       ARRAY_SIZE(adis16209_channels));
+	ret = iio_buffer_register(indio_dev,
+				  adis16209_channels,
+				  ARRAY_SIZE(adis16209_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -521,7 +521,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16209_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16209_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -537,7 +537,7 @@ static int adis16209_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16209_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index ca2c281..bb66364 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -59,7 +59,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16209_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
@@ -91,11 +91,11 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
-static const struct iio_ring_setup_ops adis16209_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops adis16209_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -103,14 +103,14 @@ static const struct iio_ring_setup_ops adis16209_ring_setup_ops = {
 int adis16209_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
@@ -134,6 +134,6 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 10e0249..6d3194f 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -547,9 +547,9 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       adis16240_channels,
-				       ARRAY_SIZE(adis16240_channels));
+	ret = iio_buffer_register(indio_dev,
+				  adis16240_channels,
+				  ARRAY_SIZE(adis16240_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -573,7 +573,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16240_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16240_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -590,7 +590,7 @@ static int adis16240_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16240_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 6119f4b..34f1e7e 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -56,7 +56,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16240_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 
 	int i = 0;
 	s16 *data;
@@ -88,11 +88,11 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
-static const struct iio_ring_setup_ops adis16240_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops adis16240_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -100,14 +100,14 @@ static const struct iio_ring_setup_ops adis16240_ring_setup_ops = {
 int adis16240_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
@@ -131,6 +131,6 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 5a18f50..6633091 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -181,7 +181,7 @@ int lis3l02dq_disable_all_events(struct iio_dev *indio_dev);
 void lis3l02dq_remove_trigger(struct iio_dev *indio_dev);
 int lis3l02dq_probe_trigger(struct iio_dev *indio_dev);
 
-ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
+ssize_t lis3l02dq_read_accel_from_ring(struct iio_buffer *ring,
 				       int index,
 				       int *val);
 
@@ -213,7 +213,7 @@ static inline int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	return 0;
 }
 static inline ssize_t
-lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
+lis3l02dq_read_accel_from_ring(struct iio_buffer *ring,
 			       int index,
 			       int *val)
 {
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index fd53fd5..c59ca1c 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -260,7 +260,7 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 		/* Take the iio_dev status lock */
 		mutex_lock(&indio_dev->mlock);
 		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-			ret = lis3l02dq_read_accel_from_ring(indio_dev->ring,
+			ret = lis3l02dq_read_accel_from_ring(indio_dev->buffer,
 							     chan->scan_index,
 							     val);
 		else {
@@ -690,9 +690,9 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       lis3l02dq_channels,
-				       ARRAY_SIZE(lis3l02dq_channels));
+	ret = iio_buffer_register(indio_dev,
+				  lis3l02dq_channels,
+				  ARRAY_SIZE(lis3l02dq_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -731,7 +731,7 @@ error_free_interrupt:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(st->us->irq, indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	lis3l02dq_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -785,7 +785,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 		free_irq(st->us->irq, indio_dev);
 
 	lis3l02dq_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_ring(indio_dev);
 
 	iio_device_unregister(indio_dev);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 1f35fdc..1ccfba9 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -40,7 +40,7 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
 /**
  * lis3l02dq_read_accel_from_ring() individual acceleration read from ring
  **/
-ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
+ssize_t lis3l02dq_read_accel_from_ring(struct iio_buffer *ring,
 				       int index,
 				       int *val)
 {
@@ -86,7 +86,7 @@ static const u8 read_all_tx_array[] = {
  **/
 static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 {
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	struct spi_transfer *xfers;
 	struct spi_message msg;
@@ -145,13 +145,13 @@ static int lis3l02dq_get_ring_element(struct iio_dev *indio_dev,
 	u8 *rx_array ;
 	s16 *data = (s16 *)buf;
 
-	rx_array = kzalloc(4 * (indio_dev->ring->scan_count), GFP_KERNEL);
+	rx_array = kzalloc(4 * (indio_dev->buffer->scan_count), GFP_KERNEL);
 	if (rx_array == NULL)
 		return -ENOMEM;
 	ret = lis3l02dq_read_all(indio_dev, rx_array);
 	if (ret < 0)
 		return ret;
-	for (i = 0; i < indio_dev->ring->scan_count; i++)
+	for (i = 0; i < indio_dev->buffer->scan_count; i++)
 		data[i] = combine_8_to_16(rx_array[i*4+1],
 					rx_array[i*4+3]);
 	kfree(rx_array);
@@ -163,7 +163,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int len = 0;
 	size_t datasize = ring->access->get_bytes_per_datum(ring);
 	char *data = kmalloc(datasize, GFP_KERNEL);
@@ -346,7 +346,7 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	lis3l02dq_free_buf(indio_dev->ring);
+	lis3l02dq_free_buf(indio_dev->buffer);
 }
 
 static int lis3l02dq_ring_postenable(struct iio_dev *indio_dev)
@@ -362,17 +362,17 @@ static int lis3l02dq_ring_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_ret;
 
-	if (iio_scan_mask_query(indio_dev->ring, 0)) {
+	if (iio_scan_mask_query(indio_dev->buffer, 0)) {
 		t |= LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE;
 		oneenabled = true;
 	} else
 		t &= ~LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE;
-	if (iio_scan_mask_query(indio_dev->ring, 1)) {
+	if (iio_scan_mask_query(indio_dev->buffer, 1)) {
 		t |= LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE;
 		oneenabled = true;
 	} else
 		t &= ~LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE;
-	if (iio_scan_mask_query(indio_dev->ring, 2)) {
+	if (iio_scan_mask_query(indio_dev->buffer, 2)) {
 		t |= LIS3L02DQ_REG_CTRL_1_AXES_Z_ENABLE;
 		oneenabled = true;
 	} else
@@ -418,8 +418,8 @@ error_ret:
 	return ret;
 }
 
-static const struct iio_ring_setup_ops lis3l02dq_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops lis3l02dq_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &lis3l02dq_ring_postenable,
 	.predisable = &lis3l02dq_ring_predisable,
 };
@@ -427,15 +427,15 @@ static const struct iio_ring_setup_ops lis3l02dq_ring_setup_ops = {
 int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = lis3l02dq_alloc_buf(indio_dev);
 	if (!ring)
 		return -ENOMEM;
 
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &lis3l02dq_access_funcs;
+	indio_dev->buffer->access = &lis3l02dq_access_funcs;
 	ring->bpe = 2;
 
 	ring->scan_timestamp = true;
@@ -459,6 +459,6 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	lis3l02dq_free_buf(indio_dev->ring);
+	lis3l02dq_free_buf(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
index 0dabfad..ad38dd9 100644
--- a/drivers/staging/iio/accel/sca3000.h
+++ b/drivers/staging/iio/accel/sca3000.h
@@ -248,7 +248,7 @@ void sca3000_unconfigure_ring(struct iio_dev *indio_dev);
  * sca3000_ring_int_process() handles ring related event pushing and escalation
  * @val:	the event code
  **/
-void sca3000_ring_int_process(u8 val, struct iio_ring_buffer *ring);
+void sca3000_ring_int_process(u8 val, struct iio_buffer *ring);
 
 #else
 static inline void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 2fe3578..5592b24 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -812,7 +812,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	if (ret)
 		goto done;
 
-	sca3000_ring_int_process(val, indio_dev->ring);
+	sca3000_ring_int_process(val, indio_dev->buffer);
 
 	if (val & SCA3000_INT_STATUS_FREE_FALL)
 		iio_push_event(indio_dev,
@@ -1156,15 +1156,15 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto error_free_dev;
 	regdone = 1;
-	ret = iio_ring_buffer_register(indio_dev,
-				       sca3000_channels,
-				       ARRAY_SIZE(sca3000_channels));
+	ret = iio_buffer_register(indio_dev,
+				  sca3000_channels,
+				  ARRAY_SIZE(sca3000_channels));
 	if (ret < 0)
 		goto error_unregister_dev;
-	if (indio_dev->ring) {
-		iio_scan_mask_set(indio_dev->ring, 0);
-		iio_scan_mask_set(indio_dev->ring, 1);
-		iio_scan_mask_set(indio_dev->ring, 2);
+	if (indio_dev->buffer) {
+		iio_scan_mask_set(indio_dev->buffer, 0);
+		iio_scan_mask_set(indio_dev->buffer, 1);
+		iio_scan_mask_set(indio_dev->buffer, 2);
 	}
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
@@ -1187,7 +1187,7 @@ error_free_irq:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(spi->irq, indio_dev);
 error_unregister_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unregister_dev:
 error_free_dev:
 	if (regdone)
@@ -1228,7 +1228,7 @@ static int sca3000_remove(struct spi_device *spi)
 		return ret;
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(spi->irq, indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	sca3000_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index f519857..4a9a01d 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -81,10 +81,10 @@ error_ret:
  * can only be inferred approximately from ring buffer events such as 50% full
  * and knowledge of when buffer was last emptied.  This is left to userspace.
  **/
-static int sca3000_read_first_n_hw_rb(struct iio_ring_buffer *r,
+static int sca3000_read_first_n_hw_rb(struct iio_buffer *r,
 				      size_t count, char __user *buf)
 {
-	struct iio_hw_ring_buffer *hw_ring = iio_to_hw_ring_buf(r);
+	struct iio_hw_buffer *hw_ring = iio_to_hw_buf(r);
 	struct iio_dev *indio_dev = hw_ring->private;
 	struct sca3000_state *st = iio_priv(indio_dev);
 	u8 *rx;
@@ -134,20 +134,20 @@ error_ret:
 }
 
 /* This is only valid with all 3 elements enabled */
-static int sca3000_ring_get_length(struct iio_ring_buffer *r)
+static int sca3000_ring_get_length(struct iio_buffer *r)
 {
 	return 64;
 }
 
 /* only valid if resolution is kept at 11bits */
-static int sca3000_ring_get_bytes_per_datum(struct iio_ring_buffer *r)
+static int sca3000_ring_get_bytes_per_datum(struct iio_buffer *r)
 {
 	return 6;
 }
 
-static IIO_RING_ENABLE_ATTR;
-static IIO_RING_BYTES_PER_DATUM_ATTR;
-static IIO_RING_LENGTH_ATTR;
+static IIO_BUFFER_ENABLE_ATTR;
+static IIO_BUFFER_BYTES_PER_DATUM_ATTR;
+static IIO_BUFFER_LENGTH_ATTR;
 
 /**
  * sca3000_query_ring_int() is the hardware ring status interrupt enabled
@@ -158,7 +158,7 @@ static ssize_t sca3000_query_ring_int(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret, val;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
@@ -180,7 +180,7 @@ static ssize_t sca3000_set_ring_int(struct device *dev,
 				      const char *buf,
 				      size_t len)
 {
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
 	struct sca3000_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
@@ -222,7 +222,7 @@ static ssize_t sca3000_show_buffer_scale(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
@@ -256,10 +256,10 @@ static struct attribute_group sca3000_ring_attr = {
 	.name = "buffer",
 };
 
-static struct iio_ring_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
+static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
 {
-	struct iio_ring_buffer *buf;
-	struct iio_hw_ring_buffer *ring;
+	struct iio_buffer *buf;
+	struct iio_hw_buffer *ring;
 
 	ring = kzalloc(sizeof *ring, GFP_KERNEL);
 	if (!ring)
@@ -269,17 +269,17 @@ static struct iio_ring_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
 	buf = &ring->buf;
 	buf->stufftoread = 0;
 	buf->attrs = &sca3000_ring_attr;
-	iio_ring_buffer_init(buf, indio_dev);
+	iio_buffer_init(buf, indio_dev);
 
 	return buf;
 }
 
-static inline void sca3000_rb_free(struct iio_ring_buffer *r)
+static inline void sca3000_rb_free(struct iio_buffer *r)
 {
-	kfree(iio_to_hw_ring_buf(r));
+	kfree(iio_to_hw_buf(r));
 }
 
-static const struct iio_ring_access_funcs sca3000_ring_access_funcs = {
+static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
 	.read_first_n = &sca3000_read_first_n_hw_rb,
 	.get_length = &sca3000_ring_get_length,
 	.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum,
@@ -287,19 +287,19 @@ static const struct iio_ring_access_funcs sca3000_ring_access_funcs = {
 
 int sca3000_configure_ring(struct iio_dev *indio_dev)
 {
-	indio_dev->ring = sca3000_rb_allocate(indio_dev);
-	if (indio_dev->ring == NULL)
+	indio_dev->buffer = sca3000_rb_allocate(indio_dev);
+	if (indio_dev->buffer == NULL)
 		return -ENOMEM;
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
-	indio_dev->ring->access = &sca3000_ring_access_funcs;
+	indio_dev->buffer->access = &sca3000_ring_access_funcs;
 
 	return 0;
 }
 
 void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	sca3000_rb_free(indio_dev->ring);
+	sca3000_rb_free(indio_dev->buffer);
 }
 
 static inline
@@ -343,14 +343,14 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	return __sca3000_hw_ring_state_set(indio_dev, 0);
 }
 
-static const struct iio_ring_setup_ops sca3000_ring_setup_ops = {
+static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
 	.preenable = &sca3000_hw_ring_preenable,
 	.postdisable = &sca3000_hw_ring_postdisable,
 };
 
 void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
 {
-	indio_dev->ring->setup_ops = &sca3000_ring_setup_ops;
+	indio_dev->buffer->setup_ops = &sca3000_ring_setup_ops;
 }
 
 /**
@@ -359,7 +359,7 @@ void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
  * This is only split from the main interrupt handler so as to
  * reduce the amount of code if the ring buffer is not enabled.
  **/
-void sca3000_ring_int_process(u8 val, struct iio_ring_buffer *ring)
+void sca3000_ring_int_process(u8 val, struct iio_buffer *ring)
 {
 	if (val & (SCA3000_INT_STATUS_THREE_QUARTERS |
 		   SCA3000_INT_STATUS_HALF)) {
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 8d080ab..67d731b 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -455,7 +455,7 @@ out:
 
 static int ad7192_scan_from_ring(struct ad7192_state *st, unsigned ch, int *val)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
 	int ret;
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
@@ -475,7 +475,7 @@ static int ad7192_scan_from_ring(struct ad7192_state *st, unsigned ch, int *val)
 static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size;
 	unsigned channel;
 
@@ -494,9 +494,9 @@ static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access->set_bytes_per_datum)
-		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
-							     d_size);
+	if (indio_dev->buffer->access->set_bytes_per_datum)
+		indio_dev->buffer->access->
+			set_bytes_per_datum(indio_dev->buffer, d_size);
 
 	st->mode  = (st->mode & ~AD7192_MODE_SEL(-1)) |
 		    AD7192_MODE_SEL(AD7192_MODE_CONT);
@@ -539,7 +539,7 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7192_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -562,7 +562,7 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static const struct iio_ring_setup_ops ad7192_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ad7192_ring_setup_ops = {
 	.preenable = &ad7192_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -573,13 +573,13 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ad7192_trigger_handler,
 						 IRQF_ONESHOT,
@@ -592,14 +592,14 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &ad7192_ring_setup_ops;
+	indio_dev->buffer->setup_ops = &ad7192_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -607,7 +607,7 @@ error_ret:
 static void ad7192_ring_cleanup(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
 /**
@@ -705,7 +705,7 @@ static ssize_t ad7192_write_frequency(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_ring_enabled(indio_dev)) {
+	if (iio_buffer_enabled(indio_dev)) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
@@ -790,7 +790,7 @@ static ssize_t ad7192_set(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_ring_enabled(indio_dev)) {
+	if (iio_buffer_enabled(indio_dev)) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
@@ -872,7 +872,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case 0:
 		mutex_lock(&indio_dev->mlock);
-		if (iio_ring_enabled(indio_dev))
+		if (iio_buffer_enabled(indio_dev))
 			ret = ad7192_scan_from_ring(st,
 					chan->scan_index, &smpl);
 		else
@@ -929,7 +929,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	unsigned int tmp;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_ring_enabled(indio_dev)) {
+	if (iio_buffer_enabled(indio_dev)) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
@@ -1099,9 +1099,9 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       indio_dev->channels,
-				       indio_dev->num_channels);
+	ret = iio_buffer_register(indio_dev,
+				  indio_dev->channels,
+				  indio_dev->num_channels);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -1112,7 +1112,7 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	return 0;
 
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_remove_trigger:
 	ad7192_remove_trigger(indio_dev);
 error_unreg_ring:
@@ -1137,7 +1137,7 @@ static int ad7192_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	ad7192_remove_trigger(indio_dev);
 	ad7192_ring_cleanup(indio_dev);
 
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index cf91ccd..7f08ffa 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -122,7 +122,7 @@ static int ad7298_read_raw(struct iio_dev *dev_info,
 	switch (m) {
 	case 0:
 		mutex_lock(&dev_info->mlock);
-		if (iio_ring_enabled(dev_info)) {
+		if (iio_buffer_enabled(dev_info)) {
 			if (chan->address == AD7298_CH_TEMP)
 				ret = -ENODEV;
 			else
@@ -218,9 +218,9 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       &ad7298_channels[1], /* skip temp0 */
-				       ARRAY_SIZE(ad7298_channels) - 1);
+	ret = iio_buffer_register(indio_dev,
+				  &ad7298_channels[1], /* skip temp0 */
+				  ARRAY_SIZE(ad7298_channels) - 1);
 	if (ret)
 		goto error_cleanup_ring;
 	ret = iio_device_register(indio_dev);
@@ -230,7 +230,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 	return 0;
 
 error_unregister_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	ad7298_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -249,7 +249,7 @@ static int __devexit ad7298_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7298_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	ad7298_ring_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 1cd5f61..d90b6f4 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -20,7 +20,7 @@
 
 int ad7298_scan_from_ring(struct iio_dev *dev_info, long ch)
 {
-	struct iio_ring_buffer *ring = dev_info->ring;
+	struct iio_buffer *ring = dev_info->buffer;
 	int ret;
 	u16 *ring_data;
 
@@ -57,7 +57,7 @@ error_ret:
 static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size;
 	int i, m;
 	unsigned short command;
@@ -119,7 +119,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u16 buf[16];
 	int b_sent, i;
@@ -137,13 +137,13 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	for (i = 0; i < ring->scan_count; i++)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
-	indio_dev->ring->access->store_to(ring, (u8 *)buf, time_ns);
+	indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
 
-static const struct iio_ring_setup_ops ad7298_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ad7298_ring_setup_ops = {
 	.preenable = &ad7298_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -153,13 +153,13 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
 						 &ad7298_trigger_handler,
@@ -174,15 +174,15 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &ad7298_ring_setup_ops;
-	indio_dev->ring->scan_timestamp = true;
+	indio_dev->buffer->setup_ops = &ad7298_ring_setup_ops;
+	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -190,5 +190,5 @@ error_ret:
 void ad7298_ring_cleanup(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index d574a2e..ec75332 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -45,7 +45,7 @@ static int ad7476_read_raw(struct iio_dev *dev_info,
 	switch (m) {
 	case 0:
 		mutex_lock(&dev_info->mlock);
-		if (iio_ring_enabled(dev_info))
+		if (iio_buffer_enabled(dev_info))
 			ret = ad7476_scan_from_ring(dev_info);
 		else
 			ret = ad7476_scan_direct(st);
@@ -179,9 +179,9 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       st->chip_info->channel,
-				       ARRAY_SIZE(st->chip_info->channel));
+	ret = iio_buffer_register(indio_dev,
+				  st->chip_info->channel,
+				  ARRAY_SIZE(st->chip_info->channel));
 	if (ret)
 		goto error_cleanup_ring;
 
@@ -191,7 +191,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	return 0;
 
 error_ring_unregister:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	ad7476_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -211,7 +211,7 @@ static int ad7476_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7476_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	ad7476_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 854d949..e82c1a4 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -22,7 +22,7 @@
 
 int ad7476_scan_from_ring(struct iio_dev *indio_dev)
 {
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int ret;
 	u8 *ring_data;
 
@@ -54,7 +54,7 @@ error_ret:
 static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7476_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 
 	st->d_size = ring->scan_count *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
@@ -66,9 +66,9 @@ static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access->set_bytes_per_datum)
-		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
-							    st->d_size);
+	if (indio_dev->buffer->access->set_bytes_per_datum)
+		indio_dev->buffer->access->
+			set_bytes_per_datum(indio_dev->buffer, st->d_size);
 
 	return 0;
 }
@@ -93,11 +93,11 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 
 	time_ns = iio_get_time_ns();
 
-	if (indio_dev->ring->scan_timestamp)
+	if (indio_dev->buffer->scan_timestamp)
 		memcpy(rxbuf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	indio_dev->ring->access->store_to(indio_dev->ring, rxbuf, time_ns);
+	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
@@ -105,7 +105,7 @@ done:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_ring_setup_ops ad7476_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ad7476_ring_setup_ops = {
 	.preenable = &ad7476_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -116,13 +116,13 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	struct ad7476_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc
 		= iio_alloc_pollfunc(NULL,
 				     &ad7476_trigger_handler,
@@ -137,15 +137,15 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &ad7476_ring_setup_ops;
-	indio_dev->ring->scan_timestamp = true;
+	indio_dev->buffer->setup_ops = &ad7476_ring_setup_ops;
+	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -153,5 +153,5 @@ error_ret:
 void ad7476_ring_cleanup(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index f8eba67..c3ce74c 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -90,7 +90,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case 0:
 		mutex_lock(&indio_dev->mlock);
-		if (iio_ring_enabled(indio_dev))
+		if (iio_buffer_enabled(indio_dev))
 			ret = ad7606_scan_from_ring(indio_dev, chan->address);
 		else
 			ret = ad7606_scan_direct(indio_dev, chan->address);
@@ -416,7 +416,7 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	struct iio_dev *indio_dev = dev_id;
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	if (iio_ring_enabled(indio_dev)) {
+	if (iio_buffer_enabled(indio_dev)) {
 		if (!work_pending(&st->poll_work))
 			schedule_work(&st->poll_work);
 	} else {
@@ -502,9 +502,9 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	if (ret)
 		goto error_free_irq;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       indio_dev->channels,
-				       indio_dev->num_channels);
+	ret = iio_buffer_register(indio_dev,
+				  indio_dev->channels,
+				  indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 	ret = iio_device_register(indio_dev);
@@ -513,7 +513,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 
 	return indio_dev;
 error_unregister_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 
 error_cleanup_ring:
 	ad7606_ring_cleanup(indio_dev);
@@ -539,7 +539,7 @@ int ad7606_remove(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	ad7606_ring_cleanup(indio_dev);
 
 	free_irq(st->irq, indio_dev);
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 20afb3e..0b60a6e 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -20,7 +20,7 @@
 
 int ad7606_scan_from_ring(struct iio_dev *indio_dev, unsigned ch)
 {
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int ret;
 	u16 *ring_data;
 
@@ -52,7 +52,7 @@ error_ret:
 static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size;
 
 	d_size = st->chip_info->num_channels *
@@ -101,7 +101,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
 	int ret;
@@ -140,14 +140,14 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 		memcpy(buf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access->store_to(indio_dev->ring, buf, time_ns);
+	ring->access->store_to(indio_dev->buffer, buf, time_ns);
 done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(buf);
 }
 
-static const struct iio_ring_setup_ops ad7606_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ad7606_ring_setup_ops = {
 	.preenable = &ad7606_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -158,14 +158,14 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&ad7606_trigger_handler_th_bh,
 						 &ad7606_trigger_handler_th_bh,
 						 0,
@@ -180,8 +180,8 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 
 	/* Ring buffer functions - here trigger setup related */
 
-	indio_dev->ring->setup_ops = &ad7606_ring_setup_ops;
-	indio_dev->ring->scan_timestamp = true ;
+	indio_dev->buffer->setup_ops = &ad7606_ring_setup_ops;
+	indio_dev->buffer->scan_timestamp = true ;
 
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
@@ -190,7 +190,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -198,5 +198,5 @@ error_ret:
 void ad7606_ring_cleanup(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 11ba79e..788ee08 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -317,7 +317,7 @@ out:
 
 static int ad7793_scan_from_ring(struct ad7793_state *st, unsigned ch, int *val)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
 	int ret;
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
@@ -337,7 +337,7 @@ static int ad7793_scan_from_ring(struct ad7793_state *st, unsigned ch, int *val)
 static int ad7793_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size;
 	unsigned channel;
 
@@ -357,9 +357,9 @@ static int ad7793_ring_preenable(struct iio_dev *indio_dev)
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access->set_bytes_per_datum)
-		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
-							     d_size);
+	if (indio_dev->buffer->access->set_bytes_per_datum)
+		indio_dev->buffer->access->
+			set_bytes_per_datum(indio_dev->buffer, d_size);
 
 	st->mode  = (st->mode & ~AD7793_MODE_SEL(-1)) |
 		    AD7793_MODE_SEL(AD7793_MODE_CONT);
@@ -405,7 +405,7 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad7793_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
@@ -428,7 +428,7 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static const struct iio_ring_setup_ops ad7793_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ad7793_ring_setup_ops = {
 	.preenable = &ad7793_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -439,13 +439,13 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ad7793_trigger_handler,
 						 IRQF_ONESHOT,
@@ -458,14 +458,14 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &ad7793_ring_setup_ops;
+	indio_dev->buffer->setup_ops = &ad7793_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -473,7 +473,7 @@ error_ret:
 static void ad7793_ring_cleanup(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
 /**
@@ -570,7 +570,7 @@ static ssize_t ad7793_write_frequency(struct device *dev,
 	int i, ret;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_ring_enabled(indio_dev)) {
+	if (iio_buffer_enabled(indio_dev)) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
@@ -647,7 +647,7 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case 0:
 		mutex_lock(&indio_dev->mlock);
-		if (iio_ring_enabled(indio_dev))
+		if (iio_buffer_enabled(indio_dev))
 			ret = ad7793_scan_from_ring(st,
 					chan->scan_index, &smpl);
 		else
@@ -709,7 +709,7 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 	unsigned int tmp;
 
 	mutex_lock(&indio_dev->mlock);
-	if (iio_ring_enabled(indio_dev)) {
+	if (iio_buffer_enabled(indio_dev)) {
 		mutex_unlock(&indio_dev->mlock);
 		return -EBUSY;
 	}
@@ -974,9 +974,9 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       indio_dev->channels,
-				       indio_dev->num_channels);
+	ret = iio_buffer_register(indio_dev,
+				  indio_dev->channels,
+				  indio_dev->num_channels);
 	if (ret)
 		goto error_remove_trigger;
 
@@ -991,7 +991,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	return 0;
 
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_remove_trigger:
 	ad7793_remove_trigger(indio_dev);
 error_unreg_ring:
@@ -1013,7 +1013,7 @@ static int ad7793_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7793_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	ad7793_remove_trigger(indio_dev);
 	ad7793_ring_cleanup(indio_dev);
 
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 4a8ffb5..465d715 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -44,7 +44,7 @@ static int ad7887_read_raw(struct iio_dev *dev_info,
 	switch (m) {
 	case 0:
 		mutex_lock(&dev_info->mlock);
-		if (iio_ring_enabled(dev_info))
+		if (iio_buffer_enabled(dev_info))
 			ret = ad7887_scan_from_ring(st, 1 << chan->address);
 		else
 			ret = ad7887_scan_direct(st, chan->address);
@@ -189,9 +189,9 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       indio_dev->channels,
-				       indio_dev->num_channels);
+	ret = iio_buffer_register(indio_dev,
+				  indio_dev->channels,
+				  indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
@@ -201,7 +201,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 
 	return 0;
 error_unregister_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	ad7887_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -220,7 +220,7 @@ static int ad7887_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7887_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	ad7887_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 96274d6..cb74cad 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -21,7 +21,7 @@
 
 int ad7887_scan_from_ring(struct ad7887_state *st, int channum)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
 	int count = 0, ret;
 	u16 *ring_data;
 
@@ -63,7 +63,7 @@ error_ret:
 static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7887_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 
 	st->d_size = ring->scan_count *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
@@ -75,9 +75,9 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access->set_bytes_per_datum)
-		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
-							    st->d_size);
+	if (indio_dev->buffer->access->set_bytes_per_datum)
+		indio_dev->buffer->access->
+			set_bytes_per_datum(indio_dev->buffer, st->d_size);
 
 	/* We know this is a single long so can 'cheat' */
 	switch (*ring->scan_mask) {
@@ -116,7 +116,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7887_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *buf;
 	int b_sent;
@@ -139,7 +139,7 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 		memcpy(buf + st->d_size - sizeof(s64),
 		       &time_ns, sizeof(time_ns));
 
-	indio_dev->ring->access->store_to(indio_dev->ring, buf, time_ns);
+	indio_dev->buffer->access->store_to(indio_dev->buffer, buf, time_ns);
 done:
 	kfree(buf);
 	iio_trigger_notify_done(indio_dev->trig);
@@ -147,7 +147,7 @@ done:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_ring_setup_ops ad7887_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
 	.preenable = &ad7887_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -158,13 +158,13 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ad7887_trigger_handler,
 						 IRQF_ONESHOT,
@@ -176,14 +176,14 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_deallocate_sw_rb;
 	}
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &ad7887_ring_setup_ops;
+	indio_dev->buffer->setup_ops = &ad7887_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -191,5 +191,5 @@ error_ret:
 void ad7887_ring_cleanup(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index d5fbda7..b8efd59 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -149,7 +149,7 @@ static int ad799x_read_raw(struct iio_dev *dev_info,
 	switch (m) {
 	case 0:
 		mutex_lock(&dev_info->mlock);
-		if (iio_ring_enabled(dev_info))
+		if (iio_buffer_enabled(dev_info))
 			ret = ad799x_single_channel_from_ring(st,
 							      chan->address);
 		else
@@ -701,9 +701,9 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       indio_dev->channels,
-				       indio_dev->num_channels);
+	ret = iio_buffer_register(indio_dev,
+				  indio_dev->channels,
+				  indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
@@ -747,7 +747,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 	if (client->irq > 0)
 		free_irq(client->irq, indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	ad799x_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index c1d38c5..1bcc168 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -25,7 +25,7 @@
 
 int ad799x_single_channel_from_ring(struct ad799x_state *st, int channum)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
 	int count = 0, ret;
 	u16 *ring_data;
 
@@ -62,7 +62,7 @@ error_ret:
  **/
 static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	struct ad799x_state *st = iio_priv(indio_dev);
 
 	/*
@@ -82,9 +82,9 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 			st->d_size += sizeof(s64) - (st->d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access->set_bytes_per_datum)
-		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
-							    st->d_size);
+	if (indio_dev->buffer->access->set_bytes_per_datum)
+		indio_dev->buffer->access->
+			set_bytes_per_datum(indio_dev->buffer, st->d_size);
 
 	return 0;
 }
@@ -101,7 +101,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -142,7 +142,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 		memcpy(rxbuf + st->d_size - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	ring->access->store_to(indio_dev->ring, rxbuf, time_ns);
+	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
 	if (b_sent < 0)
@@ -153,7 +153,7 @@ out:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_ring_setup_ops ad799x_buf_setup_ops = {
+static const struct iio_buffer_setup_ops ad799x_buf_setup_ops = {
 	.preenable = &ad799x_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -163,13 +163,13 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	int ret = 0;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
 						 &ad799x_trigger_handler,
 						 IRQF_ONESHOT,
@@ -183,15 +183,15 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &ad799x_buf_setup_ops;
-	indio_dev->ring->scan_timestamp = true;
+	indio_dev->buffer->setup_ops = &ad799x_buf_setup_ops;
+	indio_dev->buffer->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -199,5 +199,5 @@ error_ret:
 void ad799x_ring_cleanup(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index e0f8791..2abcc32 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -205,7 +205,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	}
 
 	/* If ring buffer capture is occurring, query the buffer */
-	if (iio_ring_enabled(indio_dev)) {
+	if (iio_buffer_enabled(indio_dev)) {
 		mask = max1363_mode_table[chan->address].modemask;
 		data = max1363_single_channel_from_ring(mask, st);
 		if (data < 0) {
@@ -1292,9 +1292,9 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_free_available_scan_masks;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       st->chip_info->channels,
-				       st->chip_info->num_channels);
+	ret = iio_buffer_register(indio_dev,
+				  st->chip_info->channels,
+				  st->chip_info->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
@@ -1318,7 +1318,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 error_free_irq:
 	free_irq(st->client->irq, indio_dev);
 error_uninit_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	max1363_ring_cleanup(indio_dev);
 error_free_available_scan_masks:
@@ -1341,7 +1341,7 @@ static int max1363_remove(struct i2c_client *client)
 
 	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	max1363_ring_cleanup(indio_dev);
 	kfree(indio_dev->available_scan_masks);
 	if (!IS_ERR(reg)) {
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 91e29c5..df6893e 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -23,7 +23,7 @@
 
 int max1363_single_channel_from_ring(const long *mask, struct max1363_state *st)
 {
-	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
+	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
 	int count = 0, ret, index;
 	u8 *ring_data;
 	index = find_first_bit(mask, MAX1363_MAX_CHANNELS);
@@ -68,7 +68,7 @@ error_ret:
 static int max1363_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size = 0;
 	unsigned long numvals;
 
@@ -141,7 +141,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 
 	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
 
-	indio_dev->ring->access->store_to(indio_dev->ring, rxbuf, time_ns);
+	indio_dev->buffer->access->store_to(indio_dev->buffer, rxbuf, time_ns);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	kfree(rxbuf);
@@ -149,7 +149,7 @@ done:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_ring_setup_ops max1363_ring_setup_ops = {
+static const struct iio_buffer_setup_ops max1363_ring_setup_ops = {
 	.postenable = &iio_triggered_buffer_postenable,
 	.preenable = &max1363_ring_preenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -160,8 +160,8 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	struct max1363_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
@@ -177,9 +177,9 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_deallocate_sw_rb;
 	}
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &max1363_ring_setup_ops;
+	indio_dev->buffer->setup_ops = &max1363_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
@@ -187,7 +187,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	return 0;
 
 error_deallocate_sw_rb:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_ret:
 	return ret;
 }
@@ -196,5 +196,5 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
 {
 	/* ensure that the trigger has been detached */
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
diff --git a/drivers/staging/iio/buffer_generic.h b/drivers/staging/iio/buffer_generic.h
index a1256c1..548bb74 100644
--- a/drivers/staging/iio/buffer_generic.h
+++ b/drivers/staging/iio/buffer_generic.h
@@ -1,4 +1,4 @@
-/* The industrial I/O core - generic ring buffer interfaces.
+/* The industrial I/O core - generic buffer interfaces.
  *
  * Copyright (c) 2008 Jonathan Cameron
  *
@@ -15,65 +15,66 @@
 
 #ifdef CONFIG_IIO_BUFFER
 
-struct iio_ring_buffer;
+struct iio_buffer;
 
 /**
- * struct iio_ring_access_funcs - access functions for ring buffers.
+ * struct iio_buffer_access_funcs - access functions for buffers.
  * @mark_in_use:	reference counting, typically to prevent module removal
- * @unmark_in_use:	reduce reference count when no longer using ring buffer
- * @store_to:		actually store stuff to the ring buffer
+ * @unmark_in_use:	reduce reference count when no longer using buffer
+ * @store_to:		actually store stuff to the buffer
  * @read_last:		get the last element stored
  * @read_first_n:	try to get a specified number of elements (must exist)
- * @mark_param_change:	notify ring that some relevant parameter has changed
+ * @mark_param_change:	notify buffer that some relevant parameter has changed
  *			Often this means the underlying storage may need to
  *			change.
  * @request_update:	if a parameter change has been marked, update underlying
  *			storage.
  * @get_bytes_per_datum:get current bytes per datum
  * @set_bytes_per_datum:set number of bytes per datum
- * @get_length:		get number of datums in ring
- * @set_length:		set number of datums in ring
- * @is_enabled:		query if ring is currently being used
- * @enable:		enable the ring
+ * @get_length:		get number of datums in buffer
+ * @set_length:		set number of datums in buffer
+ * @is_enabled:		query if buffer is currently being used
+ * @enable:		enable the buffer
  *
- * The purpose of this structure is to make the ring buffer element
+ * The purpose of this structure is to make the buffer element
  * modular as event for a given driver, different usecases may require
- * different ring designs (space efficiency vs speed for example).
+ * different buffer designs (space efficiency vs speed for example).
  *
- * It is worth noting that a given ring implementation may only support a small
- * proportion of these functions.  The core code 'should' cope fine with any of
- * them not existing.
+ * It is worth noting that a given buffer implementation may only support a
+ * small proportion of these functions.  The core code 'should' cope fine with
+ * any of them not existing.
  **/
-struct iio_ring_access_funcs {
-	void (*mark_in_use)(struct iio_ring_buffer *ring);
-	void (*unmark_in_use)(struct iio_ring_buffer *ring);
+struct iio_buffer_access_funcs {
+	void (*mark_in_use)(struct iio_buffer *buffer);
+	void (*unmark_in_use)(struct iio_buffer *buffer);
 
-	int (*store_to)(struct iio_ring_buffer *ring, u8 *data, s64 timestamp);
-	int (*read_last)(struct iio_ring_buffer *ring, u8 *data);
-	int (*read_first_n)(struct iio_ring_buffer *ring,
+	int (*store_to)(struct iio_buffer *buffer, u8 *data, s64 timestamp);
+	int (*read_last)(struct iio_buffer *buffer, u8 *data);
+	int (*read_first_n)(struct iio_buffer *buffer,
 			    size_t n,
 			    char __user *buf);
 
-	int (*mark_param_change)(struct iio_ring_buffer *ring);
-	int (*request_update)(struct iio_ring_buffer *ring);
+	int (*mark_param_change)(struct iio_buffer *buffer);
+	int (*request_update)(struct iio_buffer *buffer);
 
-	int (*get_bytes_per_datum)(struct iio_ring_buffer *ring);
-	int (*set_bytes_per_datum)(struct iio_ring_buffer *ring, size_t bpd);
-	int (*get_length)(struct iio_ring_buffer *ring);
-	int (*set_length)(struct iio_ring_buffer *ring, int length);
+	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
+	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
+	int (*get_length)(struct iio_buffer *buffer);
+	int (*set_length)(struct iio_buffer *buffer, int length);
 
-	int (*is_enabled)(struct iio_ring_buffer *ring);
-	int (*enable)(struct iio_ring_buffer *ring);
+	int (*is_enabled)(struct iio_buffer *buffer);
+	int (*enable)(struct iio_buffer *buffer);
 };
 
 /**
- * struct iio_ring_setup_ops - buffer setup related callbacks
- * @preenable:		[DRIVER] function to run prior to marking ring enabled
- * @postenable:		[DRIVER] function to run after marking ring enabled
- * @predisable:		[DRIVER] function to run prior to marking ring disabled
- * @postdisable:	[DRIVER] function to run after marking ring disabled
+ * struct iio_buffer_setup_ops - buffer setup related callbacks
+ * @preenable:		[DRIVER] function to run prior to marking buffer enabled
+ * @postenable:		[DRIVER] function to run after marking buffer enabled
+ * @predisable:		[DRIVER] function to run prior to marking buffer
+ *			disabled
+ * @postdisable:	[DRIVER] function to run after marking buffer disabled
  */
-struct iio_ring_setup_ops {
+struct iio_buffer_setup_ops {
 	int				(*preenable)(struct iio_dev *);
 	int				(*postenable)(struct iio_dev *);
 	int				(*predisable)(struct iio_dev *);
@@ -81,11 +82,10 @@ struct iio_ring_setup_ops {
 };
 
 /**
- * struct iio_ring_buffer - general ring buffer structure
- * @dev:		ring buffer device struct
+ * struct iio_buffer - general buffer structure
  * @indio_dev:		industrial I/O device structure
- * @owner:		module that owns the ring buffer (for ref counting)
- * @length:		[DEVICE] number of datums in ring
+ * @owner:		module that owns the buffer (for ref counting)
+ * @length:		[DEVICE] number of datums in buffer
  * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
  * @bpe:		[DEVICE] size of individual channel value
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
@@ -93,11 +93,11 @@ struct iio_ring_setup_ops {
  * @scan_count:	[INTERN] the number of elements in the current scan mode
  * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
  * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
- * @access:		[DRIVER] ring access functions associated with the
+ * @access:		[DRIVER] buffer access functions associated with the
  *			implementation.
  * @flags:		[INTERN] file ops related flags including busy flag.
  **/
-struct iio_ring_buffer {
+struct iio_buffer {
 	struct iio_dev				*indio_dev;
 	struct module				*owner;
 	int					length;
@@ -107,8 +107,8 @@ struct iio_ring_buffer {
 	int					scan_count;
 	long					*scan_mask;
 	bool					scan_timestamp;
-	const struct iio_ring_access_funcs	*access;
-	const struct iio_ring_setup_ops		*setup_ops;
+	const struct iio_buffer_access_funcs	*access;
+	const struct iio_buffer_setup_ops		*setup_ops;
 	struct list_head			scan_el_dev_attr_list;
 	struct attribute_group			scan_el_group;
 	wait_queue_head_t			pollq;
@@ -118,107 +118,109 @@ struct iio_ring_buffer {
 };
 
 /**
- * iio_ring_buffer_init() - Initialize the buffer structure
- * @ring: buffer to be initialized
+ * iio_buffer_init() - Initialize the buffer structure
+ * @buffer: buffer to be initialized
  * @dev_info: the iio device the buffer is assocated with
  **/
-void iio_ring_buffer_init(struct iio_ring_buffer *ring,
+void iio_buffer_init(struct iio_buffer *buffer,
 			  struct iio_dev *dev_info);
 
-void iio_ring_buffer_deinit(struct iio_ring_buffer *ring);
+void iio_buffer_deinit(struct iio_buffer *buffer);
 
 /**
- * __iio_update_ring_buffer() - update common elements of ring buffers
- * @ring:		ring buffer that is the event source
+ * __iio_update_buffer() - update common elements of buffers
+ * @buffer:		buffer that is the event source
  * @bytes_per_datum:	size of individual datum including timestamp
- * @length:		number of datums in ring
+ * @length:		number of datums in buffer
  **/
-static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
-					    int bytes_per_datum, int length)
+static inline void __iio_update_buffer(struct iio_buffer *buffer,
+				       int bytes_per_datum, int length)
 {
-	ring->bytes_per_datum = bytes_per_datum;
-	ring->length = length;
+	buffer->bytes_per_datum = bytes_per_datum;
+	buffer->length = length;
 }
 
-int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit);
+int iio_scan_mask_query(struct iio_buffer *buffer, int bit);
 
 /**
  * iio_scan_mask_set() - set particular bit in the scan mask
- * @ring: the ring buffer whose scan mask we are interested in
+ * @buffer: the buffer whose scan mask we are interested in
  * @bit: the bit to be set.
  **/
-int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit);
+int iio_scan_mask_set(struct iio_buffer *buffer, int bit);
 
-#define to_iio_ring_buffer(d)				\
-	container_of(d, struct iio_ring_buffer, dev)
+#define to_iio_buffer(d)				\
+	container_of(d, struct iio_buffer, dev)
 
 /**
- * iio_ring_buffer_register() - register the buffer with IIO core
+ * iio_buffer_register() - register the buffer with IIO core
  * @indio_dev: device with the buffer to be registered
  **/
-int iio_ring_buffer_register(struct iio_dev *indio_dev,
-			     const struct iio_chan_spec *channels,
-			     int num_channels);
+int iio_buffer_register(struct iio_dev *indio_dev,
+			const struct iio_chan_spec *channels,
+			int num_channels);
 
 /**
- * iio_ring_buffer_unregister() - unregister the buffer from IIO core
+ * iio_buffer_unregister() - unregister the buffer from IIO core
  * @indio_dev: the device with the buffer to be unregistered
  **/
-void iio_ring_buffer_unregister(struct iio_dev *indio_dev);
+void iio_buffer_unregister(struct iio_dev *indio_dev);
 
 /**
- * iio_read_ring_length() - attr func to get number of datums in the buffer
+ * iio_buffer_read_length() - attr func to get number of datums in the buffer
  **/
-ssize_t iio_read_ring_length(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf);
+ssize_t iio_buffer_read_length(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf);
 /**
- * iio_write_ring_length() - attr func to set number of datums in the buffer
+ * iio_buffer_write_length() - attr func to set number of datums in the buffer
  **/
-ssize_t iio_write_ring_length(struct device *dev,
+ssize_t iio_buffer_write_length(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf,
 			      size_t len);
 /**
- * iio_read_ring_bytes_per_datum() - attr for number of bytes in whole datum
+ * iio_buffer_read_bytes_per_datum() - attr for number of bytes in whole datum
  **/
-ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
-			  struct device_attribute *attr,
-			  char *buf);
+ssize_t iio_buffer_read_bytes_per_datum(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
 /**
- * iio_store_ring_enable() - attr to turn the buffer on
+ * iio_buffer_store_enable() - attr to turn the buffer on
  **/
-ssize_t iio_store_ring_enable(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf,
-			      size_t len);
+ssize_t iio_buffer_store_enable(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len);
 /**
- * iio_show_ring_enable() - attr to see if the buffer is on
+ * iio_buffer_show_enable() - attr to see if the buffer is on
  **/
-ssize_t iio_show_ring_enable(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf);
-#define IIO_RING_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
-					 iio_read_ring_length,		\
-					 iio_write_ring_length)
-#define IIO_RING_BYTES_PER_DATUM_ATTR DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,	\
-				      iio_read_ring_bytes_per_datum, NULL)
-#define IIO_RING_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, \
-					 iio_show_ring_enable,		\
-					 iio_store_ring_enable)
-
-int iio_sw_ring_preenable(struct iio_dev *indio_dev);
+ssize_t iio_buffer_show_enable(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf);
+#define IIO_BUFFER_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
+					   iio_buffer_read_length,	\
+					   iio_buffer_write_length)
+#define IIO_BUFFER_BYTES_PER_DATUM_ATTR					\
+	DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,			\
+		    iio_buffer_read_bytes_per_datum, NULL)
+
+#define IIO_BUFFER_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,	\
+					   iio_buffer_show_enable,	\
+					   iio_buffer_store_enable)
+
+int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
 
 #else /* CONFIG_IIO_BUFFER */
 
-static inline int iio_ring_buffer_register(struct iio_dev *indio_dev,
+static inline int iio_buffer_register(struct iio_dev *indio_dev,
 					   struct iio_chan_spec *channels,
 					   int num_channels)
 {
 	return 0;
 }
 
-static inline void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
+static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
 {};
 
 #endif /* CONFIG_IIO_BUFFER */
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 8058d66..2ad43a8 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -625,20 +625,20 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       indio_dev->channels,
-				       ARRAY_SIZE(adis16260_channels_x));
+	ret = iio_buffer_register(indio_dev,
+				  indio_dev->channels,
+				  ARRAY_SIZE(adis16260_channels_x));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
 	}
-	if (indio_dev->ring) {
+	if (indio_dev->buffer) {
 		/* Set default scan mode */
-		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_SUPPLY);
-		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_GYRO);
-		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_AUX_ADC);
-		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_TEMP);
-		iio_scan_mask_set(indio_dev->ring, ADIS16260_SCAN_ANGL);
+		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_SUPPLY);
+		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_GYRO);
+		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_AUX_ADC);
+		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_TEMP);
+		iio_scan_mask_set(indio_dev->buffer, ADIS16260_SCAN_ANGL);
 	}
 	if (spi->irq) {
 		ret = adis16260_probe_trigger(indio_dev);
@@ -659,7 +659,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16260_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16260_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -680,7 +680,7 @@ static int adis16260_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16260_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 7169d92..679c151 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -62,7 +62,7 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16260_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0;
 	s16 *data;
 	size_t datasize = ring->access->get_bytes_per_datum(ring);
@@ -93,11 +93,11 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
-static const struct iio_ring_setup_ops adis16260_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops adis16260_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -105,14 +105,14 @@ static const struct iio_ring_setup_ops adis16260_ring_setup_ops = {
 int adis16260_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
@@ -135,6 +135,6 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 0f657c7..4851d6f 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -276,13 +276,13 @@ struct iio_info {
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
- * @ring:		[DRIVER] any ring buffer present
+ * @buffer:		[DRIVER] any buffer present
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @masklength:		[INTERN] the length of the mask established from
  *			channels
- * @trig:		[INTERN] current device trigger (ring buffer modes)
+ * @trig:		[INTERN] current device trigger (buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @channels:		[DRIVER] channel specification structure table
  * @num_channels:	[DRIVER] number of chanels specified in @channels.
@@ -304,7 +304,7 @@ struct iio_dev {
 
 	struct iio_event_interface	*event_interface;
 
-	struct iio_ring_buffer		*ring;
+	struct iio_buffer		*buffer;
 	struct mutex			mlock;
 
 	unsigned long			*available_scan_masks;
@@ -383,10 +383,10 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
 void iio_free_device(struct iio_dev *dev);
 
 /**
- * iio_ring_enabled() - helper function to test if any form of ring is enabled
+ * iio_buffer_enabled() - helper function to test if the buffer is enabled
  * @dev_info:		IIO device info structure for device
  **/
-static inline bool iio_ring_enabled(struct iio_dev *dev_info)
+static inline bool iio_buffer_enabled(struct iio_dev *dev_info)
 {
 	return dev_info->currentmode
 		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE);
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index a173321..dde9e3e 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -33,27 +33,27 @@ int __iio_add_chan_devattr(const char *postfix,
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
-void iio_chrdev_ring_open(struct iio_dev *indio_dev);
-void iio_chrdev_ring_release(struct iio_dev *indio_dev);
+void iio_chrdev_buffer_open(struct iio_dev *indio_dev);
+void iio_chrdev_buffer_release(struct iio_dev *indio_dev);
 
-unsigned int iio_ring_poll(struct file *filp,
-			   struct poll_table_struct *wait);
-ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
-				    size_t n, loff_t *f_ps);
+unsigned int iio_buffer_poll(struct file *filp,
+			     struct poll_table_struct *wait);
+ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
+				      size_t n, loff_t *f_ps);
 
 
-#define iio_ring_poll_addr (&iio_ring_poll)
-#define iio_ring_read_first_n_outer_addr (&iio_ring_read_first_n_outer)
+#define iio_buffer_poll_addr (&iio_buffer_poll)
+#define iio_buffer_read_first_n_outer_addr (&iio_buffer_read_first_n_outer)
 
 #else
 
-static inline void iio_chrdev_ring_open(struct iio_dev *indio_dev)
+static inline void iio_chrdev_buffer_open(struct iio_dev *indio_dev)
 {}
-static inline void iio_chrdev_ring_release(struct iio_dev *indio_dev)
+static inline void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
 {}
 
-#define iio_ring_poll_addr NULL
-#define iio_ring_read_first_n_outer_addr NULL
+#define iio_buffer_poll_addr NULL
+#define iio_buffer_read_first_n_outer_addr NULL
 
 #endif
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index fb83161..929da9b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -495,7 +495,7 @@ static int ad5933_read_raw(struct iio_dev *dev_info,
 	mutex_lock(&dev_info->mlock);
 	switch (m) {
 	case 0:
-		if (iio_ring_enabled(dev_info)) {
+		if (iio_buffer_enabled(dev_info)) {
 			ret = -EBUSY;
 			goto out;
 		}
@@ -536,7 +536,7 @@ static const struct iio_info ad5933_info = {
 static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size;
 	int ret;
 
@@ -546,9 +546,9 @@ static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 	d_size = ring->scan_count *
 		 ad5933_channels[1].scan_type.storagebits / 8;
 
-	if (indio_dev->ring->access->set_bytes_per_datum)
-		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
-							     d_size);
+	if (indio_dev->buffer->access->set_bytes_per_datum)
+		indio_dev->buffer->access->
+			set_bytes_per_datum(indio_dev->buffer, d_size);
 
 	ret = ad5933_reset(st);
 	if (ret < 0)
@@ -594,7 +594,7 @@ static int ad5933_ring_postdisable(struct iio_dev *indio_dev)
 	return ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
 }
 
-static const struct iio_ring_setup_ops ad5933_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 	.preenable = &ad5933_ring_preenable,
 	.postenable = &ad5933_ring_postenable,
 	.postdisable = &ad5933_ring_postdisable,
@@ -602,15 +602,15 @@ static const struct iio_ring_setup_ops ad5933_ring_setup_ops = {
 
 static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring)
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer)
 		return -ENOMEM;
 
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
 
 	/* Ring buffer functions - here trigger setup related */
-	indio_dev->ring->setup_ops = &ad5933_ring_setup_ops;
+	indio_dev->buffer->setup_ops = &ad5933_ring_setup_ops;
 
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
@@ -622,7 +622,7 @@ static void ad5933_work(struct work_struct *work)
 	struct ad5933_state *st = container_of(work,
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	signed short buf[2];
 	unsigned char status;
 
@@ -728,13 +728,13 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 		goto error_disable_reg;
 
 	/* skip temp0_input, register in0_(real|imag)_raw */
-	ret = iio_ring_buffer_register(indio_dev, &ad5933_channels[1], 2);
+	ret = iio_buffer_register(indio_dev, &ad5933_channels[1], 2);
 	if (ret)
 		goto error_unreg_ring;
 
 	/* enable both REAL and IMAG channels by default */
-	iio_scan_mask_set(indio_dev->ring, 0);
-	iio_scan_mask_set(indio_dev->ring, 1);
+	iio_scan_mask_set(indio_dev->buffer, 0);
+	iio_scan_mask_set(indio_dev->buffer, 1);
 
 	ret = ad5933_setup(st);
 	if (ret)
@@ -747,9 +747,9 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 	return 0;
 
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
@@ -767,8 +767,8 @@ static __devexit int ad5933_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad5933_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_buffer_unregister(indio_dev);
+	iio_sw_rb_free(indio_dev->buffer);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index b041b46..d99c56a 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1045,9 +1045,9 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       st->variant->channels,
-				       st->variant->num_channels);
+	ret = iio_buffer_register(indio_dev,
+				  st->variant->channels,
+				  st->variant->num_channels);
 	if (ret) {
 		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -1073,7 +1073,7 @@ error_remove_trigger:
 	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		adis16400_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16400_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -1093,7 +1093,7 @@ static int adis16400_remove(struct spi_device *spi)
 		goto err_ret;
 
 	adis16400_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 	adis16400_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index a97e1e3..c368245 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -79,13 +79,13 @@ static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 	int i, j = 0, ret;
 	struct spi_transfer *xfers;
 
-	xfers = kzalloc(sizeof(*xfers)*indio_dev->ring->scan_count + 1,
+	xfers = kzalloc(sizeof(*xfers)*indio_dev->buffer->scan_count + 1,
 			GFP_KERNEL);
 	if (xfers == NULL)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array); i++)
-		if (test_bit(i, indio_dev->ring->scan_mask)) {
+		if (test_bit(i, indio_dev->buffer->scan_mask)) {
 			xfers[j].tx_buf = &read_all_tx_array[i];
 			xfers[j].bits_per_word = 16;
 			xfers[j].len = 2;
@@ -96,7 +96,7 @@ static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 	xfers[j].len = 2;
 
 	spi_message_init(&msg);
-	for (j = 0; j < indio_dev->ring->scan_count + 1; j++)
+	for (j = 0; j < indio_dev->buffer->scan_count + 1; j++)
 		spi_message_add_tail(&xfers[j], &msg);
 
 	ret = spi_sync(st->us, &msg);
@@ -113,7 +113,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16400_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int i = 0, j, ret = 0;
 	s16 *data;
 	size_t datasize = ring->access->get_bytes_per_datum(ring);
@@ -137,7 +137,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 			ret = adis16400_spi_read_burst(&indio_dev->dev, st->rx);
 			if (ret < 0)
 				goto err;
-			for (; i < indio_dev->ring->scan_count; i++) {
+			for (; i < indio_dev->buffer->scan_count; i++) {
 				j = __ffs(mask);
 				mask &= ~(1 << j);
 				data[i] = be16_to_cpup(
@@ -148,7 +148,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
-	ring->access->store_to(indio_dev->ring, (u8 *) data, pf->timestamp);
+	ring->access->store_to(indio_dev->buffer, (u8 *) data, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -163,11 +163,11 @@ err:
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
-static const struct iio_ring_setup_ops adis16400_ring_setup_ops = {
-	.preenable = &iio_sw_ring_preenable,
+static const struct iio_buffer_setup_ops adis16400_ring_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
@@ -175,15 +175,14 @@ static const struct iio_ring_setup_ops adis16400_ring_setup_ops = {
 int adis16400_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
-	struct adis16400_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring;
+	struct iio_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
 	if (!ring) {
 		ret = -ENOMEM;
 		return ret;
 	}
-	indio_dev->ring = ring;
+	indio_dev->buffer = ring;
 	/* Effectively select the ring buffer implementation */
 	ring->access = &ring_sw_access_funcs;
 	ring->bpe = 2;
@@ -206,6 +205,6 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
new file mode 100644
index 0000000..c3f57e7
--- /dev/null
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -0,0 +1,632 @@
+/* The industrial I/O core
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Handling of buffer allocation / resizing.
+ *
+ *
+ * Things to look at here.
+ * - Better memory allocation techniques?
+ * - Alternative access techniques?
+ */
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+
+#include "iio.h"
+#include "iio_core.h"
+#include "sysfs.h"
+#include "buffer_generic.h"
+
+static const char * const iio_endian_prefix[] = {
+	[IIO_BE] = "be",
+	[IIO_LE] = "le",
+};
+
+/**
+ * iio_buffer_read_first_n_outer() - chrdev read for buffer access
+ *
+ * This function relies on all buffer implementations having an
+ * iio_buffer as their first element.
+ **/
+ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
+				      size_t n, loff_t *f_ps)
+{
+	struct iio_dev *indio_dev = filp->private_data;
+	struct iio_buffer *rb = indio_dev->buffer;
+
+	if (!rb->access->read_first_n)
+		return -EINVAL;
+	return rb->access->read_first_n(rb, n, buf);
+}
+
+/**
+ * iio_buffer_poll() - poll the buffer to find out if it has data
+ */
+unsigned int iio_buffer_poll(struct file *filp,
+			     struct poll_table_struct *wait)
+{
+	struct iio_dev *indio_dev = filp->private_data;
+	struct iio_buffer *rb = indio_dev->buffer;
+
+	poll_wait(filp, &rb->pollq, wait);
+	if (rb->stufftoread)
+		return POLLIN | POLLRDNORM;
+	/* need a way of knowing if there may be enough data... */
+	return 0;
+}
+
+void iio_chrdev_buffer_open(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *rb = indio_dev->buffer;
+	if (rb && rb->access->mark_in_use)
+		rb->access->mark_in_use(rb);
+}
+
+void iio_chrdev_buffer_release(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *rb = indio_dev->buffer;
+
+	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
+	if (rb->access->unmark_in_use)
+		rb->access->unmark_in_use(rb);
+
+}
+
+void iio_buffer_init(struct iio_buffer *buffer, struct iio_dev *dev_info)
+{
+	buffer->indio_dev = dev_info;
+	init_waitqueue_head(&buffer->pollq);
+}
+EXPORT_SYMBOL(iio_buffer_init);
+
+static ssize_t iio_show_scan_index(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return sprintf(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
+}
+
+static ssize_t iio_show_fixed_type(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	u8 type = this_attr->c->scan_type.endianness;
+
+	if (type == IIO_CPU) {
+		if (__LITTLE_ENDIAN)
+			type = IIO_LE;
+		else
+			type = IIO_BE;
+	}
+	return sprintf(buf, "%s:%c%d/%d>>%u\n",
+		       iio_endian_prefix[type],
+		       this_attr->c->scan_type.sign,
+		       this_attr->c->scan_type.realbits,
+		       this_attr->c->scan_type.storagebits,
+		       this_attr->c->scan_type.shift);
+}
+
+static ssize_t iio_scan_el_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int ret;
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+
+	ret = iio_scan_mask_query(dev_info->buffer,
+				  to_iio_dev_attr(attr)->address);
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "%d\n", ret);
+}
+
+static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
+{
+	clear_bit(bit, buffer->scan_mask);
+	buffer->scan_count--;
+	return 0;
+}
+
+static ssize_t iio_scan_el_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t len)
+{
+	int ret = 0;
+	bool state;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	state = !(buf[0] == '0');
+	mutex_lock(&indio_dev->mlock);
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		ret = -EBUSY;
+		goto error_ret;
+	}
+	ret = iio_scan_mask_query(buffer, this_attr->address);
+	if (ret < 0)
+		goto error_ret;
+	if (!state && ret) {
+		ret = iio_scan_mask_clear(buffer, this_attr->address);
+		if (ret)
+			goto error_ret;
+	} else if (state && !ret) {
+		ret = iio_scan_mask_set(buffer, this_attr->address);
+		if (ret)
+			goto error_ret;
+	}
+
+error_ret:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+
+}
+
+static ssize_t iio_scan_el_ts_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", dev_info->buffer->scan_timestamp);
+}
+
+static ssize_t iio_scan_el_ts_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	bool state;
+
+	state = !(buf[0] == '0');
+	mutex_lock(&indio_dev->mlock);
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		ret = -EBUSY;
+		goto error_ret;
+	}
+	indio_dev->buffer->scan_timestamp = state;
+error_ret:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
+static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	int ret, attrcount = 0;
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	ret = __iio_add_chan_devattr("index",
+				     chan,
+				     &iio_show_scan_index,
+				     NULL,
+				     0,
+				     0,
+				     &indio_dev->dev,
+				     &buffer->scan_el_dev_attr_list);
+	if (ret)
+		goto error_ret;
+	attrcount++;
+	ret = __iio_add_chan_devattr("type",
+				     chan,
+				     &iio_show_fixed_type,
+				     NULL,
+				     0,
+				     0,
+				     &indio_dev->dev,
+				     &buffer->scan_el_dev_attr_list);
+	if (ret)
+		goto error_ret;
+	attrcount++;
+	if (chan->type != IIO_TIMESTAMP)
+		ret = __iio_add_chan_devattr("en",
+					     chan,
+					     &iio_scan_el_show,
+					     &iio_scan_el_store,
+					     chan->scan_index,
+					     0,
+					     &indio_dev->dev,
+					     &buffer->scan_el_dev_attr_list);
+	else
+		ret = __iio_add_chan_devattr("en",
+					     chan,
+					     &iio_scan_el_ts_show,
+					     &iio_scan_el_ts_store,
+					     chan->scan_index,
+					     0,
+					     &indio_dev->dev,
+					     &buffer->scan_el_dev_attr_list);
+	attrcount++;
+	ret = attrcount;
+error_ret:
+	return ret;
+}
+
+static void iio_buffer_remove_and_free_scan_dev_attr(struct iio_dev *indio_dev,
+						     struct iio_dev_attr *p)
+{
+	kfree(p->dev_attr.attr.name);
+	kfree(p);
+}
+
+static void __iio_buffer_attr_cleanup(struct iio_dev *indio_dev)
+{
+	struct iio_dev_attr *p, *n;
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	list_for_each_entry_safe(p, n,
+				 &buffer->scan_el_dev_attr_list, l)
+		iio_buffer_remove_and_free_scan_dev_attr(indio_dev, p);
+}
+
+static const char * const iio_scan_elements_group_name = "scan_elements";
+
+int iio_buffer_register(struct iio_dev *indio_dev,
+			const struct iio_chan_spec *channels,
+			int num_channels)
+{
+	struct iio_dev_attr *p;
+	struct attribute **attr;
+	struct iio_buffer *buffer = indio_dev->buffer;
+	int ret, i, attrn, attrcount, attrcount_orig = 0;
+
+	if (buffer->attrs)
+		indio_dev->groups[indio_dev->groupcounter++] = buffer->attrs;
+
+	if (buffer->scan_el_attrs != NULL) {
+		attr = buffer->scan_el_attrs->attrs;
+		while (*attr++ != NULL)
+			attrcount_orig++;
+	}
+	attrcount = attrcount_orig;
+	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
+	if (channels) {
+		/* new magic */
+		for (i = 0; i < num_channels; i++) {
+			/* Establish necessary mask length */
+			if (channels[i].scan_index >
+			    (int)indio_dev->masklength - 1)
+				indio_dev->masklength
+					= indio_dev->channels[i].scan_index + 1;
+
+			ret = iio_buffer_add_channel_sysfs(indio_dev,
+							 &channels[i]);
+			if (ret < 0)
+				goto error_cleanup_dynamic;
+			attrcount += ret;
+		}
+		if (indio_dev->masklength && buffer->scan_mask == NULL) {
+			buffer->scan_mask
+				= kzalloc(sizeof(*buffer->scan_mask)*
+					  BITS_TO_LONGS(indio_dev->masklength),
+					  GFP_KERNEL);
+			if (buffer->scan_mask == NULL) {
+				ret = -ENOMEM;
+				goto error_cleanup_dynamic;
+			}
+		}
+	}
+
+	buffer->scan_el_group.name = iio_scan_elements_group_name;
+
+	buffer->scan_el_group.attrs
+		= kzalloc(sizeof(buffer->scan_el_group.attrs[0])*
+			  (attrcount + 1),
+			  GFP_KERNEL);
+	if (buffer->scan_el_group.attrs == NULL) {
+		ret = -ENOMEM;
+		goto error_free_scan_mask;
+	}
+	if (buffer->scan_el_attrs)
+		memcpy(buffer->scan_el_group.attrs, buffer->scan_el_attrs,
+		       sizeof(buffer->scan_el_group.attrs[0])*attrcount_orig);
+	attrn = attrcount_orig;
+
+	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
+		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
+	indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
+
+	return 0;
+
+error_free_scan_mask:
+	kfree(buffer->scan_mask);
+error_cleanup_dynamic:
+	__iio_buffer_attr_cleanup(indio_dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(iio_buffer_register);
+
+void iio_buffer_unregister(struct iio_dev *indio_dev)
+{
+	kfree(indio_dev->buffer->scan_mask);
+	kfree(indio_dev->buffer->scan_el_group.attrs);
+	__iio_buffer_attr_cleanup(indio_dev);
+}
+EXPORT_SYMBOL(iio_buffer_unregister);
+
+ssize_t iio_buffer_read_length(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (buffer->access->get_length)
+		return sprintf(buf, "%d\n",
+			       buffer->access->get_length(buffer));
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_buffer_read_length);
+
+ssize_t iio_buffer_write_length(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
+{
+	int ret;
+	ulong val;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	ret = strict_strtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (buffer->access->get_length)
+		if (val == buffer->access->get_length(buffer))
+			return len;
+
+	if (buffer->access->set_length) {
+		buffer->access->set_length(buffer, val);
+		if (buffer->access->mark_param_change)
+			buffer->access->mark_param_change(buffer);
+	}
+
+	return len;
+}
+EXPORT_SYMBOL(iio_buffer_write_length);
+
+ssize_t iio_buffer_read_bytes_per_datum(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+
+	if (buffer->access->get_bytes_per_datum)
+		return sprintf(buf, "%d\n",
+			       buffer->access->get_bytes_per_datum(buffer));
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_buffer_read_bytes_per_datum);
+
+ssize_t iio_buffer_store_enable(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
+{
+	int ret;
+	bool requested_state, current_state;
+	int previous_mode;
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct iio_buffer *buffer = dev_info->buffer;
+
+	mutex_lock(&dev_info->mlock);
+	previous_mode = dev_info->currentmode;
+	requested_state = !(buf[0] == '0');
+	current_state = !!(previous_mode & INDIO_ALL_BUFFER_MODES);
+	if (current_state == requested_state) {
+		printk(KERN_INFO "iio-buffer, current state requested again\n");
+		goto done;
+	}
+	if (requested_state) {
+		if (buffer->setup_ops->preenable) {
+			ret = buffer->setup_ops->preenable(dev_info);
+			if (ret) {
+				printk(KERN_ERR
+				       "Buffer not started:"
+				       "buffer preenable failed\n");
+				goto error_ret;
+			}
+		}
+		if (buffer->access->request_update) {
+			ret = buffer->access->request_update(buffer);
+			if (ret) {
+				printk(KERN_INFO
+				       "Buffer not started:"
+				       "buffer parameter update failed\n");
+				goto error_ret;
+			}
+		}
+		if (buffer->access->mark_in_use)
+			buffer->access->mark_in_use(buffer);
+		/* Definitely possible for devices to support both of these.*/
+		if (dev_info->modes & INDIO_BUFFER_TRIGGERED) {
+			if (!dev_info->trig) {
+				printk(KERN_INFO
+				       "Buffer not started: no trigger\n");
+				ret = -EINVAL;
+				if (buffer->access->unmark_in_use)
+					buffer->access->unmark_in_use(buffer);
+				goto error_ret;
+			}
+			dev_info->currentmode = INDIO_BUFFER_TRIGGERED;
+		} else if (dev_info->modes & INDIO_BUFFER_HARDWARE)
+			dev_info->currentmode = INDIO_BUFFER_HARDWARE;
+		else { /* should never be reached */
+			ret = -EINVAL;
+			goto error_ret;
+		}
+
+		if (buffer->setup_ops->postenable) {
+			ret = buffer->setup_ops->postenable(dev_info);
+			if (ret) {
+				printk(KERN_INFO
+				       "Buffer not started:"
+				       "postenable failed\n");
+				if (buffer->access->unmark_in_use)
+					buffer->access->unmark_in_use(buffer);
+				dev_info->currentmode = previous_mode;
+				if (buffer->setup_ops->postdisable)
+					buffer->setup_ops->
+						postdisable(dev_info);
+				goto error_ret;
+			}
+		}
+	} else {
+		if (buffer->setup_ops->predisable) {
+			ret = buffer->setup_ops->predisable(dev_info);
+			if (ret)
+				goto error_ret;
+		}
+		if (buffer->access->unmark_in_use)
+			buffer->access->unmark_in_use(buffer);
+		dev_info->currentmode = INDIO_DIRECT_MODE;
+		if (buffer->setup_ops->postdisable) {
+			ret = buffer->setup_ops->postdisable(dev_info);
+			if (ret)
+				goto error_ret;
+		}
+	}
+done:
+	mutex_unlock(&dev_info->mlock);
+	return len;
+
+error_ret:
+	mutex_unlock(&dev_info->mlock);
+	return ret;
+}
+EXPORT_SYMBOL(iio_buffer_store_enable);
+
+ssize_t iio_buffer_show_enable(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", !!(dev_info->currentmode
+				       & INDIO_ALL_BUFFER_MODES));
+}
+EXPORT_SYMBOL(iio_buffer_show_enable);
+
+int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	size_t size;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	/* Check if there are any scan elements enabled, if not fail*/
+	if (!(buffer->scan_count || buffer->scan_timestamp))
+		return -EINVAL;
+	if (buffer->scan_timestamp)
+		if (buffer->scan_count)
+			/* Timestamp (aligned to s64) and data */
+			size = (((buffer->scan_count * buffer->bpe)
+					+ sizeof(s64) - 1)
+				& ~(sizeof(s64) - 1))
+				+ sizeof(s64);
+		else /* Timestamp only  */
+			size = sizeof(s64);
+	else /* Data only */
+		size = buffer->scan_count * buffer->bpe;
+	buffer->access->set_bytes_per_datum(buffer, size);
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_sw_buffer_preenable);
+
+
+/* note NULL used as error indicator as it doesn't make sense. */
+static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
+					  unsigned int masklength,
+					  unsigned long *mask)
+{
+	if (bitmap_empty(mask, masklength))
+		return NULL;
+	while (*av_masks) {
+		if (bitmap_subset(mask, av_masks, masklength))
+			return av_masks;
+		av_masks += BITS_TO_LONGS(masklength);
+	}
+	return NULL;
+}
+
+/**
+ * iio_scan_mask_set() - set particular bit in the scan mask
+ * @buffer: the buffer whose scan mask we are interested in
+ * @bit: the bit to be set.
+ **/
+int iio_scan_mask_set(struct iio_buffer *buffer, int bit)
+{
+	struct iio_dev *dev_info = buffer->indio_dev;
+	unsigned long *mask;
+	unsigned long *trialmask;
+
+	trialmask = kmalloc(sizeof(*trialmask)*
+			    BITS_TO_LONGS(dev_info->masklength),
+			    GFP_KERNEL);
+
+	if (trialmask == NULL)
+		return -ENOMEM;
+	if (!dev_info->masklength) {
+		WARN_ON("trying to set scanmask prior to registering buffer\n");
+		kfree(trialmask);
+		return -EINVAL;
+	}
+	bitmap_copy(trialmask, buffer->scan_mask, dev_info->masklength);
+	set_bit(bit, trialmask);
+
+	if (dev_info->available_scan_masks) {
+		mask = iio_scan_mask_match(dev_info->available_scan_masks,
+					   dev_info->masklength,
+					   trialmask);
+		if (!mask) {
+			kfree(trialmask);
+			return -EINVAL;
+		}
+	}
+	bitmap_copy(buffer->scan_mask, trialmask, dev_info->masklength);
+	buffer->scan_count++;
+
+	kfree(trialmask);
+
+	return 0;
+};
+EXPORT_SYMBOL_GPL(iio_scan_mask_set);
+
+int iio_scan_mask_query(struct iio_buffer *buffer, int bit)
+{
+	struct iio_dev *dev_info = buffer->indio_dev;
+	long *mask;
+
+	if (bit > dev_info->masklength)
+		return -EINVAL;
+
+	if (!buffer->scan_mask)
+		return 0;
+	if (dev_info->available_scan_masks)
+		mask = iio_scan_mask_match(dev_info->available_scan_masks,
+					   dev_info->masklength,
+					   buffer->scan_mask);
+	else
+		mask = buffer->scan_mask;
+	if (!mask)
+		return 0;
+
+	return test_bit(bit, mask);
+};
+EXPORT_SYMBOL_GPL(iio_scan_mask_query);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index bfbfcdd..b11c7f3 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1058,23 +1058,23 @@ void iio_free_device(struct iio_dev *dev)
 EXPORT_SYMBOL(iio_free_device);
 
 /**
- * iio_chrdev_open() - chrdev file open for ring buffer access and ioctls
+ * iio_chrdev_open() - chrdev file open for buffer access and ioctls
  **/
 static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
 	struct iio_dev *dev_info = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
 	filp->private_data = dev_info;
-	iio_chrdev_ring_open(dev_info);
+	iio_chrdev_buffer_open(dev_info);
 	return 0;
 }
 
 /**
- * iio_chrdev_release() - chrdev file close ring buffer access and ioctls
+ * iio_chrdev_release() - chrdev file close buffer access and ioctls
  **/
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
-	iio_chrdev_ring_release(container_of(inode->i_cdev,
+	iio_chrdev_buffer_release(container_of(inode->i_cdev,
 					     struct iio_dev, chrdev));
 	return 0;
 }
@@ -1096,11 +1096,11 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
-static const struct file_operations iio_ring_fileops = {
-	.read = iio_ring_read_first_n_outer_addr,
+static const struct file_operations iio_buffer_fileops = {
+	.read = iio_buffer_read_first_n_outer_addr,
 	.release = iio_chrdev_release,
 	.open = iio_chrdev_open,
-	.poll = iio_ring_poll_addr,
+	.poll = iio_buffer_poll_addr,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 	.unlocked_ioctl = iio_ioctl,
@@ -1132,7 +1132,7 @@ int iio_device_register(struct iio_dev *dev_info)
 	ret = device_add(&dev_info->dev);
 	if (ret < 0)
 		goto error_unreg_eventset;
-	cdev_init(&dev_info->chrdev, &iio_ring_fileops);
+	cdev_init(&dev_info->chrdev, &iio_buffer_fileops);
 	dev_info->chrdev.owner = dev_info->info->driver_module;
 	ret = cdev_add(&dev_info->chrdev, dev_info->dev.devt, 1);
 	if (ret < 0)
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
deleted file mode 100644
index 6f9d9e7..0000000
--- a/drivers/staging/iio/industrialio-ring.c
+++ /dev/null
@@ -1,631 +0,0 @@
-/* The industrial I/O core
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * Handling of ring allocation / resizing.
- *
- *
- * Things to look at here.
- * - Better memory allocation techniques?
- * - Alternative access techniques?
- */
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/fs.h>
-#include <linux/cdev.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-
-#include "iio.h"
-#include "iio_core.h"
-#include "sysfs.h"
-#include "buffer_generic.h"
-
-static const char * const iio_endian_prefix[] = {
-	[IIO_BE] = "be",
-	[IIO_LE] = "le",
-};
-
-/**
- * iio_ring_read_first_n_outer() - chrdev read for ring buffer access
- *
- * This function relies on all ring buffer implementations having an
- * iio_ring _bufer as their first element.
- **/
-ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
-				    size_t n, loff_t *f_ps)
-{
-	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_ring_buffer *rb = indio_dev->ring;
-
-	if (!rb->access->read_first_n)
-		return -EINVAL;
-	return rb->access->read_first_n(rb, n, buf);
-}
-
-/**
- * iio_ring_poll() - poll the ring to find out if it has data
- */
-unsigned int iio_ring_poll(struct file *filp,
-			   struct poll_table_struct *wait)
-{
-	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_ring_buffer *rb = indio_dev->ring;
-
-	poll_wait(filp, &rb->pollq, wait);
-	if (rb->stufftoread)
-		return POLLIN | POLLRDNORM;
-	/* need a way of knowing if there may be enough data... */
-	return 0;
-}
-
-void iio_chrdev_ring_open(struct iio_dev *indio_dev)
-{
-	struct iio_ring_buffer *rb = indio_dev->ring;
-	if (rb && rb->access->mark_in_use)
-		rb->access->mark_in_use(rb);
-}
-
-void iio_chrdev_ring_release(struct iio_dev *indio_dev)
-{
-	struct iio_ring_buffer *rb = indio_dev->ring;
-
-	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
-	if (rb->access->unmark_in_use)
-		rb->access->unmark_in_use(rb);
-
-}
-
-void iio_ring_buffer_init(struct iio_ring_buffer *ring,
-			  struct iio_dev *dev_info)
-{
-	ring->indio_dev = dev_info;
-	init_waitqueue_head(&ring->pollq);
-}
-EXPORT_SYMBOL(iio_ring_buffer_init);
-
-static ssize_t iio_show_scan_index(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	return sprintf(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
-}
-
-static ssize_t iio_show_fixed_type(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 type = this_attr->c->scan_type.endianness;
-
-	if (type == IIO_CPU) {
-		if (__LITTLE_ENDIAN)
-			type = IIO_LE;
-		else
-			type = IIO_BE;
-	}
-	return sprintf(buf, "%s:%c%d/%d>>%u\n",
-		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.shift);
-}
-
-static ssize_t iio_scan_el_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	int ret;
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-
-	ret = iio_scan_mask_query(dev_info->ring,
-				  to_iio_dev_attr(attr)->address);
-	if (ret < 0)
-		return ret;
-	return sprintf(buf, "%d\n", ret);
-}
-
-static int iio_scan_mask_clear(struct iio_ring_buffer *ring, int bit)
-{
-	clear_bit(bit, ring->scan_mask);
-	ring->scan_count--;
-	return 0;
-}
-
-static ssize_t iio_scan_el_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t len)
-{
-	int ret = 0;
-	bool state;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	state = !(buf[0] == '0');
-	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-	ret = iio_scan_mask_query(ring, this_attr->address);
-	if (ret < 0)
-		goto error_ret;
-	if (!state && ret) {
-		ret = iio_scan_mask_clear(ring, this_attr->address);
-		if (ret)
-			goto error_ret;
-	} else if (state && !ret) {
-		ret = iio_scan_mask_set(ring, this_attr->address);
-		if (ret)
-			goto error_ret;
-	}
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-
-}
-
-static ssize_t iio_scan_el_ts_show(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", dev_info->ring->scan_timestamp);
-}
-
-static ssize_t iio_scan_el_ts_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
-{
-	int ret = 0;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	bool state;
-
-	state = !(buf[0] == '0');
-	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-	indio_dev->ring->scan_timestamp = state;
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
-
-static int iio_ring_add_channel_sysfs(struct iio_dev *indio_dev,
-				      const struct iio_chan_spec *chan)
-{
-	int ret, attrcount = 0;
-	struct iio_ring_buffer *ring = indio_dev->ring;
-
-	ret = __iio_add_chan_devattr("index",
-				     chan,
-				     &iio_show_scan_index,
-				     NULL,
-				     0,
-				     0,
-				     &indio_dev->dev,
-				     &ring->scan_el_dev_attr_list);
-	if (ret)
-		goto error_ret;
-	attrcount++;
-	ret = __iio_add_chan_devattr("type",
-				     chan,
-				     &iio_show_fixed_type,
-				     NULL,
-				     0,
-				     0,
-				     &indio_dev->dev,
-				     &ring->scan_el_dev_attr_list);
-	if (ret)
-		goto error_ret;
-	attrcount++;
-	if (chan->type != IIO_TIMESTAMP)
-		ret = __iio_add_chan_devattr("en",
-					     chan,
-					     &iio_scan_el_show,
-					     &iio_scan_el_store,
-					     chan->scan_index,
-					     0,
-					     &indio_dev->dev,
-					     &ring->scan_el_dev_attr_list);
-	else
-		ret = __iio_add_chan_devattr("en",
-					     chan,
-					     &iio_scan_el_ts_show,
-					     &iio_scan_el_ts_store,
-					     chan->scan_index,
-					     0,
-					     &indio_dev->dev,
-					     &ring->scan_el_dev_attr_list);
-	attrcount++;
-	ret = attrcount;
-error_ret:
-	return ret;
-}
-
-static void iio_ring_remove_and_free_scan_dev_attr(struct iio_dev *indio_dev,
-						   struct iio_dev_attr *p)
-{
-	kfree(p->dev_attr.attr.name);
-	kfree(p);
-}
-
-static void __iio_ring_attr_cleanup(struct iio_dev *indio_dev)
-{
-	struct iio_dev_attr *p, *n;
-	struct iio_ring_buffer *ring = indio_dev->ring;
-
-	list_for_each_entry_safe(p, n,
-				 &ring->scan_el_dev_attr_list, l)
-		iio_ring_remove_and_free_scan_dev_attr(indio_dev, p);
-}
-
-static const char * const iio_scan_elements_group_name = "scan_elements";
-
-int iio_ring_buffer_register(struct iio_dev *indio_dev,
-			     const struct iio_chan_spec *channels,
-			     int num_channels)
-{
-	struct iio_dev_attr *p;
-	struct attribute **attr;
-	struct iio_ring_buffer *ring = indio_dev->ring;
-	int ret, i, attrn, attrcount, attrcount_orig = 0;
-
-	if (ring->attrs)
-		indio_dev->groups[indio_dev->groupcounter++] = ring->attrs;
-
-	if (ring->scan_el_attrs != NULL) {
-		attr = ring->scan_el_attrs->attrs;
-		while (*attr++ != NULL)
-			attrcount_orig++;
-	}
-	attrcount = attrcount_orig;
-	INIT_LIST_HEAD(&ring->scan_el_dev_attr_list);
-	if (channels) {
-		/* new magic */
-		for (i = 0; i < num_channels; i++) {
-			/* Establish necessary mask length */
-			if (channels[i].scan_index >
-			    (int)indio_dev->masklength - 1)
-				indio_dev->masklength
-					= indio_dev->channels[i].scan_index + 1;
-
-			ret = iio_ring_add_channel_sysfs(indio_dev,
-							 &channels[i]);
-			if (ret < 0)
-				goto error_cleanup_dynamic;
-			attrcount += ret;
-		}
-		if (indio_dev->masklength && ring->scan_mask == NULL) {
-			ring->scan_mask
-				= kzalloc(sizeof(*ring->scan_mask)*
-					  BITS_TO_LONGS(indio_dev->masklength),
-					  GFP_KERNEL);
-			if (ring->scan_mask == NULL) {
-				ret = -ENOMEM;
-				goto error_cleanup_dynamic;
-			}
-		}
-	}
-
-	ring->scan_el_group.name = iio_scan_elements_group_name;
-
-	ring->scan_el_group.attrs
-		= kzalloc(sizeof(ring->scan_el_group.attrs[0])*(attrcount + 1),
-			  GFP_KERNEL);
-	if (ring->scan_el_group.attrs == NULL) {
-		ret = -ENOMEM;
-		goto error_free_scan_mask;
-	}
-	if (ring->scan_el_attrs)
-		memcpy(ring->scan_el_group.attrs, ring->scan_el_attrs,
-		       sizeof(ring->scan_el_group.attrs[0])*attrcount_orig);
-	attrn = attrcount_orig;
-
-	list_for_each_entry(p, &ring->scan_el_dev_attr_list, l)
-		ring->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
-	indio_dev->groups[indio_dev->groupcounter++] = &ring->scan_el_group;
-
-	return 0;
-
-error_free_scan_mask:
-	kfree(ring->scan_mask);
-error_cleanup_dynamic:
-	__iio_ring_attr_cleanup(indio_dev);
-
-	return ret;
-}
-EXPORT_SYMBOL(iio_ring_buffer_register);
-
-void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
-{
-	kfree(indio_dev->ring->scan_mask);
-	kfree(indio_dev->ring->scan_el_group.attrs);
-	__iio_ring_attr_cleanup(indio_dev);
-}
-EXPORT_SYMBOL(iio_ring_buffer_unregister);
-
-ssize_t iio_read_ring_length(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
-
-	if (ring->access->get_length)
-		return sprintf(buf, "%d\n",
-			       ring->access->get_length(ring));
-
-	return 0;
-}
-EXPORT_SYMBOL(iio_read_ring_length);
-
-ssize_t iio_write_ring_length(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf,
-			       size_t len)
-{
-	int ret;
-	ulong val;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
-
-	ret = strict_strtoul(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	if (ring->access->get_length)
-		if (val == ring->access->get_length(ring))
-			return len;
-
-	if (ring->access->set_length) {
-		ring->access->set_length(ring, val);
-		if (ring->access->mark_param_change)
-			ring->access->mark_param_change(ring);
-	}
-
-	return len;
-}
-EXPORT_SYMBOL(iio_write_ring_length);
-
-ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
-			  struct device_attribute *attr,
-			  char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
-
-	if (ring->access->get_bytes_per_datum)
-		return sprintf(buf, "%d\n",
-			       ring->access->get_bytes_per_datum(ring));
-
-	return 0;
-}
-EXPORT_SYMBOL(iio_read_ring_bytes_per_datum);
-
-ssize_t iio_store_ring_enable(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf,
-			      size_t len)
-{
-	int ret;
-	bool requested_state, current_state;
-	int previous_mode;
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct iio_ring_buffer *ring = dev_info->ring;
-
-	mutex_lock(&dev_info->mlock);
-	previous_mode = dev_info->currentmode;
-	requested_state = !(buf[0] == '0');
-	current_state = !!(previous_mode & INDIO_ALL_BUFFER_MODES);
-	if (current_state == requested_state) {
-		printk(KERN_INFO "iio-ring, current state requested again\n");
-		goto done;
-	}
-	if (requested_state) {
-		if (ring->setup_ops->preenable) {
-			ret = ring->setup_ops->preenable(dev_info);
-			if (ret) {
-				printk(KERN_ERR
-				       "Buffer not started:"
-				       "ring preenable failed\n");
-				goto error_ret;
-			}
-		}
-		if (ring->access->request_update) {
-			ret = ring->access->request_update(ring);
-			if (ret) {
-				printk(KERN_INFO
-				       "Buffer not started:"
-				       "ring parameter update failed\n");
-				goto error_ret;
-			}
-		}
-		if (ring->access->mark_in_use)
-			ring->access->mark_in_use(ring);
-		/* Definitely possible for devices to support both of these.*/
-		if (dev_info->modes & INDIO_BUFFER_TRIGGERED) {
-			if (!dev_info->trig) {
-				printk(KERN_INFO
-				       "Buffer not started: no trigger\n");
-				ret = -EINVAL;
-				if (ring->access->unmark_in_use)
-					ring->access->unmark_in_use(ring);
-				goto error_ret;
-			}
-			dev_info->currentmode = INDIO_BUFFER_TRIGGERED;
-		} else if (dev_info->modes & INDIO_BUFFER_HARDWARE)
-			dev_info->currentmode = INDIO_BUFFER_HARDWARE;
-		else { /* should never be reached */
-			ret = -EINVAL;
-			goto error_ret;
-		}
-
-		if (ring->setup_ops->postenable) {
-			ret = ring->setup_ops->postenable(dev_info);
-			if (ret) {
-				printk(KERN_INFO
-				       "Buffer not started:"
-				       "postenable failed\n");
-				if (ring->access->unmark_in_use)
-					ring->access->unmark_in_use(ring);
-				dev_info->currentmode = previous_mode;
-				if (ring->setup_ops->postdisable)
-					ring->setup_ops->postdisable(dev_info);
-				goto error_ret;
-			}
-		}
-	} else {
-		if (ring->setup_ops->predisable) {
-			ret = ring->setup_ops->predisable(dev_info);
-			if (ret)
-				goto error_ret;
-		}
-		if (ring->access->unmark_in_use)
-			ring->access->unmark_in_use(ring);
-		dev_info->currentmode = INDIO_DIRECT_MODE;
-		if (ring->setup_ops->postdisable) {
-			ret = ring->setup_ops->postdisable(dev_info);
-			if (ret)
-				goto error_ret;
-		}
-	}
-done:
-	mutex_unlock(&dev_info->mlock);
-	return len;
-
-error_ret:
-	mutex_unlock(&dev_info->mlock);
-	return ret;
-}
-EXPORT_SYMBOL(iio_store_ring_enable);
-
-ssize_t iio_show_ring_enable(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", !!(dev_info->currentmode
-				       & INDIO_ALL_BUFFER_MODES));
-}
-EXPORT_SYMBOL(iio_show_ring_enable);
-
-int iio_sw_ring_preenable(struct iio_dev *indio_dev)
-{
-	struct iio_ring_buffer *ring = indio_dev->ring;
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(ring->scan_count || ring->scan_timestamp))
-		return -EINVAL;
-	if (ring->scan_timestamp)
-		if (ring->scan_count)
-			/* Timestamp (aligned to s64) and data */
-			size = (((ring->scan_count * ring->bpe)
-					+ sizeof(s64) - 1)
-				& ~(sizeof(s64) - 1))
-				+ sizeof(s64);
-		else /* Timestamp only  */
-			size = sizeof(s64);
-	else /* Data only */
-		size = ring->scan_count * ring->bpe;
-	ring->access->set_bytes_per_datum(ring, size);
-
-	return 0;
-}
-EXPORT_SYMBOL(iio_sw_ring_preenable);
-
-
-/* note NULL used as error indicator as it doesn't make sense. */
-static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
-					  unsigned int masklength,
-					  unsigned long *mask)
-{
-	if (bitmap_empty(mask, masklength))
-		return NULL;
-	while (*av_masks) {
-		if (bitmap_subset(mask, av_masks, masklength))
-			return av_masks;
-		av_masks += BITS_TO_LONGS(masklength);
-	}
-	return NULL;
-}
-
-/**
- * iio_scan_mask_set() - set particular bit in the scan mask
- * @ring: the ring buffer whose scan mask we are interested in
- * @bit: the bit to be set.
- **/
-int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit)
-{
-	struct iio_dev *dev_info = ring->indio_dev;
-	unsigned long *mask;
-	unsigned long *trialmask;
-
-	trialmask = kmalloc(sizeof(*trialmask)*
-			    BITS_TO_LONGS(dev_info->masklength),
-			    GFP_KERNEL);
-
-	if (trialmask == NULL)
-		return -ENOMEM;
-	if (!dev_info->masklength) {
-		WARN_ON("trying to set scan mask prior to registering ring\n");
-		kfree(trialmask);
-		return -EINVAL;
-	}
-	bitmap_copy(trialmask, ring->scan_mask, dev_info->masklength);
-	set_bit(bit, trialmask);
-
-	if (dev_info->available_scan_masks) {
-		mask = iio_scan_mask_match(dev_info->available_scan_masks,
-					   dev_info->masklength,
-					   trialmask);
-		if (!mask) {
-			kfree(trialmask);
-			return -EINVAL;
-		}
-	}
-	bitmap_copy(ring->scan_mask, trialmask, dev_info->masklength);
-	ring->scan_count++;
-
-	kfree(trialmask);
-
-	return 0;
-};
-EXPORT_SYMBOL_GPL(iio_scan_mask_set);
-
-int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit)
-{
-	struct iio_dev *dev_info = ring->indio_dev;
-	long *mask;
-
-	if (bit > dev_info->masklength)
-		return -EINVAL;
-
-	if (!ring->scan_mask)
-		return 0;
-	if (dev_info->available_scan_masks)
-		mask = iio_scan_mask_match(dev_info->available_scan_masks,
-					   dev_info->masklength,
-					   ring->scan_mask);
-	else
-		mask = ring->scan_mask;
-	if (!mask)
-		return 0;
-
-	return test_bit(bit, mask);
-};
-EXPORT_SYMBOL_GPL(iio_scan_mask_query);
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index 39b05855..e8c234b 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -9,14 +9,14 @@
 #include "kfifo_buf.h"
 
 struct iio_kfifo {
-	struct iio_ring_buffer ring;
+	struct iio_buffer buffer;
 	struct kfifo kf;
 	int use_count;
 	int update_needed;
 	struct mutex use_lock;
 };
 
-#define iio_to_kfifo(r) container_of(r, struct iio_kfifo, ring)
+#define iio_to_kfifo(r) container_of(r, struct iio_kfifo, buffer)
 
 static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 				int bytes_per_datum, int length)
@@ -24,11 +24,11 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
 
-	__iio_update_ring_buffer(&buf->ring, bytes_per_datum, length);
+	__iio_update_buffer(&buf->buffer, bytes_per_datum, length);
 	return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
 }
 
-static int iio_request_update_kfifo(struct iio_ring_buffer *r)
+static int iio_request_update_kfifo(struct iio_buffer *r)
 {
 	int ret = 0;
 	struct iio_kfifo *buf = iio_to_kfifo(r);
@@ -41,14 +41,14 @@ static int iio_request_update_kfifo(struct iio_ring_buffer *r)
 		goto error_ret;
 	}
 	kfifo_free(&buf->kf);
-	ret = __iio_allocate_kfifo(buf, buf->ring.bytes_per_datum,
-				buf->ring.length);
+	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
+				   buf->buffer.length);
 error_ret:
 	mutex_unlock(&buf->use_lock);
 	return ret;
 }
 
-static void iio_mark_kfifo_in_use(struct iio_ring_buffer *r)
+static void iio_mark_kfifo_in_use(struct iio_buffer *r)
 {
 	struct iio_kfifo *buf = iio_to_kfifo(r);
 	mutex_lock(&buf->use_lock);
@@ -56,7 +56,7 @@ static void iio_mark_kfifo_in_use(struct iio_ring_buffer *r)
 	mutex_unlock(&buf->use_lock);
 }
 
-static void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r)
+static void iio_unmark_kfifo_in_use(struct iio_buffer *r)
 {
 	struct iio_kfifo *buf = iio_to_kfifo(r);
 	mutex_lock(&buf->use_lock);
@@ -64,7 +64,7 @@ static void iio_unmark_kfifo_in_use(struct iio_ring_buffer *r)
 	mutex_unlock(&buf->use_lock);
 }
 
-static int iio_get_length_kfifo(struct iio_ring_buffer *r)
+static int iio_get_length_kfifo(struct iio_buffer *r)
 {
 	return r->length;
 }
@@ -74,9 +74,9 @@ static inline void __iio_init_kfifo(struct iio_kfifo *kf)
 	mutex_init(&kf->use_lock);
 }
 
-static IIO_RING_ENABLE_ATTR;
-static IIO_RING_BYTES_PER_DATUM_ATTR;
-static IIO_RING_LENGTH_ATTR;
+static IIO_BUFFER_ENABLE_ATTR;
+static IIO_BUFFER_BYTES_PER_DATUM_ATTR;
+static IIO_BUFFER_LENGTH_ATTR;
 
 static struct attribute *iio_kfifo_attributes[] = {
 	&dev_attr_length.attr,
@@ -90,7 +90,7 @@ static struct attribute_group iio_kfifo_attribute_group = {
 	.name = "buffer",
 };
 
-struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
+struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 {
 	struct iio_kfifo *kf;
 
@@ -98,20 +98,20 @@ struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 	if (!kf)
 		return NULL;
 	kf->update_needed = true;
-	iio_ring_buffer_init(&kf->ring, indio_dev);
-	kf->ring.attrs = &iio_kfifo_attribute_group;
+	iio_buffer_init(&kf->buffer, indio_dev);
+	kf->buffer.attrs = &iio_kfifo_attribute_group;
 	__iio_init_kfifo(kf);
 
-	return &kf->ring;
+	return &kf->buffer;
 }
 EXPORT_SYMBOL(iio_kfifo_allocate);
 
-static int iio_get_bytes_per_datum_kfifo(struct iio_ring_buffer *r)
+static int iio_get_bytes_per_datum_kfifo(struct iio_buffer *r)
 {
 	return r->bytes_per_datum;
 }
 
-static int iio_set_bytes_per_datum_kfifo(struct iio_ring_buffer *r, size_t bpd)
+static int iio_set_bytes_per_datum_kfifo(struct iio_buffer *r, size_t bpd)
 {
 	if (r->bytes_per_datum != bpd) {
 		r->bytes_per_datum = bpd;
@@ -121,14 +121,14 @@ static int iio_set_bytes_per_datum_kfifo(struct iio_ring_buffer *r, size_t bpd)
 	return 0;
 }
 
-static int iio_mark_update_needed_kfifo(struct iio_ring_buffer *r)
+static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
 {
 	struct iio_kfifo *kf = iio_to_kfifo(r);
 	kf->update_needed = true;
 	return 0;
 }
 
-static int iio_set_length_kfifo(struct iio_ring_buffer *r, int length)
+static int iio_set_length_kfifo(struct iio_buffer *r, int length)
 {
 	if (r->length != length) {
 		r->length = length;
@@ -138,13 +138,13 @@ static int iio_set_length_kfifo(struct iio_ring_buffer *r, int length)
 	return 0;
 }
 
-void iio_kfifo_free(struct iio_ring_buffer *r)
+void iio_kfifo_free(struct iio_buffer *r)
 {
 	kfree(iio_to_kfifo(r));
 }
 EXPORT_SYMBOL(iio_kfifo_free);
 
-static int iio_store_to_kfifo(struct iio_ring_buffer *r,
+static int iio_store_to_kfifo(struct iio_buffer *r,
 			      u8 *data,
 			      s64 timestamp)
 {
@@ -163,7 +163,7 @@ static int iio_store_to_kfifo(struct iio_ring_buffer *r,
 	return 0;
 }
 
-static int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
+static int iio_read_first_n_kfifo(struct iio_buffer *r,
 			   size_t n, char __user *buf)
 {
 	int ret, copied;
@@ -174,7 +174,7 @@ static int iio_read_first_n_kfifo(struct iio_ring_buffer *r,
 	return copied;
 }
 
-const struct iio_ring_access_funcs kfifo_access_funcs = {
+const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.mark_in_use = &iio_mark_kfifo_in_use,
 	.unmark_in_use = &iio_unmark_kfifo_in_use,
 	.store_to = &iio_store_to_kfifo,
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
index 66a80c6..a15598b 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -3,8 +3,8 @@
 #include "iio.h"
 #include "buffer_generic.h"
 
-extern const struct iio_ring_access_funcs kfifo_access_funcs;
+extern const struct iio_buffer_access_funcs kfifo_access_funcs;
 
-struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
-void iio_kfifo_free(struct iio_ring_buffer *r);
+struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
+void iio_kfifo_free(struct iio_buffer *r);
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 9a0dc1e..bedd378 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -775,9 +775,9 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_tx;
 
-	ret = iio_ring_buffer_register(indio_dev,
-				       &ade7758_channels[0],
-				       ARRAY_SIZE(ade7758_channels));
+	ret = iio_buffer_register(indio_dev,
+				  &ade7758_channels[0],
+				  ARRAY_SIZE(ade7758_channels));
 	if (ret) {
 		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 8c7541e..99ade65 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -61,7 +61,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	struct ade7758_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
@@ -91,7 +91,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ade7758_state *st = iio_priv(indio_dev);
-	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size;
 	unsigned channel;
 
@@ -109,9 +109,9 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
 	}
 
-	if (indio_dev->ring->access->set_bytes_per_datum)
-		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
-							    d_size);
+	if (indio_dev->buffer->access->set_bytes_per_datum)
+		indio_dev->buffer->access->
+			set_bytes_per_datum(indio_dev->buffer, d_size);
 
 	ade7758_write_waveform_type(&indio_dev->dev,
 		st->ade7758_ring_channels[channel].address);
@@ -119,7 +119,7 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static const struct iio_ring_setup_ops ade7758_ring_setup_ops = {
+static const struct iio_buffer_setup_ops ade7758_ring_setup_ops = {
 	.preenable = &ade7758_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
@@ -128,7 +128,7 @@ static const struct iio_ring_setup_ops ade7758_ring_setup_ops = {
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 }
 
 int ade7758_configure_ring(struct iio_dev *indio_dev)
@@ -136,16 +136,16 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring) {
+	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->buffer) {
 		ret = -ENOMEM;
 		return ret;
 	}
 
 	/* Effectively select the ring buffer implementation */
-	indio_dev->ring->access = &ring_sw_access_funcs;
-	indio_dev->ring->setup_ops = &ade7758_ring_setup_ops;
-	indio_dev->ring->owner = THIS_MODULE;
+	indio_dev->buffer->access = &ring_sw_access_funcs;
+	indio_dev->buffer->setup_ops = &ade7758_ring_setup_ops;
+	indio_dev->buffer->owner = THIS_MODULE;
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
 						 &ade7758_trigger_handler,
@@ -196,11 +196,11 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	return 0;
 
 error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
+	iio_sw_rb_free(indio_dev->buffer);
 	return ret;
 }
 
 void ade7758_uninitialize_ring(struct iio_dev *indio_dev)
 {
-	iio_ring_buffer_unregister(indio_dev);
+	iio_buffer_unregister(indio_dev);
 }
diff --git a/drivers/staging/iio/ring_hw.h b/drivers/staging/iio/ring_hw.h
index bb8cfd2..cad8a2e 100644
--- a/drivers/staging/iio/ring_hw.h
+++ b/drivers/staging/iio/ring_hw.h
@@ -14,9 +14,9 @@
  * @buf:	generic ring buffer elements
  * @private:	device specific data
  */
-struct iio_hw_ring_buffer {
-	struct iio_ring_buffer buf;
+struct iio_hw_buffer {
+	struct iio_buffer buf;
 	void *private;
 };
 
-#define iio_to_hw_ring_buf(r) container_of(r, struct iio_hw_ring_buffer, buf)
+#define iio_to_hw_buf(r) container_of(r, struct iio_hw_buffer, buf)
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 1905e03..66a34ad 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -30,10 +30,10 @@
  * @use_lock:		lock to prevent change in size when in use
  *
  * Note that the first element of all ring buffers must be a
- * struct iio_ring_buffer.
+ * struct iio_buffer.
 **/
 struct iio_sw_ring_buffer {
-	struct iio_ring_buffer  buf;
+	struct iio_buffer  buf;
 	unsigned char		*data;
 	unsigned char		*read_p;
 	unsigned char		*write_p;
@@ -52,7 +52,7 @@ static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
 {
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
-	__iio_update_ring_buffer(&ring->buf, bytes_per_datum, length);
+	__iio_update_buffer(&ring->buf, bytes_per_datum, length);
 	ring->data = kmalloc(length*ring->buf.bytes_per_datum, GFP_ATOMIC);
 	ring->read_p = NULL;
 	ring->write_p = NULL;
@@ -71,7 +71,7 @@ static inline void __iio_free_sw_ring_buffer(struct iio_sw_ring_buffer *ring)
 	kfree(ring->data);
 }
 
-static void iio_mark_sw_rb_in_use(struct iio_ring_buffer *r)
+static void iio_mark_sw_rb_in_use(struct iio_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	spin_lock(&ring->use_lock);
@@ -79,7 +79,7 @@ static void iio_mark_sw_rb_in_use(struct iio_ring_buffer *r)
 	spin_unlock(&ring->use_lock);
 }
 
-static void iio_unmark_sw_rb_in_use(struct iio_ring_buffer *r)
+static void iio_unmark_sw_rb_in_use(struct iio_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	spin_lock(&ring->use_lock);
@@ -166,7 +166,7 @@ static int iio_store_to_sw_ring(struct iio_sw_ring_buffer *ring,
 	return ret;
 }
 
-static int iio_read_first_n_sw_rb(struct iio_ring_buffer *r,
+static int iio_read_first_n_sw_rb(struct iio_buffer *r,
 				  size_t n, char __user *buf)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
@@ -297,7 +297,7 @@ error_ret:
 	return ret;
 }
 
-static int iio_store_to_sw_rb(struct iio_ring_buffer *r,
+static int iio_store_to_sw_rb(struct iio_buffer *r,
 			      u8 *data,
 			      s64 timestamp)
 {
@@ -327,13 +327,13 @@ again:
 	return 0;
 }
 
-static int iio_read_last_from_sw_rb(struct iio_ring_buffer *r,
+static int iio_read_last_from_sw_rb(struct iio_buffer *r,
 			     unsigned char *data)
 {
 	return iio_read_last_from_sw_ring(iio_to_sw_ring(r), data);
 }
 
-static int iio_request_update_sw_rb(struct iio_ring_buffer *r)
+static int iio_request_update_sw_rb(struct iio_buffer *r)
 {
 	int ret = 0;
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
@@ -354,13 +354,13 @@ error_ret:
 	return ret;
 }
 
-static int iio_get_bytes_per_datum_sw_rb(struct iio_ring_buffer *r)
+static int iio_get_bytes_per_datum_sw_rb(struct iio_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	return ring->buf.bytes_per_datum;
 }
 
-static int iio_set_bytes_per_datum_sw_rb(struct iio_ring_buffer *r, size_t bpd)
+static int iio_set_bytes_per_datum_sw_rb(struct iio_buffer *r, size_t bpd)
 {
 	if (r->bytes_per_datum != bpd) {
 		r->bytes_per_datum = bpd;
@@ -370,12 +370,12 @@ static int iio_set_bytes_per_datum_sw_rb(struct iio_ring_buffer *r, size_t bpd)
 	return 0;
 }
 
-static int iio_get_length_sw_rb(struct iio_ring_buffer *r)
+static int iio_get_length_sw_rb(struct iio_buffer *r)
 {
 	return r->length;
 }
 
-static int iio_set_length_sw_rb(struct iio_ring_buffer *r, int length)
+static int iio_set_length_sw_rb(struct iio_buffer *r, int length)
 {
 	if (r->length != length) {
 		r->length = length;
@@ -385,16 +385,16 @@ static int iio_set_length_sw_rb(struct iio_ring_buffer *r, int length)
 	return 0;
 }
 
-static int iio_mark_update_needed_sw_rb(struct iio_ring_buffer *r)
+static int iio_mark_update_needed_sw_rb(struct iio_buffer *r)
 {
 	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
 	ring->update_needed = true;
 	return 0;
 }
 
-static IIO_RING_ENABLE_ATTR;
-static IIO_RING_BYTES_PER_DATUM_ATTR;
-static IIO_RING_LENGTH_ATTR;
+static IIO_BUFFER_ENABLE_ATTR;
+static IIO_BUFFER_BYTES_PER_DATUM_ATTR;
+static IIO_BUFFER_LENGTH_ATTR;
 
 /* Standard set of ring buffer attributes */
 static struct attribute *iio_ring_attributes[] = {
@@ -409,9 +409,9 @@ static struct attribute_group iio_ring_attribute_group = {
 	.name = "buffer",
 };
 
-struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
+struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 {
-	struct iio_ring_buffer *buf;
+	struct iio_buffer *buf;
 	struct iio_sw_ring_buffer *ring;
 
 	ring = kzalloc(sizeof *ring, GFP_KERNEL);
@@ -419,7 +419,7 @@ struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 		return NULL;
 	ring->update_needed = true;
 	buf = &ring->buf;
-	iio_ring_buffer_init(buf, indio_dev);
+	iio_buffer_init(buf, indio_dev);
 	__iio_init_sw_ring_buffer(ring);
 	buf->attrs = &iio_ring_attribute_group;
 
@@ -427,13 +427,13 @@ struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_sw_rb_allocate);
 
-void iio_sw_rb_free(struct iio_ring_buffer *r)
+void iio_sw_rb_free(struct iio_buffer *r)
 {
 	kfree(iio_to_sw_ring(r));
 }
 EXPORT_SYMBOL(iio_sw_rb_free);
 
-const struct iio_ring_access_funcs ring_sw_access_funcs = {
+const struct iio_buffer_access_funcs ring_sw_access_funcs = {
 	.mark_in_use = &iio_mark_sw_rb_in_use,
 	.unmark_in_use = &iio_unmark_sw_rb_in_use,
 	.store_to = &iio_store_to_sw_rb,
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 2835c99..a3e1578 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -28,8 +28,8 @@
 /**
  * ring_sw_access_funcs - access functions for a software ring buffer
  **/
-extern const struct iio_ring_access_funcs ring_sw_access_funcs;
+extern const struct iio_buffer_access_funcs ring_sw_access_funcs;
 
-struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
-void iio_sw_rb_free(struct iio_ring_buffer *ring);
+struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
+void iio_sw_rb_free(struct iio_buffer *ring);
 #endif /* _IIO_RING_SW_H_ */
-- 
1.7.3.4
