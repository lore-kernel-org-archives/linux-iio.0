Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/22] staging:iio:ad7793: Fix internal reference value
Date: Fri, 10 Aug 2012 18:36:20 +0200
Message-Id: <1344616596-8026-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The internal reference for the ad7793 and similar is 1.17V

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 91cb95c..112e2b7 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -922,7 +922,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	else if (voltage_uv)
 		st->int_vref_mv = voltage_uv / 1000;
 	else
-		st->int_vref_mv = 2500; /* Build-in ref */
+		st->int_vref_mv = 1170; /* Build-in ref */
 
 	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
-- 
1.7.10.4
