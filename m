Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1095 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751464AbbHENif (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 09:38:35 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/9] iio: adis16400: adis16300 has product ID and serial number
Date: Wed,  5 Aug 2015 15:38:16 +0200
Message-Id: <1438781901-28000-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1438781901-28000-1-git-send-email-lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS16300 has the product ID and serial number registers, they are just
not documented. Set the appropriate flags so the driver makes use of them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index d42e4fe..7d612ab 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -696,7 +696,8 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16300] = {
 		.channels = adis16300_channels,
 		.num_channels = ARRAY_SIZE(adis16300_channels),
-		.flags = ADIS16400_HAS_SLOW_MODE,
+		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+				ADIS16400_HAS_SERIAL_NUMBER,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = 5884,
 		.temp_scale_nano = 140000000, /* 0.14 C */
-- 
2.1.4

