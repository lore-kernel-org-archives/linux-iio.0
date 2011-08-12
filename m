Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37750 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1HLQkA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:40:00 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/12] staging:iio:gyro:adxrs450 squish some trivial single call point wrappers functions.
Date: Fri, 12 Aug 2011 17:47:56 +0100
Message-Id: <1313167683-11881-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
References: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |   57 ++++++-----------------------
 1 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 967a772..f65ad49 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -20,7 +20,6 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../adc/adc.h"
 
 #include "adxrs450.h"
 
@@ -173,41 +172,6 @@ error_ret:
 	return ret;
 }
 
-static int adxrs450_read_temp(struct iio_dev *indio_dev, int *val)
-{
-	int ret;
-	u16 t;
-	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_TEMP1, &t);
-	if (ret)
-		return ret;
-	*val = t;
-	return 0;
-}
-
-static int adxrs450_read_quad(struct iio_dev *indio_dev, int *val)
-{
-	int ret;
-	s16 t;
-	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
-	if (ret)
-		return ret;
-	*val = t;
-	return 0;
-}
-
-static int adxrs450_read_sensor_data(struct iio_dev *indio_dev, int *val)
-{
-	int ret;
-	s16 t;
-
-	ret = adxrs450_spi_sensor_data(indio_dev, &t);
-	if (ret)
-		return ret;
-
-	*val = t;
-	return 0;
-}
-
 /* Recommended Startup Sequence by spec */
 static int adxrs450_initial_setup(struct iio_dev *indio_dev)
 {
@@ -298,21 +262,24 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 			     long mask)
 {
 	int ret;
+	s16 t;
+	u16 ut;
 	switch (mask) {
 	case 0:
 		switch (chan->type) {
 		case IIO_GYRO:
-			ret = adxrs450_read_sensor_data(indio_dev, val);
-			if (ret < 0)
+			ret = adxrs450_spi_sensor_data(indio_dev, &t);
+			if (ret)
 				break;
-			*val = ret;
+			*val = t;
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_TEMP:
-			ret = adxrs450_read_temp(indio_dev, val);
-			if (ret < 0)
+			ret = adxrs450_spi_read_reg_16(indio_dev,
+						       ADXRS450_TEMP1, &ut);
+			if (ret)
 				break;
-			*val = ret;
+			*val = ut;
 			ret = IIO_VAL_INT;
 			break;
 		default:
@@ -321,10 +288,10 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case (1 << IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE):
-		ret = adxrs450_read_quad(indio_dev, val);
-		if (ret < 0)
+		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
+		if (ret)
 			break;
-		*val = ret;
+		*val = t;
 		ret = IIO_VAL_INT;
 		break;
 	default:
-- 
1.7.3.4

