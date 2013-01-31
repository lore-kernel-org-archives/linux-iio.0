Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1145 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab3AaO1A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:00 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/11] staging:iio:adxrs450: Perform sign extension for the calibbias register
Date: Thu, 31 Jan 2013 15:27:50 +0100
Message-Id: <1359642478-9622-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The calibbias (DNC) register contains a 10-bit twos complement value. Perform a
proper sign extension when reading the register, otherwise negative will
incorrectly be displayed as large positive values.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 91a2fae..4c462d3 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -326,7 +326,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_DNC1, &t);
 		if (ret)
 			break;
-		*val = t;
+		*val = sign_extend32(t, 9);
 		ret = IIO_VAL_INT;
 		break;
 	default:
-- 
1.8.0

