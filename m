Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34067 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbcGCA0n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jul 2016 20:26:43 -0400
Received: by mail-pa0-f66.google.com with SMTP id us13so12724483pab.1
        for <linux-iio@vger.kernel.org>; Sat, 02 Jul 2016 17:26:43 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: adc: add missing of_node references to iio_dev
Date: Sat,  2 Jul 2016 17:26:33 -0700
Message-Id: <1467505593-7125-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding missing indio_dev->dev.of_node references to allow iio consumers
to access the device channels.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/adc/ad7266.c        | 1 +
 drivers/iio/adc/ad7291.c        | 1 +
 drivers/iio/adc/ad7298.c        | 1 +
 drivers/iio/adc/ad7476.c        | 1 +
 drivers/iio/adc/ad7791.c        | 1 +
 drivers/iio/adc/ad7793.c        | 1 +
 drivers/iio/adc/ad7887.c        | 1 +
 drivers/iio/adc/ad7923.c        | 1 +
 drivers/iio/adc/ad799x.c        | 1 +
 drivers/iio/adc/hi8435.c        | 1 +
 drivers/iio/adc/ina2xx-adc.c    | 1 +
 drivers/iio/adc/max1027.c       | 1 +
 drivers/iio/adc/max1363.c       | 1 +
 drivers/iio/adc/mcp320x.c       | 1 +
 drivers/iio/adc/mcp3422.c       | 1 +
 drivers/iio/adc/nau7802.c       | 1 +
 drivers/iio/adc/ti-adc081c.c    | 1 +
 drivers/iio/adc/ti-adc0832.c    | 1 +
 drivers/iio/adc/ti-adc128s052.c | 1 +
 drivers/iio/adc/ti-ads8688.c    | 1 +
 20 files changed, 20 insertions(+)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 11c65db14747..c0f6a98fd9bd 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -440,6 +440,7 @@ static int ad7266_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7266_info;
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index c0eabf156702..b9e6ab4a47df 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -505,6 +505,7 @@ static int ad7291_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad7291_channels);
 
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->info = &ad7291_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 62bb8f7ce4a0..31938eddefd5 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -315,6 +315,7 @@ static int ad7298_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad7298_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 810c9a9fa62f..81871897e845 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -227,6 +227,7 @@ static int ad7476_probe(struct spi_device *spi)
 
 	/* Establish that the iio_dev is a child of the spi device */
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channel;
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 1dfe6410c64c..1817ebf5ad84 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -375,6 +375,7 @@ static int ad7791_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index a43722fbf03a..847789bae821 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -784,6 +784,7 @@ static int ad7793_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index ee2ccc19fab6..361f0b4eb66a 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -264,6 +264,7 @@ static int ad7887_probe(struct spi_device *spi)
 
 	/* Estabilish that the iio_dev is a child of the spi device */
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad7887_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index ff444c19d749..244e3642a459 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -288,6 +288,7 @@ static int ad7923_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = info->channels;
 	indio_dev->num_channels = info->num_channels;
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index ec0200dd52cb..79d4cb18b4a1 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -806,6 +806,7 @@ static int ad799x_probe(struct i2c_client *client,
 	st->client = client;
 
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->name = id->name;
 	indio_dev->info = st->chip_config->info;
 
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index c73c6c62a6ac..4bc6b25b8e8c 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -455,6 +455,7 @@ static int hi8435_probe(struct spi_device *spi)
 	mutex_init(&priv->lock);
 
 	idev->dev.parent	= &spi->dev;
+	idev->dev.of_node	= spi->dev.of_node;
 	idev->name		= spi_get_device_id(spi)->name;
 	idev->modes		= INDIO_DIRECT_MODE;
 	idev->info		= &hi8435_info;
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 502f2fbe8aef..f098fb0da723 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -691,6 +691,7 @@ static int ina2xx_probe(struct i2c_client *client,
 
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->channels = ina2xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ina2xx_channels);
 	indio_dev->name = id->name;
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 41d495c6035e..712fbd2b1f16 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -426,6 +426,7 @@ static int max1027_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->info = &max1027_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 998dc3caad4c..063ad7eebda5 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1587,6 +1587,7 @@ static int max1363_probe(struct i2c_client *client,
 
 	/* Establish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->name = id->name;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index a850ca7d1eda..634717ae12f3 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -308,6 +308,7 @@ static int mcp320x_probe(struct spi_device *spi)
 	adc->spi = spi;
 
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp320x_info;
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index d1172dc1e8e2..254135e07792 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -352,6 +352,7 @@ static int mcp3422_probe(struct i2c_client *client,
 	mutex_init(&adc->lock);
 
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3422_info;
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 57365c504093..db9b829ccf0d 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -433,6 +433,7 @@ static int nau7802_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &nau7802_info;
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index f8807adc08c4..c4bd18a4f86d 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -185,6 +185,7 @@ static int adc081c_probe(struct i2c_client *client,
 		return err;
 
 	iio->dev.parent = &client->dev;
+	iio->dev.of_node = client->dev.of_node;
 	iio->name = dev_name(&client->dev);
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &adc081c_info;
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 0afeac0c9bad..f4ba23effe9a 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -194,6 +194,7 @@ static int adc0832_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->info = &adc0832_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index bc58867d6e8d..89dfbd31be5c 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -150,6 +150,7 @@ static int adc128_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &adc128_info;
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 03e907028cb6..c400439900af 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -421,6 +421,7 @@ static int ads8688_probe(struct spi_device *spi)
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
-- 
2.7.4

