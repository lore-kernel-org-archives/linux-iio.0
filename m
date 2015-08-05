Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1078 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751255AbbHENic (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 09:38:32 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/9] iio: adis16400: Fix adis16448 gyroscope scale
Date: Wed,  5 Aug 2015 15:38:13 +0200
Message-Id: <1438781901-28000-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1438781901-28000-1-git-send-email-lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the correct scale for the adis16448 gyroscope output.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 2fd68f22..d42e4fe 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -780,7 +780,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.flags = ADIS16400_HAS_PROD_ID |
 				ADIS16400_HAS_SERIAL_NUMBER |
 				ADIS16400_BURST_DIAG_STAT,
-		.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
+		.gyro_scale_micro = IIO_DEGREE_TO_RAD(40000), /* 0.04 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
 		.temp_scale_nano = 73860000, /* 0.07386 C */
 		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
-- 
2.1.4

