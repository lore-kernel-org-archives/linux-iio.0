Return-Path: <SRS0=9co7=KB=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] spi: spi-davinci: Add support for SPI_CS_WORD
Date: Mon, 16 Jul 2018 22:20:51 -0500
Message-Id: <20180717032052.12273-4-david@lechnology.com>
In-Reply-To: <20180717032052.12273-1-david@lechnology.com>
References: <20180717032052.12273-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This adds support for the SPI_CS_WORD flag to the TI DaVinci SPI
driver. This mode can be used as long as we are using the hardware
chip select and not a GPIO chip select.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi-davinci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 577084bb911b..8e4b869b50fd 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -232,7 +232,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 				!(spi->mode & SPI_CS_HIGH));
 	} else {
 		if (value == BITBANG_CS_ACTIVE) {
-			spidat1 |= SPIDAT1_CSHOLD_MASK;
+			if (!(spi->mode & SPI_CS_WORD))
+				spidat1 |= SPIDAT1_CSHOLD_MASK;
 			spidat1 &= ~(0x1 << chip_sel);
 		}
 	}
@@ -449,8 +450,12 @@ static int davinci_spi_setup(struct spi_device *spi)
 			return retval;
 		}
 
-		if (internal_cs)
+		if (internal_cs) {
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
+		} else if (spi->mode & SPI_CS_WORD) {
+			dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
+			return -EINVAL;
+		}
 	}
 
 	if (spi->mode & SPI_READY)
@@ -985,7 +990,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	dspi->prescaler_limit = pdata->prescaler_limit;
 	dspi->version = pdata->version;
 
-	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
+	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP | SPI_CS_WORD;
 	if (dspi->version == SPI_VERSION_2)
 		dspi->bitbang.flags |= SPI_READY;
 
-- 
2.17.1
