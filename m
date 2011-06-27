Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/54] staging:iio:adc:ad7476 allocate state with iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:23 +0100
Message-Id: <1309169104-22139-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Reg handling is a little fiddly given the ordering of calls.

All part of getting rid of iio_dev->dev_data

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7476.h      |    5 +-
 drivers/staging/iio/adc/ad7476_core.c |   82 ++++++++++++++++-----------------
 drivers/staging/iio/adc/ad7476_ring.c |   10 ++--
 3 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
index 01a7021..0d44976 100644
--- a/drivers/staging/iio/adc/ad7476.h
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -24,7 +24,6 @@ struct ad7476_chip_info {
 };
 
 struct ad7476_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
 	struct regulator		*reg;
@@ -51,11 +50,11 @@ enum ad7476_supported_device_ids {
 };
 
 #ifdef CONFIG_IIO_RING_BUFFER
-int ad7476_scan_from_ring(struct ad7476_state *st);
+int ad7476_scan_from_ring(struct iio_dev *indio_dev);
 int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7476_ring_cleanup(struct iio_dev *indio_dev);
 #else /* CONFIG_IIO_RING_BUFFER */
-static inline int ad7476_scan_from_ring(struct ad7476_state *st)
+static inline int ad7476_scan_from_ring(struct iio_dev *indio_dev)
 {
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 50cedb4..768f3ec 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -39,14 +39,14 @@ static int ad7476_read_raw(struct iio_dev *dev_info,
 			   long m)
 {
 	int ret;
-	struct ad7476_state *st = dev_info->dev_data;
+	struct ad7476_state *st = iio_priv(dev_info);
 	unsigned int scale_uv;
 
 	switch (m) {
 	case 0:
 		mutex_lock(&dev_info->mlock);
 		if (iio_ring_enabled(dev_info))
-			ret = ad7476_scan_from_ring(st);
+			ret = ad7476_scan_from_ring(dev_info);
 		else
 			ret = ad7476_scan_direct(st);
 		mutex_unlock(&dev_info->mlock);
@@ -127,23 +127,26 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_platform_data *pdata = spi->dev.platform_data;
 	struct ad7476_state *st;
+	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
+	bool reg_done = false;
+	struct regulator *reg;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-
-	st->reg = regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
+	st = iio_priv(indio_dev);
+	reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(reg)) {
+		ret = regulator_enable(reg);
 		if (ret)
 			goto error_put_reg;
 
-		voltage_uv = regulator_get_voltage(st->reg);
+		voltage_uv = regulator_get_voltage(reg);
 	}
-
+	st->reg = reg;
 	st->chip_info =
 		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -160,20 +163,13 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-
 	/* Establish that the iio_dev is a child of the spi device */
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-	st->indio_dev->channels = st->chip_info->channel;
-	st->indio_dev->num_channels = 2;
-	st->indio_dev->info = &ad7476_info;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->chip_info->channel;
+	indio_dev->num_channels = 2;
+	indio_dev->info = &ad7476_info;
 	/* Setup default message */
 
 	st->xfer.rx_buf = &st->data;
@@ -182,15 +178,15 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
 
-	ret = ad7476_register_ring_funcs_and_init(st->indio_dev);
+	ret = ad7476_register_ring_funcs_and_init(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  st->chip_info->channel,
 					  ARRAY_SIZE(st->chip_info->channel));
 	if (ret)
@@ -198,33 +194,35 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	return 0;
 
 error_cleanup_ring:
-	ad7476_ring_cleanup(st->indio_dev);
-	iio_device_unregister(st->indio_dev);
-error_free_device:
-	iio_free_device(st->indio_dev);
+	ad7476_ring_cleanup(indio_dev);
+	iio_device_unregister(indio_dev);
 error_disable_reg:
-	if (!IS_ERR(st->reg))
+	if (!IS_ERR(reg))
 		regulator_disable(st->reg);
 error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-	kfree(st);
+	if (!IS_ERR(reg))
+		regulator_put(reg);
+	if (!reg_done)
+		iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
 
 static int ad7476_remove(struct spi_device *spi)
 {
-	struct ad7476_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7476_state *st = iio_priv(indio_dev);
+	/* copy needed as st will have been freed */
+	struct regulator *reg = st->reg;
+
 	iio_ring_buffer_unregister(indio_dev->ring);
 	ad7476_ring_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg)) {
-		regulator_disable(st->reg);
-		regulator_put(st->reg);
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
 	}
-	kfree(st);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index b1b2ee2..a92fc5a 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -22,9 +22,9 @@
 
 #include "ad7476.h"
 
-int ad7476_scan_from_ring(struct ad7476_state *st)
+int ad7476_scan_from_ring(struct iio_dev *indio_dev)
 {
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	int ret;
 	u8 *ring_data;
 
@@ -55,7 +55,7 @@ error_ret:
  **/
 static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 {
-	struct ad7476_state *st = indio_dev->dev_data;
+	struct ad7476_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	st->d_size = ring->scan_count *
@@ -79,7 +79,7 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->private_data;
-	struct ad7476_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad7476_state *st = iio_priv(indio_dev);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
@@ -115,7 +115,7 @@ static const struct iio_ring_setup_ops ad7476_ring_setup_ops = {
 
 int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct ad7476_state *st = indio_dev->dev_data;
+	struct ad7476_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-- 
1.7.3.4
