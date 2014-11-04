Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-075.synserver.de ([212.40.185.75]:1053 "EHLO
	smtp-out-048.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751292AbaKDRDV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 12:03:21 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] staging:iio:ade7758: Remove "raw" from channel name
Date: Tue,  4 Nov 2014 18:03:16 +0100
Message-Id: <1415120596-21704-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1415120596-21704-1-git-send-email-lars@metafoo.de>
References: <1415120596-21704-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

"raw" is a property of a channel, but should not be part of the name of
channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7758_core.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 214b03e..94d9914 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -630,7 +630,6 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.extend_name = "raw",
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
 		.scan_index = 0,
 		.scan_type = {
@@ -642,7 +641,6 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_CURRENT,
 		.indexed = 1,
 		.channel = 0,
-		.extend_name = "raw",
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
 		.scan_index = 1,
 		.scan_type = {
@@ -654,7 +652,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 0,
-		.extend_name = "apparent_raw",
+		.extend_name = "apparent",
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
 		.scan_index = 2,
 		.scan_type = {
@@ -666,7 +664,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 0,
-		.extend_name = "active_raw",
+		.extend_name = "active",
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
 		.scan_index = 3,
 		.scan_type = {
@@ -678,7 +676,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 0,
-		.extend_name = "reactive_raw",
+		.extend_name = "reactive",
 		.address = AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
 		.scan_index = 4,
 		.scan_type = {
@@ -690,7 +688,6 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.extend_name = "raw",
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
 		.scan_index = 5,
 		.scan_type = {
@@ -702,7 +699,6 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_CURRENT,
 		.indexed = 1,
 		.channel = 1,
-		.extend_name = "raw",
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
 		.scan_index = 6,
 		.scan_type = {
@@ -714,7 +710,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 1,
-		.extend_name = "apparent_raw",
+		.extend_name = "apparent",
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
 		.scan_index = 7,
 		.scan_type = {
@@ -726,7 +722,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 1,
-		.extend_name = "active_raw",
+		.extend_name = "active",
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
 		.scan_index = 8,
 		.scan_type = {
@@ -738,7 +734,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 1,
-		.extend_name = "reactive_raw",
+		.extend_name = "reactive",
 		.address = AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
 		.scan_index = 9,
 		.scan_type = {
@@ -750,7 +746,6 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 2,
-		.extend_name = "raw",
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
 		.scan_index = 10,
 		.scan_type = {
@@ -762,7 +757,6 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_CURRENT,
 		.indexed = 1,
 		.channel = 2,
-		.extend_name = "raw",
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
 		.scan_index = 11,
 		.scan_type = {
@@ -774,7 +768,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 2,
-		.extend_name = "apparent_raw",
+		.extend_name = "apparent",
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
 		.scan_index = 12,
 		.scan_type = {
@@ -786,7 +780,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 2,
-		.extend_name = "active_raw",
+		.extend_name = "active",
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
 		.scan_index = 13,
 		.scan_type = {
@@ -798,7 +792,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
 		.type = IIO_POWER,
 		.indexed = 1,
 		.channel = 2,
-		.extend_name = "reactive_raw",
+		.extend_name = "reactive",
 		.address = AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
 		.scan_index = 14,
 		.scan_type = {
-- 
1.8.0

