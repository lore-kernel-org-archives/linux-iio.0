Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1081 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2JOJei (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2012 05:34:38 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] staging:iio: Fix adis16260 channel offsets and scales
Date: Mon, 15 Oct 2012 11:35:31 +0200
Message-Id: <1350293734-21951-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-1-git-send-email-lars@metafoo.de>
References: <1350293734-21951-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the channel offsets and scales in the adis16260 are incorrect:
	* Temperature scale is off by a factor of 1000
	* Voltage scale is off by a factor of 1000
	* Temperature offset is completely wrong

This patch fixes these issues. Also use the IIO_DEGREE_TO_RAD for the angle
velocity since this makes it much easier to compare it to the value given in the
datasheet.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 9571c03..aa964a2 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -498,28 +498,33 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			*val = 0;
-			if (spi_get_device_id(st->us)->driver_data)
-				*val2 = 320;
-			else
-				*val2 = 1278;
+			if (spi_get_device_id(st->us)->driver_data) {
+				/* 0.01832 degree / sec */
+				*val2 = IIO_DEGREE_TO_RAD(18320);
+			} else {
+				/* 0.07326 degree / sec */
+				*val2 = IIO_DEGREE_TO_RAD(73260);
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_VOLTAGE:
-			*val = 0;
-			if (chan->channel == 0)
-				*val2 = 18315;
-			else
-				*val2 = 610500;
+			if (chan->channel == 0) {
+				*val = 1;
+				*val2 = 831500; /* 1.8315 mV */
+			} else {
+				*val = 0;
+				*val2 = 610500; /* 610.5 uV */
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = 0;
-			*val2 = 145300;
+			*val = 145;
+			*val2 = 300000; /* 0.1453 C */
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25;
+		*val = 250000 / 1453; /* 25 C = 0x00 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
-- 
1.7.10.4

