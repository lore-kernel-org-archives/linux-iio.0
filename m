Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51250 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1IWLx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2011 07:53:26 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/16] staging:iio:adc:ad799x address and scan_index always match so stop using address
Date: Fri, 23 Sep 2011 13:01:35 +0100
Message-Id: <1316779302-12357-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Saves on setting the value of address for the simple situation seen in this
device. They are already used interchangably to get data from the buffer.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x_core.c |   40 +--------------------------------
 1 files changed, 1 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 879b9d8..982c42c 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -154,7 +154,7 @@ static int ad799x_read_raw(struct iio_dev *dev_info,
 			ret = ad799x_single_channel_from_ring(dev_info,
 							      chan->scan_index);
 		else
-			ret = ad799x_scan_direct(st, chan->address);
+			ret = ad799x_scan_direct(st, chan->scan_index);
 		mutex_unlock(&dev_info->mlock);
 
 		if (ret < 0)
@@ -455,7 +455,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
@@ -463,7 +462,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
@@ -471,7 +469,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 2,
-				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
@@ -479,7 +476,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 3,
-				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
@@ -495,7 +491,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -503,7 +498,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -511,7 +505,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 2,
-				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -519,7 +512,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 3,
-				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -535,7 +527,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 8, 16, 4),
 			},
@@ -543,7 +534,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 8, 16, 4),
 			},
@@ -551,7 +541,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 2,
-				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 8, 16, 4),
 			},
@@ -559,7 +548,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 3,
-				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 8, 16, 4),
 			},
@@ -575,7 +563,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -584,7 +571,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -602,7 +588,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -611,7 +596,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -620,7 +604,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 2,
-				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -629,7 +612,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 3,
-				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -647,7 +629,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -656,7 +637,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -665,7 +645,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 2,
-				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -674,7 +653,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 3,
-				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -692,7 +670,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -701,7 +678,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -710,7 +686,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 2,
-				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -719,7 +694,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 3,
-				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 				.event_mask = AD799X_EV_MASK,
@@ -728,7 +702,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 4,
-				.address = 4,
 				.scan_index = 4,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -736,7 +709,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 5,
-				.address = 5,
 				.scan_index = 5,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -744,7 +716,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 6,
-				.address = 6,
 				.scan_index = 6,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -752,7 +723,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 7,
-				.address = 7,
 				.scan_index = 7,
 				.scan_type = IIO_ST('u', 10, 16, 2),
 			},
@@ -769,7 +739,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 0,
-				.address = 0,
 				.scan_index = 0,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -778,7 +747,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 1,
-				.address = 1,
 				.scan_index = 1,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -787,7 +755,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 2,
-				.address = 2,
 				.scan_index = 2,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -796,7 +763,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 3,
-				.address = 3,
 				.scan_index = 3,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 				.event_mask = AD799X_EV_MASK,
@@ -805,7 +771,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 4,
-				.address = 4,
 				.scan_index = 4,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
@@ -813,7 +778,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 5,
-				.address = 5,
 				.scan_index = 5,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
@@ -821,7 +785,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 6,
-				.address = 6,
 				.scan_index = 6,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
@@ -829,7 +792,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				.type = IIO_VOLTAGE,
 				.indexed = 1,
 				.channel = 7,
-				.address = 7,
 				.scan_index = 7,
 				.scan_type = IIO_ST('u', 12, 16, 0),
 			},
-- 
1.7.3.4

