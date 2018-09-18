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
Subject: [PATCH 1/3] spi: always use software fallback for SPI_CS_WORD when using cs_gio
Date: Tue, 18 Sep 2018 12:08:48 -0500
Message-Id: <20180918170850.2749-2-david@lechnology.com>
In-Reply-To: <20180918170850.2749-1-david@lechnology.com>
References: <20180918170850.2749-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This modifies the condition for using the software fallback
implementation for SPI_CS_WORD when the SPI controller is using a GPIO
for the CS line. When using a GPIO for CS, the hardware implementation
won't work, so we just enable the software fallback globally in this
case.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e4fb87b304a0..03833924ca6c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2841,11 +2841,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		return -EINVAL;
 
 	/* If an SPI controller does not support toggling the CS line on each
-	 * transfer (indicated by the SPI_CS_WORD flag), we can emulate it by
+	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
+	 * for the CS line, we can emulate the CS-per-word hardware function by
 	 * splitting transfers into one-word transfers and ensuring that
 	 * cs_change is set for each transfer.
 	 */
-	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {
+	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
+					  gpio_is_valid(spi->cs_gpio))) {
 		size_t maxsize;
 		int ret;
 
-- 
2.17.1
