Return-Path: <SRS0=Wa0e=NG=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	kernel-usp@googlegroups.com
Subject: [PATCH 4/6] staging:iio:ad2s90: Move device registration to the end of probe
Date: Thu, 25 Oct 2018 21:45:10 -0300
Message-Id: <20181026004512.31012-5-matheus.bernardino@usp.br>
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

Previously, devm_iio_device_register was being called before the
spi_setup call and the spi_device's max_speed_hz and mode assignments.
This could lead to a race condition since the driver was still being
set up after it was already made ready to use. To fix it, this patch
moves the device registration to the end of ad2s90_probe.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index c20d37dc065a..b4a6a89c11b0 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -81,10 +81,6 @@ static int ad2s90_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-	if (ret)
-		return ret;
-
 	/* need 600ns between CS and the first falling edge of SCLK */
 	spi->max_speed_hz = 830000;
 	spi->mode = SPI_MODE_3;
@@ -95,7 +91,7 @@ static int ad2s90_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	return 0;
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
 static const struct spi_device_id ad2s90_id[] = {
-- 
2.18.0
