Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46059 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/11] staging:iio: rename gyro channels to anglvel
Date: Fri, 30 Sep 2011 11:14:47 +0100
Message-Id: <1317377694-9001-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ensure naming reflects what is measured, not how it is done.
Resolvers can measure the same thing for starters.
IIO_GYRO->IIO_ANGL_VEL to ensure consistent naming.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16060_core.c |    2 +-
 drivers/staging/iio/gyro/adis16080_core.c |    2 +-
 drivers/staging/iio/gyro/adis16130_core.c |    2 +-
 drivers/staging/iio/gyro/adis16260_core.c |    8 ++++----
 drivers/staging/iio/gyro/adxrs450_core.c  |    4 ++--
 drivers/staging/iio/iio.h                 |    2 +-
 drivers/staging/iio/imu/adis16400_core.c  |   22 +++++++++++-----------
 drivers/staging/iio/industrialio-core.c   |    2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index f812991..abb6f05 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -117,7 +117,7 @@ static const struct iio_info adis16060_info = {
 
 static const struct iio_chan_spec adis16060_channels[] = {
 	{
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.address = ADIS16060_GYRO,
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index a2ee9be..07b013a 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -108,7 +108,7 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec adis16080_channels[] = {
 	{
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.address = ADIS16080_DIN_GYRO,
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index a9f270e..87670c0 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -97,7 +97,7 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec adis16130_channels[] = {
 	{
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.address = ADIS16130_RATEDATA,
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index efbee27..dc440d15 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -390,7 +390,7 @@ enum adis16260_channel {
 };
 #define ADIS16260_GYRO_CHANNEL_SET(axis, mod)				\
 	struct iio_chan_spec adis16260_channels_##axis[] = {		\
-		IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, mod,		\
+		IIO_CHAN(IIO_ANGL_VEL, 1, 0, 0, NULL, 0, mod,		\
 			 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |	\
 			 (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |	\
 			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
@@ -468,7 +468,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		switch (chan->type) {
-		case IIO_GYRO:
+		case IIO_ANGL_VEL:
 			*val = 0;
 			if (spi_get_device_id(st->us)->driver_data)
 				*val2 = 320;
@@ -495,7 +495,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
 		switch (chan->type) {
-		case IIO_GYRO:
+		case IIO_ANGL_VEL:
 			bits = 12;
 			break;
 		default:
@@ -515,7 +515,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
 		switch (chan->type) {
-		case IIO_GYRO:
+		case IIO_ANGL_VEL:
 			bits = 12;
 			break;
 		default:
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 670b615..1fda3db 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -268,7 +268,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case 0:
 		switch (chan->type) {
-		case IIO_GYRO:
+		case IIO_ANGL_VEL:
 			ret = adxrs450_spi_sensor_data(indio_dev, &t);
 			if (ret)
 				break;
@@ -305,7 +305,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec adxrs450_channels[] = {
 	{
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 3c39e1c..a6aec66 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -31,7 +31,7 @@ enum iio_chan_type {
 	IIO_CURRENT,
 	IIO_POWER,
 	IIO_ACCEL,
-	IIO_GYRO,
+	IIO_ANGL_VEL,
 	IIO_MAGN,
 	IIO_LIGHT,
 	IIO_INTENSITY,
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index fe9b6a5..4e31c79 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -565,7 +565,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 		switch (chan->type) {
-		case IIO_GYRO:
+		case IIO_ANGL_VEL:
 			*val = 0;
 			*val2 = st->variant->gyro_scale_micro;
 			return IIO_VAL_INT_PLUS_MICRO;
@@ -641,7 +641,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 14, 16, 0)
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -651,7 +651,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0)
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -661,7 +661,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -759,7 +759,7 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 12, 16, 0)
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -769,7 +769,7 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0)
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -779,7 +779,7 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -873,7 +873,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 12, 16, 0)
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -951,7 +951,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 
 static const struct iio_chan_spec adis16334_channels[] = {
 	{
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -961,7 +961,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
@@ -971,7 +971,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
-		.type = IIO_GYRO,
+		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index d2af50a..f776099 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -54,7 +54,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CURRENT] = "current",
 	[IIO_POWER] = "power",
 	[IIO_ACCEL] = "accel",
-	[IIO_GYRO] = "gyro",
+	[IIO_ANGL_VEL] = "anglvel",
 	[IIO_MAGN] = "magn",
 	[IIO_LIGHT] = "illuminance",
 	[IIO_INTENSITY] = "intensity",
-- 
1.7.3.4

