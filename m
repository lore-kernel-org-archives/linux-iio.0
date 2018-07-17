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
Subject: [PATCH 2/4] spi: add new SPI_CS_WORD flag
Date: Mon, 16 Jul 2018 22:20:50 -0500
Message-Id: <20180717032052.12273-3-david@lechnology.com>
In-Reply-To: <20180717032052.12273-1-david@lechnology.com>
References: <20180717032052.12273-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
that a SPI device requires the chip select to be toggled after each
word that is transferred.

Signed-off-by: David Lechner <david@lechnology.com>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e05321..7cc1466111f5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -163,6 +163,7 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
@@ -177,7 +178,6 @@ struct spi_device {
 	 * the controller talks to each chip, like:
 	 *  - memory packing (12 bit samples into low bits, others zeroed)
 	 *  - priority
-	 *  - drop chipselect after each word
 	 *  - chipselect delays
 	 *  - ...
 	 */
-- 
2.17.1
