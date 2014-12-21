Return-Path: <md.jamalmohiuddin@gmail.com>
From: Mohammad Jamal <md.jamalmohiuddin@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Mohammad Jamal <md.jamalmohiuddin@gmail.com>
Subject: [PATCH] staging: iio: adc: ad7192: fix space before , coding style issue
Date: Sun, 21 Dec 2014 18:05:31 +0530
Message-Id: <1419165331-29356-1-git-send-email-md.jamalmohiuddin@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch solves the space before , error of the checkpatch.pl

Signed-off-by: Mohammad Jamal <md.jamalmohiuddin@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index f6526aa..6f8ce6c 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -612,7 +612,7 @@ static int ad7192_probe(struct spi_device *spi)
 	const struct ad7192_platform_data *pdata = spi->dev.platform_data;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
-	int ret , voltage_uv = 0;
+	int ret, voltage_uv = 0;
 
 	if (!pdata) {
 		dev_err(&spi->dev, "no platform data?\n");
-- 
1.7.9.5
