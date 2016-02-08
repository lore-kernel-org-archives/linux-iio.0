Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] staging:iio:ad7606: Consolidate PM ops
Date: Mon,  8 Feb 2016 11:13:29 +0100
Message-Id: <1454926409-3178-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Both the SPI and platform device driver for the ad7606 use the same set of
PM ops. Consolidate them in the common part of the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Rebased onto latest iio/testing
---
 drivers/staging/iio/adc/ad7606.h      | 10 ++++++++--
 drivers/staging/iio/adc/ad7606_core.c | 19 +++++++++++++++----
 drivers/staging/iio/adc/ad7606_par.c  | 32 +-------------------------------
 drivers/staging/iio/adc/ad7606_spi.c  | 32 +-------------------------------
 4 files changed, 25 insertions(+), 68 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index ec89d05..cca9469 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -85,8 +85,6 @@ struct ad7606_bus_ops {
 	int (*read_block)(struct device *, int, void *);
 };
 
-void ad7606_suspend(struct iio_dev *indio_dev);
-void ad7606_resume(struct iio_dev *indio_dev);
 struct iio_dev *ad7606_probe(struct device *dev, int irq,
 			      void __iomem *base_address, unsigned id,
 			      const struct ad7606_bus_ops *bops);
@@ -101,4 +99,12 @@ enum ad7606_supported_device_ids {
 
 int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7606_ring_cleanup(struct iio_dev *indio_dev);
+
+#ifdef CONFIG_PM_SLEEP
+extern const struct dev_pm_ops ad7606_pm_ops;
+#define AD7606_PM_OPS (&ad7606_pm_ops)
+#else
+#define AD7606_PM_OPS NULL
+#endif
+
 #endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 263f981..fe6caee 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -560,8 +560,11 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
 }
 EXPORT_SYMBOL_GPL(ad7606_remove);
 
-void ad7606_suspend(struct iio_dev *indio_dev)
+#ifdef CONFIG_PM_SLEEP
+
+static int ad7606_suspend(struct device *dev)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (gpio_is_valid(st->pdata->gpio_stby)) {
@@ -569,11 +572,13 @@ void ad7606_suspend(struct iio_dev *indio_dev)
 			gpio_set_value(st->pdata->gpio_range, 1);
 		gpio_set_value(st->pdata->gpio_stby, 0);
 	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(ad7606_suspend);
 
-void ad7606_resume(struct iio_dev *indio_dev)
+static int ad7606_resume(struct device *dev)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (gpio_is_valid(st->pdata->gpio_stby)) {
@@ -584,8 +589,14 @@ void ad7606_resume(struct iio_dev *indio_dev)
 		gpio_set_value(st->pdata->gpio_stby, 1);
 		ad7606_reset(st);
 	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(ad7606_resume);
+
+SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
+EXPORT_SYMBOL_GPL(ad7606_pm_ops);
+
+#endif
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index adc370e..84d2393 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -90,36 +90,6 @@ static int ad7606_par_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ad7606_par_suspend(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	ad7606_suspend(indio_dev);
-
-	return 0;
-}
-
-static int ad7606_par_resume(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	ad7606_resume(indio_dev);
-
-	return 0;
-}
-
-static const struct dev_pm_ops ad7606_pm_ops = {
-	.suspend = ad7606_par_suspend,
-	.resume  = ad7606_par_resume,
-};
-
-#define AD7606_PAR_PM_OPS (&ad7606_pm_ops)
-
-#else
-#define AD7606_PAR_PM_OPS NULL
-#endif  /* CONFIG_PM */
-
 static const struct platform_device_id ad7606_driver_ids[] = {
 	{
 		.name		= "ad7606-8",
@@ -142,7 +112,7 @@ static struct platform_driver ad7606_driver = {
 	.id_table = ad7606_driver_ids,
 	.driver = {
 		.name	 = "ad7606",
-		.pm    = AD7606_PAR_PM_OPS,
+		.pm	 = AD7606_PM_OPS,
 	},
 };
 
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index cbb3631..d873a51 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -62,36 +62,6 @@ static int ad7606_spi_remove(struct spi_device *spi)
 	return ad7606_remove(indio_dev, spi->irq);
 }
 
-#ifdef CONFIG_PM
-static int ad7606_spi_suspend(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	ad7606_suspend(indio_dev);
-
-	return 0;
-}
-
-static int ad7606_spi_resume(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	ad7606_resume(indio_dev);
-
-	return 0;
-}
-
-static const struct dev_pm_ops ad7606_pm_ops = {
-	.suspend = ad7606_spi_suspend,
-	.resume  = ad7606_spi_resume,
-};
-
-#define AD7606_SPI_PM_OPS (&ad7606_pm_ops)
-
-#else
-#define AD7606_SPI_PM_OPS NULL
-#endif
-
 static const struct spi_device_id ad7606_id[] = {
 	{"ad7606-8", ID_AD7606_8},
 	{"ad7606-6", ID_AD7606_6},
@@ -103,7 +73,7 @@ MODULE_DEVICE_TABLE(spi, ad7606_id);
 static struct spi_driver ad7606_driver = {
 	.driver = {
 		.name = "ad7606",
-		.pm    = AD7606_SPI_PM_OPS,
+		.pm = AD7606_PM_OPS,
 	},
 	.probe = ad7606_spi_probe,
 	.remove = ad7606_spi_remove,
-- 
2.1.4
