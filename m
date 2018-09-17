Return-Path: <SRS0=hvqp=L7=sirena.org.uk=broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: add software implementation for SPI_CS_WORD" to the spi tree
In-Reply-To: <20180913003920.30600-3-david@lechnology.com>
Message-Id: <20180917212227.9D661440079@finisterre.ee.mobilebroadband>
Date: Mon, 17 Sep 2018 22:22:27 +0100 (BST)
List-ID: <linux-iio@vger.kernel.org>

The patch

   spi: add software implementation for SPI_CS_WORD

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

>From cbaa62e0094a840fecc853910e0c0454529cec03 Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Wed, 12 Sep 2018 19:39:18 -0500
Subject: [PATCH] spi: add software implementation for SPI_CS_WORD

This adds a default software implementation for the SPI_CS_WORD flag for
controllers that don't have such a feature.

The SPI_CS_WORD flag indicates that the CS line should be toggled
between each word sent, not just between each transfer. The
implementation works by using existing functions to split transfers into
one-word-sized transfers and sets the cs_change bit for each of the
new transfers.

Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6baf9c..be73d236919f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2774,8 +2774,10 @@ int spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
+	 * SPI_CS_WORD has a fallback software implementation,
+	 * so it is ignored here.
 	 */
-	bad_bits = spi->mode & ~spi->controller->mode_bits;
+	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
 	if (ugly_bits) {
@@ -2829,6 +2831,33 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 
+	/* If an SPI controller does not support toggling the CS line on each
+	 * transfer (indicated by the SPI_CS_WORD flag), we can emulate it by
+	 * splitting transfers into one-word transfers and ensuring that
+	 * cs_change is set for each transfer.
+	 */
+	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {
+		size_t maxsize;
+		int ret;
+
+		maxsize = (spi->bits_per_word + 7) / 8;
+
+		/* spi_split_transfers_maxsize() requires message->spi */
+		message->spi = spi;
+
+		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
+						  GFP_KERNEL);
+		if (ret)
+			return ret;
+
+		list_for_each_entry(xfer, &message->transfers, transfer_list) {
+			/* don't change cs_change on the last entry in the list */
+			if (list_is_last(&xfer->transfer_list, &message->transfers))
+				break;
+			xfer->cs_change = 1;
+		}
+	}
+
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
 	 * either MOSI or MISO is missing.  They can also be caused by
-- 
2.19.0
