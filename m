Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-050.synserver.de ([212.40.185.50]:1029 "EHLO
	smtp-out-048.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751627Ab2FOIZS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 04:25:18 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio:adis16400: Fix ADIS16300 ROLL_OUT register address
Date: Fri, 15 Jun 2012 10:28:43 +0200
Message-Id: <1339748926-4002-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In the current driver ROLL_OUT register address is the same as the PITCH_OUT
register address. This patch fixes it to use the correct address.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 83d133e..1f4e987 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -42,7 +42,7 @@
 #define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
 
 #define ADIS16300_PITCH_OUT 0x12 /* X axis inclinometer output measurement */
-#define ADIS16300_ROLL_OUT  0x12 /* Y axis inclinometer output measurement */
+#define ADIS16300_ROLL_OUT  0x14 /* Y axis inclinometer output measurement */
 
 /* Calibration parameters */
 #define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
-- 
1.7.10

