Return-Path: <SRS0=T3RB=MA=sirena.org.uk=broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio" to the spi tree
In-Reply-To: <20180918170850.2749-3-david@lechnology.com>
Message-Id: <20180918174549.DE9B4440078@finisterre.ee.mobilebroadband>
Date: Tue, 18 Sep 2018 18:45:49 +0100 (BST)
List-ID: <linux-iio@vger.kernel.org>

The patch

   spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f34ecdbd5661816ce8bbd7511f33181ffa8f4895 Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Tue, 18 Sep 2018 12:08:49 -0500
Subject: [PATCH] spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio

This remove the check and subsequent return of error for the case when
a SPI device requires SPI_CS_WORD and is also configured to use a GPIO
for the CS line.

Commit a134cc414e86 ("spi: always use software fallback for SPI_CS_WORD
when using cs_gio") handles this case now, so this check is no longer
necessary.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0
