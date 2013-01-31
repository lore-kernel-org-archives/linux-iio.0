Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1082 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab3AaO1C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:02 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] staging:iio:adxrs450: Reject out of range calibscale values
Date: Thu, 31 Jan 2013 15:27:51 +0100
Message-Id: <1359642478-9622-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Instead of silently discarding the upper bits reject out of range values for the
calibscale property.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 4c462d3..96e5284 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -258,9 +258,10 @@ static int adxrs450_write_raw(struct iio_dev *indio_dev,
 	int ret;
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val < -0x400 || val >= 0x400)
+			return -EINVAL;
 		ret = adxrs450_spi_write_reg_16(indio_dev,
-						ADXRS450_DNC1,
-						val & 0x3FF);
+						ADXRS450_DNC1, val);
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.8.0

