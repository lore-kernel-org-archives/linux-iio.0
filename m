Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37376 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758339Ab2DMKEg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:04:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/13] staging:iio:light Add IIO_CHAN_INFO_RAW/PROCESSED entries to all drivers.
Date: Fri, 13 Apr 2012 11:04:25 +0100
Message-Id: <1334311471-23054-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-1-git-send-email-jic23@kernel.org>
References: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.
Note that minimal change route taken here. The read_raw callbacks
in both drivers could do fewer checks to identify the channel than
they now do.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/isl29018.c |    8 ++++++--
 drivers/staging/iio/light/tsl2563.c  |   10 +++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 38ec52b..350f12c 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -383,7 +383,8 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->lock);
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = isl29018_read_lux(client, val);
@@ -420,14 +421,17 @@ static const struct iio_chan_spec isl29018_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.processed_val = IIO_PROCESSED,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 		.channel2 = IIO_MOD_LIGHT_IR,
 	}, {
 		/* Unindexed in current ABI.  But perhaps it should be. */
 		.type = IIO_PROXIMITY,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 	}
 };
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index beb51d7..a334a88 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -485,7 +485,8 @@ static int tsl2563_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->lock);
 	switch (m) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = tsl2563_get_adc(chip);
@@ -535,12 +536,14 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.type = IIO_LIGHT,
 		.indexed = 1,
 		.processed_val = 1,
+		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.channel = 0,
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
 					  IIO_EV_DIR_RISING) |
 			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
@@ -549,7 +552,8 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_IR,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 	}
 };
 
-- 
1.7.0.4

