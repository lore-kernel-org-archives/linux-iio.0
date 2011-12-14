Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:29435 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab1LNKtq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2011 05:49:46 -0500
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: gyro: ADXRS450: Add missing scale attributes
Date: Wed, 14 Dec 2011 11:49:34 +0100
Message-ID: <1323859774-7031-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Add missing scale attributes.
Temperature data is presented as 10-bit, twos complement number.
Therefore use singed and shift accordingly.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index e832aea..9d33628 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -263,7 +263,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	s16 t;
-	u16 ut;
+
 	switch (mask) {
 	case 0:
 		switch (chan->type) {
@@ -276,10 +276,10 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_TEMP:
 			ret = adxrs450_spi_read_reg_16(indio_dev,
-						       ADXRS450_TEMP1, &ut);
+						       ADXRS450_TEMP1, &t);
 			if (ret)
 				break;
-			*val = ut;
+			*val = (t >> 6) + 225;
 			ret = IIO_VAL_INT;
 			break;
 		default:
@@ -287,6 +287,20 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = 0;
+			*val2 = 218166;
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			*val = 200;
+			*val2 = 0;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		break;
 	case IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW:
 		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
 		if (ret)
@@ -308,11 +322,13 @@ static const struct iio_chan_spec adxrs450_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT,
+		IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}
 };
 
-- 
1.7.0.4


