Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59136 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758967Ab3B0UkS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:18 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 35/67] iio:gyro:adxrs450 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:41 +0000
Message-Id: <1361997553-31058-36-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adxrs450.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index 5b79953..101a71b 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -383,16 +383,16 @@ static const struct iio_chan_spec adxrs450_channels[2][2] = {
 			.type = IIO_ANGL_VEL,
 			.modified = 1,
 			.channel2 = IIO_MOD_Z,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-			IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+			.info_mask_separate = IIO_CHAN_INFO_RAW |
+			IIO_CHAN_INFO_CALIBBIAS |
+			IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW |
+			IIO_CHAN_INFO_SCALE,
 		}, {
 			.type = IIO_TEMP,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+			.info_mask_separate = IIO_CHAN_INFO_RAW |
+			IIO_CHAN_INFO_SCALE,
 		}
 	},
 	[ID_ADXRS453] = {
@@ -400,15 +400,15 @@ static const struct iio_chan_spec adxrs450_channels[2][2] = {
 			.type = IIO_ANGL_VEL,
 			.modified = 1,
 			.channel2 = IIO_MOD_Z,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
-			IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT,
+			.info_mask_separate = IIO_CHAN_INFO_RAW |
+			IIO_CHAN_INFO_SCALE |
+			IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
 		}, {
 			.type = IIO_TEMP,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+			.info_mask_separate = IIO_CHAN_INFO_RAW |
+			IIO_CHAN_INFO_SCALE,
 		}
 	},
 };
-- 
1.8.1.1

