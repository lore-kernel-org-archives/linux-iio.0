Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57731 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab1EDL44 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 71/99] staging:iio:adc:ad7606: Use private data space from iio_allocate_device
Date: Wed,  4 May 2011 12:58:43 +0100
Message-Id: <1304510351-10922-72-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Trivial backport done by Jonathan Cameron

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606.h      |    9 ++--
 drivers/staging/iio/adc/ad7606_core.c |   92 +++++++++++++++++----------------
 drivers/staging/iio/adc/ad7606_par.c  |   30 ++++++-----
 drivers/staging/iio/adc/ad7606_ring.c |    7 ++-
 drivers/staging/iio/adc/ad7606_spi.c  |   24 +++++----
 5 files changed, 85 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 2af1434..db76bfd 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -62,7 +62,6 @@ struct ad7606_chip_info {
  */
 
 struct ad7606_state {
-	struct iio_dev			*indio_dev;
 	struct device			*dev;
 	const struct ad7606_chip_info	*chip_info;
 	struct ad7606_platform_data	*pdata;
@@ -96,12 +95,12 @@ struct ad7606_bus_ops {
 	int (*read_block)(struct device *, int, void *);
 };
 
-void ad7606_suspend(struct ad7606_state *st);
-void ad7606_resume(struct ad7606_state *st);
-struct ad7606_state *ad7606_probe(struct device *dev, int irq,
+void ad7606_suspend(struct iio_dev *indio_dev);
+void ad7606_resume(struct iio_dev *indio_dev);
+struct iio_dev *ad7606_probe(struct device *dev, int irq,
 			      void __iomem *base_address, unsigned id,
 			      const struct ad7606_bus_ops *bops);
-int ad7606_remove(struct ad7606_state *st);
+int ad7606_remove(struct iio_dev *indio_dev);
 int ad7606_reset(struct ad7606_state *st);
 
 enum ad7606_supported_device_ids {
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index ee61009..3b4bb3e 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -365,8 +365,8 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		st->have_reset = true;
 
 	ret = gpio_request_one(st->pdata->gpio_range, GPIOF_DIR_OUT |
-			       ((st->range == 10000) ? GPIOF_INIT_HIGH :
-			       	GPIOF_INIT_LOW), "AD7606_RANGE");
+				((st->range == 10000) ? GPIOF_INIT_HIGH :
+				GPIOF_INIT_LOW), "AD7606_RANGE");
 	if (!ret)
 		st->have_range = true;
 
@@ -413,9 +413,10 @@ static void ad7606_free_gpios(struct ad7606_state *st)
  */
 static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 {
-	struct ad7606_state *st = dev_id;
+	struct iio_dev *indio_dev = dev_id;
+	struct ad7606_state *st = iio_priv(indio_dev);
 
-	if (iio_ring_enabled(st->indio_dev)) {
+	if (iio_ring_enabled(indio_dev)) {
 		if (!work_pending(&st->poll_work))
 			schedule_work(&st->poll_work);
 	} else {
@@ -426,21 +427,23 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 };
 
-struct ad7606_state *ad7606_probe(struct device *dev, int irq,
+struct iio_dev *ad7606_probe(struct device *dev, int irq,
 			      void __iomem *base_address,
 			      unsigned id,
 			      const struct ad7606_bus_ops *bops)
 {
 	struct ad7606_platform_data *pdata = dev->platform_data;
 	struct ad7606_state *st;
-	int ret;
+	int ret, regdone = 0;
+	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
 
+	st = iio_priv(indio_dev);
+
 	st->dev = dev;
 	st->id = id;
 	st->irq = irq;
@@ -467,97 +470,94 @@ struct ad7606_state *ad7606_probe(struct device *dev, int irq,
 	st->pdata = pdata;
 	st->chip_info = &ad7606_chip_info_tbl[id];
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-
-	st->indio_dev->dev.parent = dev;
-	st->indio_dev->attrs = &ad7606_attribute_group;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-	st->indio_dev->name = st->chip_info->name;
-	st->indio_dev->channels = st->chip_info->channels;
-	st->indio_dev->num_channels = st->chip_info->num_channels;
-	st->indio_dev->read_raw = &ad7606_read_raw;
+	indio_dev->dev.parent = dev;
+	indio_dev->attrs = &ad7606_attribute_group;
+	indio_dev->dev_data = (void *)(st);
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = st->chip_info->name;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->read_raw = &ad7606_read_raw;
 
 	init_waitqueue_head(&st->wq_data_avail);
 
 	ret = ad7606_request_gpios(st);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	ret = ad7606_reset(st);
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
 	ret = request_irq(st->irq, ad7606_interrupt,
-		IRQF_TRIGGER_FALLING, st->chip_info->name, st);
+		IRQF_TRIGGER_FALLING, st->chip_info->name, indio_dev);
 	if (ret)
 		goto error_free_gpios;
 
-	ret = ad7606_register_ring_funcs_and_init(st->indio_dev);
+	ret = ad7606_register_ring_funcs_and_init(indio_dev);
 	if (ret)
 		goto error_free_irq;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_irq;
+	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
-					  st->indio_dev->channels,
-					  st->indio_dev->num_channels);
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+					  indio_dev->channels,
+					  indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
-	return st;
+	return indio_dev;
 
 error_cleanup_ring:
-	ad7606_ring_cleanup(st->indio_dev);
-	iio_device_unregister(st->indio_dev);
+	ad7606_ring_cleanup(indio_dev);
 
 error_free_irq:
-	free_irq(st->irq, st);
+	free_irq(st->irq, indio_dev);
 
 error_free_gpios:
 	ad7606_free_gpios(st);
 
-error_free_device:
-	iio_free_device(st->indio_dev);
-
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	kfree(st);
+	if (regdone)
+		iio_device_unregister(indio_dev);
+	else
+		iio_free_device(indio_dev);
 error_ret:
 	return ERR_PTR(ret);
 }
 
-int ad7606_remove(struct ad7606_state *st)
+int ad7606_remove(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct ad7606_state *st = iio_priv(indio_dev);
+
 	iio_ring_buffer_unregister(indio_dev->ring);
 	ad7606_ring_cleanup(indio_dev);
-	iio_device_unregister(indio_dev);
-	free_irq(st->irq, st);
+
+	free_irq(st->irq, indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
 
 	ad7606_free_gpios(st);
+	iio_device_unregister(indio_dev);
 
-	kfree(st);
 	return 0;
 }
 
-void ad7606_suspend(struct ad7606_state *st)
+void ad7606_suspend(struct iio_dev *indio_dev)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
+
 	if (st->have_stby) {
 		if (st->have_range)
 			gpio_set_value(st->pdata->gpio_range, 1);
@@ -565,8 +565,10 @@ void ad7606_suspend(struct ad7606_state *st)
 	}
 }
 
-void ad7606_resume(struct ad7606_state *st)
+void ad7606_resume(struct iio_dev *indio_dev)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
+
 	if (st->have_stby) {
 		if (st->have_range)
 			gpio_set_value(st->pdata->gpio_range,
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 43a554c..d21218d 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -12,13 +12,15 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "../iio.h"
 #include "ad7606.h"
 
 static int ad7606_par16_read_block(struct device *dev,
 				 int count, void *buf)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct ad7606_state *st = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	insw((unsigned long) st->base_address, buf, count);
 
@@ -33,7 +35,8 @@ static int ad7606_par8_read_block(struct device *dev,
 				 int count, void *buf)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct ad7606_state *st = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ad7606_state *st = iio_priv(indio_dev);
 
 	insb((unsigned long) st->base_address, buf, count * 2);
 
@@ -47,7 +50,7 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
 static int __devinit ad7606_par_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	struct ad7606_state *st;
+	struct iio_dev *indio_dev;
 	void __iomem *addr;
 	resource_size_t remap_size;
 	int ret, irq;
@@ -75,17 +78,17 @@ static int __devinit ad7606_par_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
-	st = ad7606_probe(&pdev->dev, irq, addr,
+	indio_dev = ad7606_probe(&pdev->dev, irq, addr,
 			  platform_get_device_id(pdev)->driver_data,
 			  remap_size > 1 ? &ad7606_par16_bops :
 			  &ad7606_par8_bops);
 
-	if (IS_ERR(st))  {
-		ret = PTR_ERR(st);
+	if (IS_ERR(indio_dev))  {
+		ret = PTR_ERR(indio_dev);
 		goto out2;
 	}
 
-	platform_set_drvdata(pdev, st);
+	platform_set_drvdata(pdev, indio_dev);
 
 	return 0;
 
@@ -99,10 +102,11 @@ out1:
 
 static int __devexit ad7606_par_remove(struct platform_device *pdev)
 {
-	struct ad7606_state *st = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct resource *res;
+	struct ad7606_state *st = iio_priv(indio_dev);
 
-	ad7606_remove(st);
+	ad7606_remove(indio_dev);
 
 	iounmap(st->base_address);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -116,18 +120,18 @@ static int __devexit ad7606_par_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int ad7606_par_suspend(struct device *dev)
 {
-	struct ad7606_state *st = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	ad7606_suspend(st);
+	ad7606_suspend(indio_dev);
 
 	return 0;
 }
 
 static int ad7606_par_resume(struct device *dev)
 {
-	struct ad7606_state *st = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	ad7606_resume(st);
+	ad7606_resume(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 15531b6..351d58e 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -23,11 +23,12 @@
 
 int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch)
 {
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
 	int ret;
 	u16 *ring_data;
 
-	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
+	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring),
+			    GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -103,7 +104,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 {
 	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
 						poll_work);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
 	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index d738491..0769c80 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -10,6 +10,8 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/err.h>
+
+#include "../iio.h"
 #include "ad7606.h"
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
@@ -39,42 +41,42 @@ static const struct ad7606_bus_ops ad7606_spi_bops = {
 
 static int __devinit ad7606_spi_probe(struct spi_device *spi)
 {
-	struct ad7606_state *st;
+	struct iio_dev *indio_dev;
 
-	st = ad7606_probe(&spi->dev, spi->irq, NULL,
+	indio_dev = ad7606_probe(&spi->dev, spi->irq, NULL,
 			   spi_get_device_id(spi)->driver_data,
 			   &ad7606_spi_bops);
 
-	if (IS_ERR(st))
-		return PTR_ERR(st);
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
 
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
 	return 0;
 }
 
 static int __devexit ad7606_spi_remove(struct spi_device *spi)
 {
-	struct ad7606_state *st = dev_get_drvdata(&spi->dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
 
-	return ad7606_remove(st);
+	return ad7606_remove(indio_dev);
 }
 
 #ifdef CONFIG_PM
 static int ad7606_spi_suspend(struct device *dev)
 {
-	struct ad7606_state *st = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	ad7606_suspend(st);
+	ad7606_suspend(indio_dev);
 
 	return 0;
 }
 
 static int ad7606_spi_resume(struct device *dev)
 {
-	struct ad7606_state *st = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	ad7606_resume(st);
+	ad7606_resume(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4

