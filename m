Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:adc:ad7476: Incorrect pointer into spi_set_drvdata.
Date: Wed, 13 Jul 2011 13:42:47 +0100
Message-Id: <1310560967-1287-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310560967-1287-1-git-send-email-jic23@cam.ac.uk>
References: <1310560967-1287-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Will cause issues only on driver removal.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7476_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 768f3ec..c210898 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -159,7 +159,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	else
 		dev_warn(&spi->dev, "reference voltage unspecified\n");
 
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
 	st->spi = spi;
 
-- 
1.7.3.4
