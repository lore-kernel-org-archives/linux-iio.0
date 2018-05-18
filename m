Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53185 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeERSWh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 May 2018 14:22:37 -0400
Date: Fri, 18 May 2018 20:22:32 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 06/12] staging: iio: ad2s1200: Replace platform data with
 dt bindings
Message-ID: <6beef6b7514c53f4fac77d661dcae139b55935bf.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526667118.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove usage of platform data, and replace it with device tree
facilities.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v4:
 - Added vendor prefix to gpio function names.

 drivers/staging/iio/resolver/ad2s1200.c | 32 ++++++++++++-------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index b2c46a8c6b77..9a8aa2448897 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -25,9 +25,6 @@
 
 #define DRV_NAME "ad2s1200"
 
-/* input pin sample and rdvel is controlled by driver */
-#define AD2S1200_PN	2
-
 /* input clock on serial interface */
 #define AD2S1200_HZ	8192000
 /* clock period in nano second */
@@ -111,20 +108,9 @@ static const struct iio_info ad2s1200_info = {
 
 static int ad2s1200_probe(struct spi_device *spi)
 {
-	unsigned short *pins = spi->dev.platform_data;
 	struct ad2s1200_state *st;
 	struct iio_dev *indio_dev;
-	int pn, ret;
-
-	for (pn = 0; pn < AD2S1200_PN; pn++) {
-		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
-					    DRV_NAME);
-		if (ret) {
-			dev_err(&spi->dev, "request gpio pin %d failed\n",
-				pins[pn]);
-			return ret;
-		}
-	}
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -134,8 +120,20 @@ static int ad2s1200_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->sample = gpio_to_desc(pins[0]);
-	st->rdvel = gpio_to_desc(pins[1]);
+
+	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
+	if (IS_ERR(st->sample)) {
+		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
+			PTR_ERR(st->sample));
+		return PTR_ERR(st->sample);
+	}
+
+	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
+	if (IS_ERR(st->rdvel)) {
+		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
+			PTR_ERR(st->rdvel));
+		return PTR_ERR(st->rdvel);
+	}
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s1200_info;
-- 
2.17.0

