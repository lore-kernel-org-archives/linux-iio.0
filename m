Return-Path: <SRS0=9z2R=L3=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
	<lars@metafoo.de>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>
Subject: [PATCH] staging:iio:ad7606: update api calls to devm_* variants
Date: Thu, 13 Sep 2018 12:51:38 +0300
Message-ID: <20180913095138.18427-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

No significant functional changes. This just replaces the code with devm_*
that reduce the driver code, and simplifies some error code paths in the
ad7606_probe() function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7606.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 87d5fb073c95..793de92f27ed 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -458,28 +458,25 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
-	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
-			  indio_dev);
+	ret = devm_request_irq(dev, irq, ad7606_interrupt,
+			       IRQF_TRIGGER_FALLING,
+			       name, indio_dev);
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
-					 NULL, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &ad7606_trigger_handler,
+					      NULL, NULL);
 	if (ret)
-		goto error_free_irq;
+		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		goto error_unregister_ring;
+		goto error_disable_reg;
 
 	dev_set_drvdata(dev, indio_dev);
 
 	return 0;
-error_unregister_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-error_free_irq:
-	free_irq(irq, indio_dev);
 
 error_disable_reg:
 	regulator_disable(st->reg);
@@ -492,10 +489,6 @@ int ad7606_remove(struct device *dev, int irq)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	free_irq(irq, indio_dev);
 	regulator_disable(st->reg);
 
 	return 0;
-- 
2.17.1
