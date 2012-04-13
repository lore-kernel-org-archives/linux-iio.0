Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37393 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758351Ab2DMKEh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:04:37 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/13] staging:iio:cdc Add IIO_CHAN_INFO_RAW/PROCESSED entries to all drivers.
Date: Fri, 13 Apr 2012 11:04:29 +0100
Message-Id: <1334311471-23054-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-1-git-send-email-jic23@kernel.org>
References: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/cdc/ad7150.c |    8 +++++---
 drivers/staging/iio/cdc/ad7152.c |   14 +++++++++-----
 drivers/staging/iio/cdc/ad7746.c |   23 ++++++++++++++++-------
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index e4a08dc..116e6c2 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -104,7 +104,7 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		ret = i2c_smbus_read_word_data(chip->client,
 					ad7150_addresses[chan->channel][0]);
 		if (ret < 0)
@@ -429,7 +429,8 @@ static const struct iio_chan_spec ad7150_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT,
 		.event_mask =
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
@@ -441,7 +442,8 @@ static const struct iio_chan_spec ad7150_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT,
 		.event_mask =
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index fdb83c3..1067ce5 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -329,7 +329,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		/* First set whether in differential mode */
 
 		regval = chip->setup[chan->channel];
@@ -436,7 +436,8 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
@@ -445,14 +446,16 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.channel2 = 2,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
@@ -461,7 +464,8 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 3,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 40b8512..6c75605 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -123,7 +123,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_VIN,
 	},
@@ -132,7 +133,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_VDD_MON,
 	},
@@ -141,6 +143,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.processed_val = IIO_PROCESSED,
+		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_INT_TEMP,
 	},
@@ -149,6 +152,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.processed_val = IIO_PROCESSED,
+		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_TEMP,
 	},
@@ -156,7 +160,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
@@ -168,7 +173,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.channel2 = 2,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
@@ -179,7 +185,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
@@ -192,7 +199,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 3,
-		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
@@ -572,7 +580,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		ret = ad7746_select_channel(indio_dev, chan);
 		if (ret < 0)
 			goto out;
-- 
1.7.0.4

