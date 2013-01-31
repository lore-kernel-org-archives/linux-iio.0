Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1089 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab3AaO1G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:06 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] staging:iio:adxrs450: Use usleep_range for the sequential transfer dealy
Date: Thu, 31 Jan 2013 15:27:55 +0100
Message-Id: <1359642478-9622-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adxrs450 requires a delay of at least 0.1 ms between register writes.  Using
msleep() for such small delays is not recommended. So use usleep_range instead.

Fixes the following checkpatch warning:
	WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
	+	msleep(1);

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index ea10f84..4115fe1 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -101,7 +101,7 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
 	if (ret)
 		dev_err(&st->us->dev, "problem while writing 16 bit register 0x%02x\n",
 			reg_address);
-	msleep(1); /* enforce sequential transfer delay 0.1ms */
+	usleep_range(100, 1000); /* enforce sequential transfer delay 0.1ms */
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
-- 
1.8.0

