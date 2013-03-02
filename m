Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35722 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab3CBQRr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:47 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jon Brenner <jon.brenner@ams.com>
Subject: [PATCH 60/67] staging:iio:light:tsl2x7x move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:17 +0000
Message-Id: <1362241044-3534-61-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Jon Brenner <jon.brenner@ams.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index a58731e..d060f25 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1733,14 +1733,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_mask = TSL2X7X_EVENT_MASK
 			}, {
 			.type = IIO_INTENSITY,
@@ -1757,7 +1757,7 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_PROXIMITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_mask = TSL2X7X_EVENT_MASK
 			},
 		},
@@ -1770,25 +1770,25 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_mask = TSL2X7X_EVENT_MASK
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 1,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			}, {
 			.type = IIO_PROXIMITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_mask = TSL2X7X_EVENT_MASK
 			},
 		},
@@ -1801,8 +1801,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_PROXIMITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE),
 			.event_mask = TSL2X7X_EVENT_MASK
 			},
 		},
@@ -1815,26 +1815,26 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_mask = TSL2X7X_EVENT_MASK
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 1,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			}, {
 			.type = IIO_PROXIMITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE),
 			.event_mask = TSL2X7X_EVENT_MASK
 			},
 		},
-- 
1.8.1.4

