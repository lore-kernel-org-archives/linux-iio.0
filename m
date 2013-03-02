Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35724 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab3CBQRk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:40 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 34/67] iio:gyro:adis16136 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:51 +0000
Message-Id: <1362241044-3534-35-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adis16136.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 8cb0bcb..058e6d5 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -357,10 +357,11 @@ static const struct iio_chan_spec adis16136_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT |
-			IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+
 		.address = ADIS16136_REG_GYRO_OUT2,
 		.scan_index = ADIS16136_SCAN_GYRO,
 		.scan_type = {
@@ -373,8 +374,8 @@ static const struct iio_chan_spec adis16136_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
 		.address = ADIS16136_REG_TEMP_OUT,
 		.scan_index = ADIS16136_SCAN_TEMP,
 		.scan_type = {
-- 
1.8.1.4

