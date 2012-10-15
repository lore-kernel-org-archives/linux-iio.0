Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1028 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab2JOJeh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2012 05:34:37 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/11] staging:iio: Fix adis16240 channel offsets and scales
Date: Mon, 15 Oct 2012 11:35:30 +0200
Message-Id: <1350293734-21951-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-1-git-send-email-lars@metafoo.de>
References: <1350293734-21951-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the channel offsets and scales in the adis16240 are incorrect:
    * Temperature scale is of by a factor of 1000
    * Voltage scale is of by a factor of 1000
    * Temperature offset is completely wrong
	* Peak scale is completely wrong

This patch fixes these issues. Also use the IIO_G_TO_M_S_2 macro for the
acceleration scale since this makes it much easier to compare it to the value
given in the datasheet.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16240_core.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 0fc26a4..35e0939 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -373,30 +373,31 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			*val = 0;
-			if (chan->channel == 0)
-				*val2 = 4880;
-			else
+			if (chan->channel == 0) {
+				*val = 4;
+				*val2 = 880000; /* 4.88 mV */
+				return IIO_VAL_INT_PLUS_MICRO;
+			} else {
 				return -EINVAL;
-			return IIO_VAL_INT_PLUS_MICRO;
+			}
 		case IIO_TEMP:
-			*val = 0;
-			*val2 = 244000;
+			*val = 244; /* 0.244 C */
+			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			*val = 0;
-			*val2 = 504062;
+			*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_PEAK_SCALE:
-		*val = 6;
-		*val2 = 629295;
+		*val = 0;
+		*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25;
+		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		bits = 10;
-- 
1.7.10.4

