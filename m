Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1102 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3GQOoK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:10 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/15] staging:iio:adis16260: Add scale for the inclination channel
Date: Wed, 17 Jul 2013 16:44:35 +0200
Message-Id: <1374072279-7140-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

While the inclination channel claims to support reading the scale the driver did
not implement this, so trying to read the scale results in a -EINVAL. This patch
fixes it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index a140d73..48b0e63 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -241,6 +241,10 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 				*val2 = IIO_DEGREE_TO_RAD(73260);
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_INCLI:
+			*val = 0;
+			*val2 = IIO_DEGREE_TO_RAD(36630);
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_VOLTAGE:
 			if (chan->channel == 0) {
 				*val = 1;
-- 
1.8.0

