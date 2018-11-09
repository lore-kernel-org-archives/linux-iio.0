Return-Path: <SRS0=GCMY=NU=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	kernel-usp@googlegroups.com,
	victorcolombo@gmail.com
Subject: [PATCH 2/6] staging:iio:ad2s90: Remove spi setup that should be done via dt
Date: Fri,  9 Nov 2018 20:00:40 -0200
Message-Id: <20181109220044.24843-3-matheus.bernardino@usp.br>
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

The ad2s90 driver currently sets some spi settings (max_speed_hz and
mode) at ad2s90_probe. This should, instead, be handled via device tree.
This patch removes these configurations from the probe function.

Note: The way in which the mentioned spi settings need to be specified
on the ad2s90's node of a device tree will be documented in the future
patch "dt-bindings:iio:resolver: Add docs for ad2s90".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index ff32ca76ca00..95c118c48400 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -77,7 +77,6 @@ static int ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
-	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -94,16 +93,6 @@ static int ad2s90_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	/* need 600ns between CS and the first falling edge of SCLK */
-	spi->max_speed_hz = 830000;
-	spi->mode = SPI_MODE_3;
-	ret = spi_setup(spi);
-
-	if (ret < 0) {
-		dev_err(&spi->dev, "spi_setup failed!\n");
-		return ret;
-	}
-
 	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
-- 
2.18.0
