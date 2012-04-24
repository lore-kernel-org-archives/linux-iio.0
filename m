Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 05/11] staging:iio:dac:ad5446: Do not check for individual chip ids in probe
Date: Tue, 24 Apr 2012 18:49:35 +0200
Message-Id: <1335286181-20474-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-1-git-send-email-lars@metafoo.de>
References: <1335286181-20474-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use the chip_info's int_vref_mv field to decide whether a certain chip has a
internal reference or not. There is no need to check for individual chip ids.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5446.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 2ce6b5b..659d083 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -344,22 +344,12 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 
-	switch (spi_get_device_id(spi)->driver_data) {
-	case ID_AD5620_2500:
-	case ID_AD5620_1250:
-	case ID_AD5640_2500:
-	case ID_AD5640_1250:
-	case ID_AD5660_2500:
-	case ID_AD5660_1250:
+	if (st->chip_info->int_vref_mv)
 		st->vref_mv = st->chip_info->int_vref_mv;
-		break;
-	default:
-		if (voltage_uv)
-			st->vref_mv = voltage_uv / 1000;
-		else
-			dev_warn(&spi->dev,
-				 "reference voltage unspecified\n");
-	}
+	else if (voltage_uv)
+		st->vref_mv = voltage_uv / 1000;
+	else
+		dev_warn(&spi->dev, "reference voltage unspecified\n");
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.9.5
