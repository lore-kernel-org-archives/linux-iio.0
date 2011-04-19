Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/2] IIO-onwards: ADC: AD7298: Use private data space from iio_allocate_device
Date: Tue, 19 Apr 2011 13:56:10 +0200
Message-ID: <1303214170-10379-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303214170-10379-1-git-send-email-michael.hennerich@analog.com>
References: <1303214170-10379-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Use private data space from iio_allocate_device

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7298.h      |    1 -
 drivers/staging/iio/adc/ad7298_core.c |   68 ++++++++++++++++-----------------
 drivers/staging/iio/adc/ad7298_ring.c |    2 +-
 3 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index 718e56a..7eb2c3b 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -36,7 +36,6 @@ struct ad7298_platform_data {
 };
 
 struct ad7298_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	struct regulator		*reg;
 	size_t				d_size;
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index ef670cf..8c0792b 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -160,13 +160,13 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 {
 	struct ad7298_platform_data *pdata = spi->dev.platform_data;
 	struct ad7298_state *st;
-	int ret;
+	int ret, regdone = 0;
+	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
 
 	st->reg = regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
@@ -175,24 +175,18 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 			goto error_put_reg;
 	}
 
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-	st->indio_dev->channels = ad7298_channels;
-	st->indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
-	st->indio_dev->read_raw = &ad7298_read_raw;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev_data = (void *)(st);
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad7298_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
+	indio_dev->read_raw = &ad7298_read_raw;
 
 	/* Setup default message */
 
@@ -217,41 +211,44 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 		st->int_vref_mv = AD7298_INTREF_mV;
 	}
 
-	ret = ad7298_register_ring_funcs_and_init(st->indio_dev);
+	ret = ad7298_register_ring_funcs_and_init(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
+	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  &ad7298_channels[1], /* skip temp0 */
 					  ARRAY_SIZE(ad7298_channels) - 1);
 	if (ret)
 		goto error_cleanup_ring;
+
 	return 0;
 
 error_cleanup_ring:
-	ad7298_ring_cleanup(st->indio_dev);
-	iio_device_unregister(st->indio_dev);
-error_free_device:
-	iio_free_device(st->indio_dev);
+	ad7298_ring_cleanup(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	kfree(st);
-error_ret:
+
+	if (regdone)
+		iio_device_unregister(indio_dev);
+	else
+		iio_free_device(indio_dev);
+
 	return ret;
 }
 
 static int __devexit ad7298_remove(struct spi_device *spi)
 {
-	struct ad7298_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7298_state *st = iio_priv(indio_dev);
 
 	iio_ring_buffer_unregister(indio_dev->ring);
 	ad7298_ring_cleanup(indio_dev);
@@ -260,7 +257,8 @@ static int __devexit ad7298_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	kfree(st);
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 19e6916..52363ca 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -23,7 +23,7 @@
 
 int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
 {
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
 	int ret;
 	u16 *ring_data;
 
-- 
1.6.0.2
