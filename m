Return-Path: <SRS0=tHw2=KC=sirena.org.uk=broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-bitbang: change flags from u8 to u16" to the spi tree
In-Reply-To: <20180717032052.12273-2-david@lechnology.com>
Message-Id: <E1ffoCT-0004O3-0g@debutante>
Date: Wed, 18 Jul 2018 16:17:09 +0100
List-ID: <linux-iio@vger.kernel.org>

The patch

   spi: spi-bitbang: change flags from u8 to u16

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

>From 7c201ead1bfd19935f689fca69100c335028c047 Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Mon, 16 Jul 2018 22:20:49 -0500
Subject: [PATCH] spi: spi-bitbang: change flags from u8 to u16

This changes the data type of the flags field in struct spi_bitbang from
u8 to u16. This matches the size of the mode field of struct spi_device
where these flags are also used.

This is done in preparation of adding a new SPI mode flag that will be
used with this field that would otherwise not fit in 8 bits.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi_bitbang.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 51d8c060e513..c1e61641a7f1 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -8,7 +8,7 @@ struct spi_bitbang {
 	struct mutex		lock;
 	u8			busy;
 	u8			use_dma;
-	u8			flags;		/* extra spi->mode support */
+	u16			flags;		/* extra spi->mode support */
 
 	struct spi_master	*master;
 
-- 
2.18.0
