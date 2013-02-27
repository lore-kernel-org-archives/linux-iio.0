Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758615Ab3B0UkS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:18 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 36/67] iio:gyro:itg3200_core move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:42 +0000
Message-Id: <1361997553-31058-37-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/iio/gyro/itg3200_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index df2e6aa..6b8071b 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -248,12 +248,6 @@ err_ret:
 	return ret;
 }
 
-#define ITG3200_TEMP_INFO_MASK	(IIO_CHAN_INFO_OFFSET_SHARED_BIT | \
-				 IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-				 IIO_CHAN_INFO_RAW_SEPARATE_BIT)
-#define ITG3200_GYRO_INFO_MASK	(IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-				 IIO_CHAN_INFO_RAW_SEPARATE_BIT)
-
 #define ITG3200_ST						\
 	{ .sign = 's', .realbits = 16, .storagebits = 16, .endianness = IIO_BE }
 
@@ -261,7 +255,8 @@ err_ret:
 	.type = IIO_ANGL_VEL, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## _mod, \
-	.info_mask = ITG3200_GYRO_INFO_MASK, \
+	.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE, \
+	.info_mask_separate = IIO_CHAN_INFO_RAW, \
 	.address = ITG3200_REG_GYRO_ ## _mod ## OUT_H, \
 	.scan_index = ITG3200_SCAN_GYRO_ ## _mod, \
 	.scan_type = ITG3200_ST, \
@@ -271,7 +266,9 @@ static const struct iio_chan_spec itg3200_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.channel2 = IIO_NO_MOD,
-		.info_mask = ITG3200_TEMP_INFO_MASK,
+		.info_mask_separate = IIO_CHAN_INFO_RAW,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE,
 		.address = ITG3200_REG_TEMP_OUT_H,
 		.scan_index = ITG3200_SCAN_TEMP,
 		.scan_type = ITG3200_ST,
-- 
1.8.1.1

