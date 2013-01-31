Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1044 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3AaO1D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:03 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/11] staging:iio:adxrs450: Don't spam the bootlog
Date: Thu, 31 Jan 2013 15:27:52 +0100
Message-Id: <1359642478-9622-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Don't spam the bootlog with the devices part id and serial number.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450_core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 96e5284..24b7a0f 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -231,20 +231,6 @@ static int adxrs450_initial_setup(struct iio_dev *indio_dev)
 		dev_err(&st->us->dev, "The device is not in normal status!\n");
 		return -EINVAL;
 	}
-	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_PID1, &data);
-	if (ret)
-		return ret;
-	dev_info(&st->us->dev, "The Part ID is 0x%x\n", data);
-
-	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_SNL, &data);
-	if (ret)
-		return ret;
-	t = data;
-	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_SNH, &data);
-	if (ret)
-		return ret;
-	t |= data << 16;
-	dev_info(&st->us->dev, "The Serial Number is 0x%x\n", t);
 
 	return 0;
 }
-- 
1.8.0

