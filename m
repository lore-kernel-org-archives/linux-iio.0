Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:36137 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759420Ab2DJU1u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:27:50 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	michael.hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 08/10] staging:iio:magnetometer Add IIO_CHAN_INFO_VALUE entries to all drivers.
Date: Tue, 10 Apr 2012 21:27:41 +0100
Message-Id: <1334089663-22900-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089663-22900-1-git-send-email-jic23@kernel.org>
References: <1334089663-22900-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/ak8975.c  |    5 +++--
 drivers/staging/iio/magnetometer/hmc5843.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index d5ddac3..9a595f5 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -429,7 +429,7 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	struct ak8975_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_VALUE:
 		return ak8975_read_axis(indio_dev, chan->address, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = data->raw_to_gauss[chan->address];
@@ -443,7 +443,8 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |		\
+			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
 		.address = index,					\
 	}
 
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 91dd3da..6dc0ad6e 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -459,7 +459,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 	struct hmc5843_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_VALUE:
 		return hmc5843_read_measurement(indio_dev,
 						chan->address,
 						val);
@@ -476,7 +476,8 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |		\
+			     IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
 		.address = add						\
 	}
 
-- 
1.7.9.4

