Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1114 "EHLO
	smtp-out-175.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214Ab2J3K0f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Oct 2012 06:26:35 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] staging:iio:adis16400: Set the PROD_ID flag for the adis16334
Date: Tue, 30 Oct 2012 11:26:27 +0100
Message-Id: <1351592787-2934-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1351592787-2934-1-git-send-email-lars@metafoo.de>
References: <1351592787-2934-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adis16334 has the PROD_ID register so set the PROD_ID flag in its chip info.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index b49858e..abcdc61 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1125,6 +1125,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16334] = {
 		.channels = adis16334_channels,
 		.num_channels = ARRAY_SIZE(adis16334_channels),
+		.flags = ADIS16400_HAS_PROD_ID,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
 		.temp_scale_nano = 67850000, /* 0.06785 C */
-- 
1.8.0

