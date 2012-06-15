Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-050.synserver.de ([212.40.185.50]:1112 "EHLO
	smtp-out-048.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751724Ab2FOIZU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 04:25:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:adis16400: Fix ADIS16300 temperature address
Date: Fri, 15 Jun 2012 10:28:44 +0200
Message-Id: <1339748926-4002-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1339748926-4002-1-git-send-email-lars@metafoo.de>
References: <1339748926-4002-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS16300 uses the same address for the temperature register as the
ADIS16350 and not the ADIS16400.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 1f6bd85..1c9931e 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -946,7 +946,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		.address = temp,
+		.address = temp0,
 		.scan_index = ADIS16400_SCAN_TEMP,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
-- 
1.7.10

