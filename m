Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbeIRXUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Sep 2018 19:20:22 -0400
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: always use software fallback for SPI_CS_WORD when using cs_gio" to the spi tree
In-Reply-To: <20180918170850.2749-2-david@lechnology.com>
Message-Id: <20180918174552.AAC6D440078@finisterre.ee.mobilebroadband>
Date: Tue, 18 Sep 2018 18:45:52 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch

   spi: always use software fallback for SPI_CS_WORD when using cs_gio

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

>From 71388b21569754ecd36eabd66fd9ca8c6d761fed Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Tue, 18 Sep 2018 12:08:48 -0500
Subject: [PATCH] spi: always use software fallback for SPI_CS_WORD when using
 cs_gio

This modifies the condition for using the software fallback
implementation for SPI_CS_WORD when the SPI controller is using a GPIO
for the CS line. When using a GPIO for CS, the hardware implementation
won't work, so we just enable the software fallback globally in this
case.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index be73d236919f..a358acdd98d3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2832,11 +2832,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
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
2.19.0
