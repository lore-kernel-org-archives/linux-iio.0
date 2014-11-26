Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] staging:iio:sca3000: Don't enable channels by default
Date: Wed, 26 Nov 2014 18:55:08 +0100
Message-Id: <1417024517-7564-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-1-git-send-email-lars@metafoo.de>
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The convention for IIO devices is that all channels are disabled by default.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/sca3000_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index e4e5639..cd46a61 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1159,11 +1159,6 @@ static int sca3000_probe(struct spi_device *spi)
 				  ARRAY_SIZE(sca3000_channels));
 	if (ret < 0)
 		goto error_unregister_dev;
-	if (indio_dev->buffer) {
-		iio_scan_mask_set(indio_dev, indio_dev->buffer, 0);
-		iio_scan_mask_set(indio_dev, indio_dev->buffer, 1);
-		iio_scan_mask_set(indio_dev, indio_dev->buffer, 2);
-	}
 
 	if (spi->irq) {
 		ret = request_threaded_irq(spi->irq,
-- 
1.8.0
