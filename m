Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1044 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab2JOJef (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2012 05:34:35 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/11] staging:iio: Fix adis16203 channel offsets and scales
Date: Mon, 15 Oct 2012 11:35:26 +0200
Message-Id: <1350293734-21951-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-1-git-send-email-lars@metafoo.de>
References: <1350293734-21951-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the channel offsets and scales in the adis16203 are incorrect:
	* Temperature scale is off by a factor of 1000
	* Voltage scale is off by a factor of 1000
	* Temperature offset is completely wrong

This patch fixes these issues.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16203_core.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 002fa9d..e7b3441 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -316,25 +316,27 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
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
+				*val2 = 610000; /* 0.61 mV */
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = 0;
-			*val2 = -470000;
+			*val = -470; /* -0.47 C */
+			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 25000;
+			*val2 = 25000; /* 0.025 degree */
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25;
+		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		bits = 14;
-- 
1.7.10.4

