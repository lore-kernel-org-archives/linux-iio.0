Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-050.synserver.de ([212.40.185.50]:1114 "EHLO
	smtp-out-048.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751724Ab2FOIZX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 04:25:23 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] staging:iio:adis16400: Fix ADIS16334 temperature address
Date: Fri, 15 Jun 2012 10:28:45 +0200
Message-Id: <1339748926-4002-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1339748926-4002-1-git-send-email-lars@metafoo.de>
References: <1339748926-4002-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The channel spec for ADUS16334's temperature channel uses the address and scan
index for the Z-axis acceleration channel. This patch fixes it to use the
temperature channel address and scan index instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 1c9931e..7aa3a9a 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1054,8 +1054,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		.address = accel_z,
-		.scan_index = ADIS16400_SCAN_ACC_Z,
+		.address = temp0,
+		.scan_index = ADIS16400_SCAN_TEMP,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(12)
-- 
1.7.10

