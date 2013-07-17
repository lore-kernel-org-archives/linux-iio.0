Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1108 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3GQOoM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:12 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/15] staging:iio:adis16260: Add proper range checks to write_frequency()
Date: Wed, 17 Jul 2013 16:44:37 +0200
Message-Id: <1374072279-7140-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A negative sampling frequency is obviously invalid, so use kstrtouint() instead
of strict_strtoul. Also when setting a sampling frequency smaller than the
minimum supported frequency set the frequency to the minimum supported frequency
instead of just cutting off the upper bits of the raw register value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index b8a6a04..d4e3dd7 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -142,29 +142,26 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis *adis = iio_priv(indio_dev);
-	long val;
+	unsigned int val;
 	int ret;
 	u8 t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
-	if (val == 0)
-		return -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
-	if (spi_get_device_id(adis->spi)->driver_data) {
-		t = (256 / val);
-		if (t > 0)
-			t--;
-		t &= ADIS16260_SMPL_PRD_DIV_MASK;
-	} else {
-		t = (2048 / val);
-		if (t > 0)
-			t--;
-		t &= ADIS16260_SMPL_PRD_DIV_MASK;
-	}
-	if ((t & ADIS16260_SMPL_PRD_DIV_MASK) >= 0x0A)
+	if (spi_get_device_id(adis->spi)->driver_data)
+		t = 256 / val;
+	else
+		t = 2048 / val;
+
+	if (t > ADIS16260_SMPL_PRD_DIV_MASK)
+		t = ADIS16260_SMPL_PRD_DIV_MASK;
+	else if (t > 0)
+		t--;
+
+	if (t >= 0x0A)
 		adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
 	else
 		adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
-- 
1.8.0

