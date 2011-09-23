Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/16] staging:iio:adc:ad7606 refactor to remove st->irq and st->id.
Date: Fri, 23 Sep 2011 13:01:40 +0100
Message-Id: <1316779302-12357-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

id wasn't used anywhere and st->irq can be removed by simply
passing it into the core remove function (trivially available in
the two bus implementations).

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606.h      |    4 +---
 drivers/staging/iio/adc/ad7606_core.c |   10 ++++------
 drivers/staging/iio/adc/ad7606_par.c  |    2 +-
 drivers/staging/iio/adc/ad7606_spi.c  |    2 +-
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index bc95f09..0d1bb26 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -69,8 +69,6 @@ struct ad7606_state {
 	struct work_struct		poll_work;
 	wait_queue_head_t		wq_data_avail;
 	const struct ad7606_bus_ops	*bops;
-	int				irq;
-	unsigned			id;
 	unsigned			range;
 	unsigned			oversampling;
 	bool				done;
@@ -94,7 +92,7 @@ void ad7606_resume(struct iio_dev *indio_dev);
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
 			      void __iomem *base_address, unsigned id,
 			      const struct ad7606_bus_ops *bops);
-int ad7606_remove(struct iio_dev *indio_dev);
+int ad7606_remove(struct iio_dev *indio_dev, int irq);
 int ad7606_reset(struct ad7606_state *st);
 
 enum ad7606_supported_device_ids {
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index e762acb..3c0fb72 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -459,8 +459,6 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	st = iio_priv(indio_dev);
 
 	st->dev = dev;
-	st->id = id;
-	st->irq = irq;
 	st->bops = bops;
 	st->base_address = base_address;
 	st->range = pdata->default_range == 10000 ? 10000 : 5000;
@@ -501,7 +499,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
-	ret = request_irq(st->irq, ad7606_interrupt,
+	ret = request_irq(irq, ad7606_interrupt,
 		IRQF_TRIGGER_FALLING, st->chip_info->name, indio_dev);
 	if (ret)
 		goto error_free_gpios;
@@ -527,7 +525,7 @@ error_cleanup_ring:
 	ad7606_ring_cleanup(indio_dev);
 
 error_free_irq:
-	free_irq(st->irq, indio_dev);
+	free_irq(irq, indio_dev);
 
 error_free_gpios:
 	ad7606_free_gpios(st);
@@ -543,14 +541,14 @@ error_ret:
 	return ERR_PTR(ret);
 }
 
-int ad7606_remove(struct iio_dev *indio_dev)
+int ad7606_remove(struct iio_dev *indio_dev, int irq)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	iio_buffer_unregister(indio_dev);
 	ad7606_ring_cleanup(indio_dev);
 
-	free_irq(st->irq, indio_dev);
+	free_irq(irq, indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index d21218d..688632e 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -106,7 +106,7 @@ static int __devexit ad7606_par_remove(struct platform_device *pdev)
 	struct resource *res;
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	ad7606_remove(indio_dev);
+	ad7606_remove(indio_dev, platform_get_irq(pdev, 0));
 
 	iounmap(st->base_address);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 0769c80..aede1ba 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -59,7 +59,7 @@ static int __devexit ad7606_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
 
-	return ad7606_remove(indio_dev);
+	return ad7606_remove(indio_dev, spi->irq);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.3.4
