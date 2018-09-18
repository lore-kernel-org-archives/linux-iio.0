Return-Path: <SRS0=jqtk=MA=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio
Date: Tue, 18 Sep 2018 12:08:49 -0500
Message-Id: <20180918170850.2749-3-david@lechnology.com>
In-Reply-To: <20180918170850.2749-1-david@lechnology.com>
References: <20180918170850.2749-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This remove the check and subsequent return of error for the case when
a SPI device requires SPI_CS_WORD and is also configured to use a GPIO
for the CS line.

Commit a134cc414e86 ("spi: always use software fallback for SPI_CS_WORD
when using cs_gio") handles this case now, so this check is no longer
necessary.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi-davinci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 205f763c7383..56adec83f8fc 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -441,9 +441,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 
 		if (internal_cs) {
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
-		} else if (spi->mode & SPI_CS_WORD) {
-			dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
-			return -EINVAL;
 		}
 	}
 
-- 
2.17.1
