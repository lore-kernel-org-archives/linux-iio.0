Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1035 "EHLO
	smtp-out-078.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753562Ab2DWRtT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Apr 2012 13:49:19 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] staging:iio:dac:ad5446: Do not check for individual chip ids in probe
Date: Mon, 23 Apr 2012 19:51:32 +0200
Message-Id: <1335203497-11041-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-1-git-send-email-lars@metafoo.de>
References: <1335203497-11041-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the chip_info's int_vref_mv field to decide whether a certain chip has a
internal reference or not. There is no need to check for individual chip ids.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 0cfe445..9d9a452 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -355,22 +355,12 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
 
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

