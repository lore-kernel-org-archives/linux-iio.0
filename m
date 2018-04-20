Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35475 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDTTas (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:30:48 -0400
Date: Fri, 20 Apr 2018 21:30:44 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 08/13] staging: iio: ad2s1200: Replace legacy gpio API
 with modern API
Message-ID: <4253be22c7081a5032b59097bc166f559e7b1cea.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The legacy, integer based gpio API is replaced with the descriptor
based API.

For compatibility, it is first tried to use the platform data to
request the gpio's. Otherwise, it looks for the "sample" and "rdvel"
gpio function.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 51 ++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 11ed9c7332e6..29a9bb666e7b 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spi/spi.h>
@@ -44,8 +45,8 @@
 struct ad2s1200_state {
 	struct mutex lock;
 	struct spi_device *sdev;
-	int sample;
-	int rdvel;
+	struct gpio_desc *sample;
+	struct gpio_desc *rdvel;
 	u8 rx[2] ____cacheline_aligned;
 };
 
@@ -60,12 +61,12 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 	u16 vel;
 
 	mutex_lock(&st->lock);
-	gpio_set_value(st->sample, 0);
+	gpiod_set_value(st->sample, 0);
 
 	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
 	udelay(1);
-	gpio_set_value(st->sample, 1);
-	gpio_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
+	gpiod_set_value(st->sample, 1);
+	gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
 
 	ret = spi_read(st->sdev, st->rx, 2);
 	if (ret < 0) {
@@ -121,13 +122,18 @@ static int ad2s1200_probe(struct spi_device *spi)
 
 	dev = &spi->dev;
 
-	for (pn = 0; pn < AD2S1200_PN; pn++) {
-		ret = devm_gpio_request_one(dev, pins[pn], GPIOF_DIR_OUT,
-					    DRV_NAME);
-		if (ret) {
-			dev_err(dev, "request gpio pin %d failed\n",
-				pins[pn]);
-			return ret;
+	if (pins) {
+		for (pn = 0; pn < AD2S1200_PN; pn++) {
+			ret = devm_gpio_request_one(dev, pins[pn],
+						    GPIOF_DIR_OUT,
+						    DRV_NAME);
+			if (ret) {
+				dev_err(dev,
+					"Failed to claim gpio %d\n: err=%d",
+					pins[pn],
+					ret);
+				return ret;
+			}
 		}
 	}
 
@@ -139,8 +145,25 @@ static int ad2s1200_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->sample = pins[0];
-	st->rdvel = pins[1];
+
+	if (pins) {
+		st->sample = gpio_to_desc(pins[0]);
+		st->rdvel = gpio_to_desc(pins[1]);
+	} else {
+		st->sample = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
+		if (IS_ERR(st->sample)) {
+			dev_err(dev, "Failed to claim SAMPLE gpio: err=%ld\n",
+				PTR_ERR(st->sample));
+			return PTR_ERR(st->sample);
+		}
+
+		st->rdvel = devm_gpiod_get(dev, "rdvel", GPIOD_OUT_LOW);
+		if (IS_ERR(st->rdvel)) {
+			dev_err(dev, "Failed to claim RDVEL gpio: err=%ld\n",
+				PTR_ERR(st->rdvel));
+			return PTR_ERR(st->rdvel);
+		}
+	}
 
 	indio_dev->dev.parent = dev;
 	indio_dev->info = &ad2s1200_info;
-- 
2.16.2

