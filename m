Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35735 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab3CBQRs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:48 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 63/67] staging:iio:meter:ade7758 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:20 +0000
Message-Id: <1362241044-3534-64-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7758_core.c | 60 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 53c68dc..8f5bcfa 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -649,8 +649,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
 		.scan_index = 0,
 		.scan_type = {
@@ -663,8 +663,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
 		.scan_index = 1,
 		.scan_type = {
@@ -677,8 +677,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "apparent_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
 		.scan_index = 2,
 		.scan_type = {
@@ -691,8 +691,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "active_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
 		.scan_index = 3,
 		.scan_type = {
@@ -705,8 +705,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "reactive_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
 		.scan_index = 4,
 		.scan_type = {
@@ -719,8 +719,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
 		.scan_index = 5,
 		.scan_type = {
@@ -733,8 +733,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
 		.scan_index = 6,
 		.scan_type = {
@@ -747,8 +747,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "apparent_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
 		.scan_index = 7,
 		.scan_type = {
@@ -761,8 +761,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "active_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
 		.scan_index = 8,
 		.scan_type = {
@@ -775,8 +775,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "reactive_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
 		.scan_index = 9,
 		.scan_type = {
@@ -789,8 +789,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
 		.scan_index = 10,
 		.scan_type = {
@@ -803,8 +803,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
 		.scan_index = 11,
 		.scan_type = {
@@ -817,8 +817,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "apparent_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
 		.scan_index = 12,
 		.scan_type = {
@@ -831,8 +831,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "active_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
 		.scan_index = 13,
 		.scan_type = {
@@ -845,8 +845,8 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "reactive_raw",
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
 		.scan_index = 14,
 		.scan_type = {
-- 
1.8.1.4

