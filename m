Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:36125 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759389Ab2DJU1u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:27:50 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	michael.hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/10] staging:iio:light Add IIO_CHAN_INFO_VALUE entries to all drivers.
Date: Tue, 10 Apr 2012 21:27:40 +0100
Message-Id: <1334089663-22900-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089663-22900-1-git-send-email-jic23@kernel.org>
References: <1334089663-22900-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/isl29018.c |    7 +++++--
 drivers/staging/iio/light/tsl2563.c  |    9 ++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 38ec52b..f134d58 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -383,7 +383,7 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->lock);
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_VALUE:
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = isl29018_read_lux(client, val);
@@ -420,14 +420,17 @@ static const struct iio_chan_spec isl29018_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.processed_val = IIO_PROCESSED,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT,
 		.channel2 = IIO_MOD_LIGHT_IR,
 	}, {
 		/* Unindexed in current ABI.  But perhaps it should be. */
 		.type = IIO_PROXIMITY,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT,
 	}
 };
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index beb51d71..859e211 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -485,7 +485,7 @@ static int tsl2563_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->lock);
 	switch (m) {
-	case 0:
+	case IIO_CHAN_INFO_VALUE:
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = tsl2563_get_adc(chip);
@@ -535,12 +535,14 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.type = IIO_LIGHT,
 		.indexed = 1,
 		.processed_val = 1,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT,
 		.channel = 0,
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
 					  IIO_EV_DIR_RISING) |
 			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
@@ -549,7 +551,8 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_IR,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 	}
 };
 
-- 
1.7.9.4

