Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60029 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757160AbcJSRHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:21 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/13] staging:iio:ad7606: Let the common probe function return int
Date: Wed, 19 Oct 2016 19:07:04 +0200
Message-Id: <1476896828-10544-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The common probe function for the ad7606 currently returns a struct iio_dev
pointer. The returned value is not used by the individual driver probe
functions other than for error checking.

Let the common probe function return a int instead to report the error
value directly (or 0 on success). This allows to simplify the code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606.h      |  7 +++----
 drivers/staging/iio/adc/ad7606_core.c | 15 +++++++--------
 drivers/staging/iio/adc/ad7606_par.c  | 14 ++++----------
 drivers/staging/iio/adc/ad7606_spi.c  | 12 +++---------
 4 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 2257bdb..b4b25a2 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -78,10 +78,9 @@ struct ad7606_bus_ops {
 	int (*read_block)(struct device *, int, void *);
 };
 
-struct iio_dev *ad7606_probe(struct device *dev, int irq,
-			      void __iomem *base_address,
-			      const char *name, unsigned int id,
-			      const struct ad7606_bus_ops *bops);
+int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
+		 const char *name, unsigned int id,
+		 const struct ad7606_bus_ops *bops);
 int ad7606_remove(struct iio_dev *indio_dev, int irq);
 int ad7606_reset(struct ad7606_state *st);
 int ad7606_read_samples(struct ad7606_state *st);
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 13d8090..1ee7a29 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -443,10 +443,9 @@ static const struct iio_info ad7606_info_range = {
 	.attrs = &ad7606_attribute_group_range,
 };
 
-struct iio_dev *ad7606_probe(struct device *dev, int irq,
-			     void __iomem *base_address,
-			     const char *name, unsigned int id,
-			     const struct ad7606_bus_ops *bops)
+int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
+		 const char *name, unsigned int id,
+		 const struct ad7606_bus_ops *bops)
 {
 	struct ad7606_platform_data *pdata = dev->platform_data;
 	struct ad7606_state *st;
@@ -455,7 +454,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
@@ -469,7 +468,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 	}
 
 	st->pdata = pdata;
@@ -519,7 +518,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 
 	dev_set_drvdata(dev, indio_dev);
 
-	return indio_dev;
+	return 0;
 error_unregister_ring:
 	ad7606_ring_cleanup(indio_dev);
 
@@ -532,7 +531,7 @@ error_free_gpios:
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-	return ERR_PTR(ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ad7606_probe);
 
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index c273993..42eb9e0 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -51,7 +51,6 @@ static int ad7606_par_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct resource *res;
-	struct iio_dev *indio_dev;
 	void __iomem *addr;
 	resource_size_t remap_size;
 	int irq;
@@ -69,15 +68,10 @@ static int ad7606_par_probe(struct platform_device *pdev)
 
 	remap_size = resource_size(res);
 
-	indio_dev = ad7606_probe(&pdev->dev, irq, addr,
-				 id->name, id->driver_data,
-				 remap_size > 1 ? &ad7606_par16_bops :
-				 &ad7606_par8_bops);
-
-	if (IS_ERR(indio_dev))
-		return PTR_ERR(indio_dev);
-
-	return 0;
+	return ad7606_probe(&pdev->dev, irq, addr,
+			    id->name, id->driver_data,
+			    remap_size > 1 ? &ad7606_par16_bops :
+			    &ad7606_par8_bops);
 }
 
 static int ad7606_par_remove(struct platform_device *pdev)
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 9abbc15..064c4c2 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -43,16 +43,10 @@ static const struct ad7606_bus_ops ad7606_spi_bops = {
 static int ad7606_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
-	struct iio_dev *indio_dev;
 
-	indio_dev = ad7606_probe(&spi->dev, spi->irq, NULL,
-				 id->name, id->driver_data,
-				 &ad7606_spi_bops);
-
-	if (IS_ERR(indio_dev))
-		return PTR_ERR(indio_dev);
-
-	return 0;
+	return ad7606_probe(&spi->dev, spi->irq, NULL,
+			    id->name, id->driver_data,
+			    &ad7606_spi_bops);
 }
 
 static int ad7606_spi_remove(struct spi_device *spi)
-- 
2.1.4

