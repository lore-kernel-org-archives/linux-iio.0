Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40633 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCRNfu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Mar 2018 09:35:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id t6so10823663wmt.5
        for <linux-iio@vger.kernel.org>; Sun, 18 Mar 2018 06:35:49 -0700 (PDT)
Date: Sun, 18 Mar 2018 14:35:46 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 05/11] staging: iio: ad2s1200: Introduce variable for
 repeated value
Message-ID: <bee0f530c7bc4756a1c4fd3b533a6496d17d1a62.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521379685.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add variable to hold &spi->dev in ad2s1200_probe. This value is repeatedly
used in ad2s1200_probe.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 00efba598671..eceb86e952de 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -118,19 +118,22 @@ static int ad2s1200_probe(struct spi_device *spi)
 	unsigned short *pins = spi->dev.platform_data;
 	struct ad2s1200_state *st;
 	struct iio_dev *indio_dev;
+	struct device *dev;
 	int pn, ret = 0;
 
+	dev = &spi->dev;
+
 	for (pn = 0; pn < AD2S1200_PN; pn++) {
-		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
+		ret = devm_gpio_request_one(dev, pins[pn], GPIOF_DIR_OUT,
 					    DRV_NAME);
 		if (ret) {
-			dev_err(&spi->dev, "request gpio pin %d failed\n",
+			dev_err(dev, "request gpio pin %d failed\n",
 				pins[pn]);
 			return ret;
 		}
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -141,14 +144,14 @@ static int ad2s1200_probe(struct spi_device *spi)
 	st->sample = pins[0];
 	st->rdvel = pins[1];
 
-	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.parent = dev;
 	indio_dev->info = &ad2s1200_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1200_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.16.2

