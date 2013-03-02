Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35724 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3CBQRp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:45 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 54/67] staging:iio:cdc:ad7746 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:11 +0000
Message-Id: <1362241044-3534-55-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Michael Hennerich <michael.hennerich@analog.com>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/cdc/ad7746.c | 48 ++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 466b82e..94f9ca7 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -123,8 +123,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_VIN,
 	},
@@ -133,8 +133,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_VDD_MON,
 	},
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_INT_TEMP,
 	},
@@ -150,7 +150,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_TEMP,
 	},
@@ -158,11 +158,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+		BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8,
 	},
 	[CIN1_DIFF] = {
@@ -171,11 +170,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.channel2 = 2,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+		BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF
 	},
@@ -183,11 +181,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+		BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CIN2,
 	},
@@ -197,11 +194,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 3,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+		BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
 	}
-- 
1.8.1.4

