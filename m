Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-152.synserver.de ([212.40.185.152]:1115 "EHLO
	smtp-out-147.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752727Ab2DMOta (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 10:49:30 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] staging:iio:meter Add IIO_CHAN_INFO_RAW entries to all drivers.
Date: Fri, 13 Apr 2012 16:51:09 +0200
Message-Id: <1334328669-31201-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1334328669-31201-1-git-send-email-lars@metafoo.de>
References: <1334328669-31201-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.
No processed values in resolvers at the moment.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7758_core.c |   45 ++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 4d6bffa..729c033 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -667,7 +667,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
 		.scan_index = 0,
 		.scan_type = {
@@ -680,7 +681,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
 		.scan_index = 1,
 		.scan_type = {
@@ -693,7 +695,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "apparent_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
 		.scan_index = 2,
 		.scan_type = {
@@ -706,7 +709,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "active_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
 		.scan_index = 3,
 		.scan_type = {
@@ -719,7 +723,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "reactive_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
 		.scan_index = 4,
 		.scan_type = {
@@ -732,7 +737,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
 		.scan_index = 5,
 		.scan_type = {
@@ -745,7 +751,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
 		.scan_index = 6,
 		.scan_type = {
@@ -758,7 +765,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "apparent_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
 		.scan_index = 7,
 		.scan_type = {
@@ -771,7 +779,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "active_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
 		.scan_index = 8,
 		.scan_type = {
@@ -784,7 +793,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "reactive_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
 		.scan_index = 9,
 		.scan_type = {
@@ -797,7 +807,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
 		.scan_index = 10,
 		.scan_type = {
@@ -810,7 +821,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
 		.scan_index = 11,
 		.scan_type = {
@@ -823,7 +835,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "apparent_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
 		.scan_index = 12,
 		.scan_type = {
@@ -836,7 +849,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "active_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
 		.scan_index = 13,
 		.scan_type = {
@@ -849,7 +863,8 @@ static struct iio_chan_spec ade7758_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "reactive_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
 		.scan_index = 14,
 		.scan_type = {
-- 
1.7.9.5

