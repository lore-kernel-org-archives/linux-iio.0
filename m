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
Subject: [PATCH 1/4] spi: spi-bitbang: change flags from u8 to u16
Date: Mon, 16 Jul 2018 22:20:49 -0500
Message-Id: <20180717032052.12273-2-david@lechnology.com>
In-Reply-To: <20180717032052.12273-1-david@lechnology.com>
References: <20180717032052.12273-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This changes the data type of the flags field in struct spi_bitbang from
u8 to u16. This matches the size of the mode field of struct spi_device
where these flags are also used.

This is done in preparation of adding a new SPI mode flag that will be
used with this field that would otherwise not fit in 8 bits.

Signed-off-by: David Lechner <david@lechnology.com>
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
2.17.1
