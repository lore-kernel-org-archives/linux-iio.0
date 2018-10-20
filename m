Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.157]:47827 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeJTX27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Oct 2018 19:28:59 -0400
Date: Sat, 20 Oct 2018 17:18:26 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v4 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181020151826.GA30302@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
Since v3:
* kasprintf -> devm_kasprintf
* move the index calculation out of devm_kasprintf call so it all can fit into
  80 lines

Since v2:
* iio_device_register -> devm_iio_device_register

Since v1:
* request_threaded_irq -> devm_request_threaded_irq
---
 drivers/staging/iio/adc/ad7280a.c | 77 ++++++++++++-------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275c10f5..7427f7345313 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -8,7 +8,6 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 #include <linux/err.h>
@@ -492,8 +491,8 @@ static int ad7280_channel_init(struct ad7280_state *st)
 {
 	int dev, ch, cnt;
 
-	st->channels = kcalloc((st->slave_num + 1) * 12 + 2,
-			       sizeof(*st->channels), GFP_KERNEL);
+	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 2,
+				    sizeof(*st->channels), GFP_KERNEL);
 	if (!st->channels)
 		return -ENOMEM;
 
@@ -552,16 +551,18 @@ static int ad7280_channel_init(struct ad7280_state *st)
 static int ad7280_attr_init(struct ad7280_state *st)
 {
 	int dev, ch, cnt;
+	unsigned int index;
 
-	st->iio_attr = kcalloc(2, sizeof(*st->iio_attr) *
-			       (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
-			       GFP_KERNEL);
+	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
+				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
+				    GFP_KERNEL);
 	if (!st->iio_attr)
 		return -ENOMEM;
 
 	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
 			ch++, cnt++) {
+			index = dev * AD7280A_CELLS_PER_DEV + ch;
 			st->iio_attr[cnt].address =
 				ad7280a_devaddr(dev) << 8 | ch;
 			st->iio_attr[cnt].dev_attr.attr.mode =
@@ -571,10 +572,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
 			st->iio_attr[cnt].dev_attr.store =
 				ad7280_store_balance_sw;
 			st->iio_attr[cnt].dev_attr.attr.name =
-				kasprintf(GFP_KERNEL,
-					  "in%d-in%d_balance_switch_en",
-					  dev * AD7280A_CELLS_PER_DEV + ch,
-					  dev * AD7280A_CELLS_PER_DEV + ch + 1);
+				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
+					       "in%d-in%d_balance_switch_en",
+					       index, index + 1);
 			ad7280_attributes[cnt] =
 				&st->iio_attr[cnt].dev_attr.attr;
 			cnt++;
@@ -588,10 +588,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
 			st->iio_attr[cnt].dev_attr.store =
 				ad7280_store_balance_timer;
 			st->iio_attr[cnt].dev_attr.attr.name =
-				kasprintf(GFP_KERNEL,
-					  "in%d-in%d_balance_timer",
-					  dev * AD7280A_CELLS_PER_DEV + ch,
-					  dev * AD7280A_CELLS_PER_DEV + ch + 1);
+				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
+					       "in%d-in%d_balance_timer",
+					       index, index + 1);
 			ad7280_attributes[cnt] =
 				&st->iio_attr[cnt].dev_attr.attr;
 		}
@@ -692,7 +691,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	unsigned int *channels;
 	int i, ret;
 
-	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
+	channels = devm_kcalloc(&st->spi->dev, st->scan_cnt, sizeof(*channels),
+				GFP_KERNEL);
 	if (!channels)
 		return IRQ_HANDLED;
 
@@ -744,7 +744,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	}
 
 out:
-	kfree(channels);
+	devm_kfree(&st->spi->dev, channels);
 
 	return IRQ_HANDLED;
 }
@@ -909,48 +909,38 @@ static int ad7280_probe(struct spi_device *spi)
 
 	ret = ad7280_attr_init(st);
 	if (ret < 0)
-		goto error_free_channels;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
-		goto error_free_attr;
+		return ret;
 
 	if (spi->irq > 0) {
 		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
 				   AD7280A_ALERT, 1,
 				   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
 		if (ret)
-			goto error_unregister;
+			return ret;
 
 		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
 				   AD7280A_ALERT, 0,
 				   AD7280A_ALERT_GEN_STATIC_HIGH |
 				   (pdata->chain_last_alert_ignore & 0xF));
 		if (ret)
-			goto error_unregister;
-
-		ret = request_threaded_irq(spi->irq,
-					   NULL,
-					   ad7280_event_handler,
-					   IRQF_TRIGGER_FALLING |
-					   IRQF_ONESHOT,
-					   indio_dev->name,
-					   indio_dev);
+			return ret;
+
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+						NULL,
+						ad7280_event_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						indio_dev->name,
+						indio_dev);
 		if (ret)
-			goto error_unregister;
+			return ret;
 	}
 
 	return 0;
-error_unregister:
-	iio_device_unregister(indio_dev);
-
-error_free_attr:
-	kfree(st->iio_attr);
-
-error_free_channels:
-	kfree(st->channels);
-
-	return ret;
 }
 
 static int ad7280_remove(struct spi_device *spi)
@@ -958,16 +948,9 @@ static int ad7280_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7280_state *st = iio_priv(indio_dev);
 
-	if (spi->irq > 0)
-		free_irq(spi->irq, indio_dev);
-	iio_device_unregister(indio_dev);
-
 	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
 		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
 
-	kfree(st->channels);
-	kfree(st->iio_attr);
-
 	return 0;
 }
 
-- 
2.19.1
