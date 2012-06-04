Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/18] staging:iio:dac:ad5504: Check if IRQ was requested before freeing it
Date: Mon,  4 Jun 2012 11:36:25 +0200
Message-Id: <1338802588-10585-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1338802588-10585-1-git-send-email-lars@metafoo.de>
References: <1338802588-10585-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

IRQ support is optional, so we have to check whether it was actually requested
before we attempt to free it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5504.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 220150d..f3d7b47 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -294,7 +294,8 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	return 0;
 
 error_free_irq:
-	free_irq(spi->irq, indio_dev);
+	if (spi->irq)
+		free_irq(spi->irq, indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
-- 
1.7.10
