Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37382 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758342Ab2DMKEg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:04:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 08/13] staging:iio:magnetometer Add IIO_CHAN_INFO_RAW entries to all drivers.
Date: Fri, 13 Apr 2012 11:04:26 +0100
Message-Id: <1334311471-23054-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-1-git-send-email-jic23@kernel.org>
References: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.
No processed values for magnetometers.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/ak8975.c  |    5 +++--
 drivers/staging/iio/magnetometer/hmc5843.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index d5ddac3..000886f 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -429,7 +429,7 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	struct ak8975_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		return ak8975_read_axis(indio_dev, chan->address, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = data->raw_to_gauss[chan->address];
@@ -443,7 +443,8 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
+			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
 		.address = index,					\
 	}
 
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 91dd3da..27c2629 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -459,7 +459,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 	struct hmc5843_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		return hmc5843_read_measurement(indio_dev,
 						chan->address,
 						val);
@@ -476,7 +476,8 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
 		.address = add						\
 	}
 
-- 
1.7.0.4

