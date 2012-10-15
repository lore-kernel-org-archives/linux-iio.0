Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1087 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab2JOJee (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2012 05:34:34 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] staging:iio: Fix adis16201 channel offsets and scales
Date: Mon, 15 Oct 2012 11:35:25 +0200
Message-Id: <1350293734-21951-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-1-git-send-email-lars@metafoo.de>
References: <1350293734-21951-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the channel offsets and scales in the adis16201 are incorrect:
	* Temperature scale is off by a factor of 1000
	* Voltage scale is off by a factor of 1000
	* Acceleration scale is in g instead of m/(s**2)
	* Temperature offset is completely wrong

This patch fixes these issues.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16201_core.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 8e37d6e..b12ca68 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -310,30 +310,32 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			*val = 0;
-			if (chan->channel == 0)
-				*val2 = 1220;
-			else
-				*val2 = 610;
+			if (chan->channel == 0) {
+				*val = 1;
+				*val2 = 220000; /* 1.22 mV */
+			} else {
+				*val = 0;
+				*val2 = 610000; /* 0.610 mV */
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = 0;
-			*val2 = -470000;
+			*val = -470; /* 0.47 C */
+			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			*val = 0;
-			*val2 = 462500;
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
+			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 100000;
+			*val2 = 100000; /* 0.1 degree */
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25;
+		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
-- 
1.7.10.4

