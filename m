Return-Path: <SRS0=oein=HJ=gmail.com=davidjulianveenstra@kernel.org>
Date: Fri, 20 Apr 2018 21:30:19 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 06/13] staging: iio: ad2s1200: Introduce variable for
 repeated value
Message-ID: <6ec9752ef32af09d0f0f419030be09d1dec68c6d.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add variable to hold &spi->dev in ad2s1200_probe. This value is repeatedly
used in ad2s1200_probe.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index f07aab7e7a35..0a5fc9917e32 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -117,19 +117,22 @@ static int ad2s1200_probe(struct spi_device *spi)
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
 
@@ -140,14 +143,14 @@ static int ad2s1200_probe(struct spi_device *spi)
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
