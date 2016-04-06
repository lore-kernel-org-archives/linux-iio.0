Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34161 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbcDFFUD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 01:20:03 -0400
Date: Tue, 5 Apr 2016 22:20:00 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 7/9] iio: health: afe4403: use regmap to retrieve struct
 device
Message-ID: <7150183b87729a0d287cf270f58de85079d40468.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1459918214.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver includes struct regmap and struct device in its global data.
Remove the struct device and use regmap API to retrieve device info.

Patch created using Coccinelle plus manual edits.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/health/afe4403.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 88e43f8..71b8f70 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -104,7 +104,6 @@
 
 /**
  * struct afe4403_data
- * @dev - Device structure
  * @spi - SPI device handle
  * @regmap - Register map of the device
  * @regulator - Pointer to the regulator for the IC
@@ -112,7 +111,6 @@
  * @irq - ADC_RDY line interrupt number
  */
 struct afe4403_data {
-	struct device *dev;
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct regulator *regulator;
@@ -562,55 +560,54 @@ static int afe4403_probe(struct spi_device *spi)
 	afe = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
-	afe->dev = &spi->dev;
 	afe->spi = spi;
 	afe->irq = spi->irq;
 
 	afe->regmap = devm_regmap_init_spi(spi, &afe4403_regmap_config);
 	if (IS_ERR(afe->regmap)) {
-		dev_err(afe->dev, "Unable to allocate register map\n");
+		dev_err(&spi->dev, "Unable to allocate register map\n");
 		return PTR_ERR(afe->regmap);
 	}
 
-	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
+	afe->regulator = devm_regulator_get(&spi->dev, "tx_sup");
 	if (IS_ERR(afe->regulator)) {
-		dev_err(afe->dev, "Unable to get regulator\n");
+		dev_err(&spi->dev, "Unable to get regulator\n");
 		return PTR_ERR(afe->regulator);
 	}
 	ret = regulator_enable(afe->regulator);
 	if (ret) {
-		dev_err(afe->dev, "Unable to enable regulator\n");
+		dev_err(&spi->dev, "Unable to enable regulator\n");
 		return ret;
 	}
 
 	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
 			   AFE440X_CONTROL0_SW_RESET);
 	if (ret) {
-		dev_err(afe->dev, "Unable to reset device\n");
+		dev_err(&spi->dev, "Unable to reset device\n");
 		goto err_disable_reg;
 	}
 
 	ret = regmap_multi_reg_write(afe->regmap, afe4403_reg_sequences,
 				     ARRAY_SIZE(afe4403_reg_sequences));
 	if (ret) {
-		dev_err(afe->dev, "Unable to set register defaults\n");
+		dev_err(&spi->dev, "Unable to set register defaults\n");
 		goto err_disable_reg;
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->dev.parent = afe->dev;
+	indio_dev->dev.parent = &spi->dev;
 	indio_dev->channels = afe4403_channels;
 	indio_dev->num_channels = ARRAY_SIZE(afe4403_channels);
 	indio_dev->name = AFE4403_DRIVER_NAME;
 	indio_dev->info = &afe4403_iio_info;
 
 	if (afe->irq > 0) {
-		afe->trig = devm_iio_trigger_alloc(afe->dev,
+		afe->trig = devm_iio_trigger_alloc(&spi->dev,
 						   "%s-dev%d",
 						   indio_dev->name,
 						   indio_dev->id);
 		if (!afe->trig) {
-			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
+			dev_err(&spi->dev, "Unable to allocate IIO trigger\n");
 			ret = -ENOMEM;
 			goto err_disable_reg;
 		}
@@ -618,21 +615,21 @@ static int afe4403_probe(struct spi_device *spi)
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
 		afe->trig->ops = &afe4403_trigger_ops;
-		afe->trig->dev.parent = afe->dev;
+		afe->trig->dev.parent = &spi->dev;
 
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
-			dev_err(afe->dev, "Unable to register IIO trigger\n");
+			dev_err(&spi->dev, "Unable to register IIO trigger\n");
 			goto err_disable_reg;
 		}
 
-		ret = devm_request_threaded_irq(afe->dev, afe->irq,
+		ret = devm_request_threaded_irq(&spi->dev, afe->irq,
 						iio_trigger_generic_data_rdy_poll,
 						NULL, IRQF_ONESHOT,
 						AFE4403_DRIVER_NAME,
 						afe->trig);
 		if (ret) {
-			dev_err(afe->dev, "Unable to request IRQ\n");
+			dev_err(&spi->dev, "Unable to request IRQ\n");
 			goto err_trig;
 		}
 	}
@@ -640,13 +637,13 @@ static int afe4403_probe(struct spi_device *spi)
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
 					 afe4403_trigger_handler, NULL);
 	if (ret) {
-		dev_err(afe->dev, "Unable to setup buffer\n");
+		dev_err(&spi->dev, "Unable to setup buffer\n");
 		goto err_trig;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(afe->dev, "Unable to register IIO device\n");
+		dev_err(&spi->dev, "Unable to register IIO device\n");
 		goto err_buff;
 	}
 
@@ -667,6 +664,7 @@ static int afe4403_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct afe4403_data *afe = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(afe->regmap);
 	int ret;
 
 	iio_device_unregister(indio_dev);
@@ -678,7 +676,7 @@ static int afe4403_remove(struct spi_device *spi)
 
 	ret = regulator_disable(afe->regulator);
 	if (ret) {
-		dev_err(afe->dev, "Unable to disable regulator\n");
+		dev_err(dev, "Unable to disable regulator\n");
 		return ret;
 	}
 
-- 
2.1.4

