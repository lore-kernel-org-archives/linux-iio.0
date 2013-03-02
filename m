Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35724 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3CBQRn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:43 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 45/67] staging:iio:accel:adis16220 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:02 +0000
Message-Id: <1362241044-3534-46-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16220_core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 370b01a..0e72f79 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -344,37 +344,37 @@ static const struct iio_chan_spec adis16220_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
 		.address = in_supply,
 	}, {
 		.type = IIO_ACCEL,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
-			     IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_PEAK),
 		.address = accel,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE),
 		.address = temp,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE),
 		.address = in_1,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 2,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.address = in_2,
 	}
 };
-- 
1.8.1.4

