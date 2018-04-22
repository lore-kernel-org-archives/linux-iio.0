Return-Path: <SRS0=zKlK=HL=gmail.com=davidjulianveenstra@kernel.org>
Date: Mon, 23 Apr 2018 00:03:32 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
	devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v3 4/9] staging: iio: ad2s1200: Replace platform data with dt
 bindings
Message-ID: <b8cfea845842947415b5da44b59ed305c93cceda.1524432236.git.davidjulianveenstra@gmail.com>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524432236.git.davidjulianveenstra@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove usage of platform data, and replace it with device tree
facilities.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v3:
 - Introduced in this version.

 drivers/staging/iio/resolver/ad2s1200.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index e7bfe5aa4c45..3c7163610ff6 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -26,9 +26,6 @@
 
 #define DRV_NAME "ad2s1200"
 
-/* input pin sample and rdvel is controlled by driver */
-#define AD2S1200_PN	2
-
 /* input clock on serial interface */
 #define AD2S1200_HZ	8192000
 /* clock period in nano second */
@@ -113,20 +110,9 @@ static const struct iio_info ad2s1200_info = {
 
 static int ad2s1200_probe(struct spi_device *spi)
 {
-	unsigned short *pins = spi->dev.platform_data;
 	struct ad2s1200_state *st;
 	struct iio_dev *indio_dev;
-	int pn, ret = 0;
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
+	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -136,8 +122,20 @@ static int ad2s1200_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->sample = gpio_to_desc(pins[0]);
-	st->rdvel = gpio_to_desc(pins[1]);
+
+	st->sample = devm_gpiod_get(&spi->dev, "sample", GPIOD_OUT_LOW);
+	if (IS_ERR(st->sample)) {
+		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
+			PTR_ERR(st->sample));
+		return PTR_ERR(st->sample);
+	}
+
+	st->rdvel = devm_gpiod_get(&spi->dev, "rdvel", GPIOD_OUT_LOW);
+	if (IS_ERR(st->rdvel)) {
+		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
+			PTR_ERR(st->rdvel));
+		return PTR_ERR(st->rdvel);
+	}
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s1200_info;
-- 
2.16.2
