Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35722 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3CBQRn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:43 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 44/67] staging:iio:accel:adis move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:01 +0000
Message-Id: <1362241044-3534-45-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16201_core.c |  8 +++----
 drivers/staging/iio/accel/adis16203_core.c |  2 +-
 drivers/staging/iio/accel/adis16204_core.c |  8 +++----
 drivers/staging/iio/accel/adis16209_core.c |  4 ++--
 drivers/staging/iio/accel/adis16240_core.c |  9 +++-----
 drivers/staging/iio/gyro/adis16260_core.c  |  4 ++--
 include/linux/iio/imu/adis.h               | 34 +++++++++++++++---------------
 7 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 9e5791f..ab8ec7a 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -134,14 +134,14 @@ static const struct iio_chan_spec adis16201_channels[] = {
 	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 12),
 	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
 	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
 	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
 	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 8c23527..b08ac8f 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -102,7 +102,7 @@ static const struct iio_chan_spec adis16203_channels[] = {
 	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 12),
 	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 12),
 	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
 	/* Fixme: Not what it appears to be - see data sheet */
 	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y, 0, 14),
 	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 12),
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index f359266..792ec25 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -140,13 +140,11 @@ static const struct iio_chan_spec adis16204_channels[] = {
 	ADIS_AUX_ADC_CHAN(ADIS16204_AUX_ADC, ADIS16204_SCAN_AUX_ADC, 12),
 	ADIS_TEMP_CHAN(ADIS16204_TEMP_OUT, ADIS16204_SCAN_TEMP, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16204_XACCL_OUT, ADIS16204_SCAN_ACC_X,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_PEAK_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 14),
 	ADIS_ACCEL_CHAN(Y, ADIS16204_YACCL_OUT, ADIS16204_SCAN_ACC_Y,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_PEAK_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 14),
 	ADIS_ACCEL_CHAN(ROOT_SUM_SQUARED_X_Y, ADIS16204_XY_RSS_OUT,
-		ADIS16204_SCAN_ACC_XY, IIO_CHAN_INFO_PEAK_SEPARATE_BIT, 14),
+		ADIS16204_SCAN_ACC_XY, BIT(IIO_CHAN_INFO_PEAK), 14),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 69c50ee..323c169 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -133,9 +133,9 @@ static const struct iio_chan_spec adis16209_channels[] = {
 	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 14),
 	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 12),
 	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT, ADIS16209_SCAN_ACC_X,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
 	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT, ADIS16209_SCAN_ACC_Y,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, 14),
+		BIT(IIO_CHAN_INFO_CALIBBIAS), 14),
 	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 12),
 	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X, 0, 14),
 	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y, 0, 14),
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index e97fa0b..fd1f0fd 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -176,14 +176,11 @@ static const struct iio_chan_spec adis16240_channels[] = {
 	ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 10),
 	ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 10),
 	ADIS_ACCEL_CHAN(X, ADIS16240_XACCL_OUT, ADIS16240_SCAN_ACC_X,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_PEAK_SEPARATE_BIT, 10),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 10),
 	ADIS_ACCEL_CHAN(Y, ADIS16240_YACCL_OUT, ADIS16240_SCAN_ACC_Y,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_PEAK_SEPARATE_BIT, 10),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 10),
 	ADIS_ACCEL_CHAN(Z, ADIS16240_ZACCL_OUT, ADIS16240_SCAN_ACC_Z,
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_PEAK_SEPARATE_BIT, 10),
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK), 10),
 	ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 10),
 	IIO_CHAN_SOFT_TIMESTAMP(6)
 };
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 6e80b8c..620d63f 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -124,8 +124,8 @@ static IIO_DEVICE_ATTR(sampling_frequency_available,
 #define ADIS16260_GYRO_CHANNEL_SET(axis, mod)				\
 struct iio_chan_spec adis16260_channels_##axis[] = {		\
 	ADIS_GYRO_CHAN(mod, ADIS16260_GYRO_OUT, ADIS16260_SCAN_GYRO, \
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT, 14), \
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | \
+		BIT(IIO_CHAN_INFO_CALIBSCALE), 14), \
 	ADIS_INCLI_CHAN(mod, ADIS16260_ANGL_OUT, ADIS16260_SCAN_ANGL, 0, 14), \
 	ADIS_TEMP_CHAN(ADIS16260_TEMP_OUT, ADIS16260_SCAN_TEMP, 12), \
 	ADIS_SUPPLY_CHAN(ADIS16260_SUPPLY_OUT, ADIS16260_SCAN_SUPPLY, 12), \
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index ff781dc..b665dc7 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -162,8 +162,8 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	.indexed = 1, \
 	.channel = (chan), \
 	.extend_name = name, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE), \
 	.address = (addr), \
 	.scan_index = (si), \
 	.scan_type = { \
@@ -184,9 +184,9 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	.type = IIO_TEMP, \
 	.indexed = 1, \
 	.channel = 0, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT | \
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OFFSET), \
 	.address = (addr), \
 	.scan_index = (si), \
 	.scan_type = { \
@@ -197,13 +197,13 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	}, \
 }
 
-#define ADIS_MOD_CHAN(_type, mod, addr, si, info, bits) { \
+#define ADIS_MOD_CHAN(_type, mod, addr, si, info_sep, bits) { \
 	.type = (_type), \
 	.modified = 1, \
 	.channel2 = IIO_MOD_ ## mod, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-		 info, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		 info_sep, \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.address = (addr), \
 	.scan_index = (si), \
 	.scan_type = { \
@@ -214,17 +214,17 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 	}, \
 }
 
-#define ADIS_ACCEL_CHAN(mod, addr, si, info, bits) \
-	ADIS_MOD_CHAN(IIO_ACCEL, mod, addr, si, info, bits)
+#define ADIS_ACCEL_CHAN(mod, addr, si, info_sep, bits) \
+	ADIS_MOD_CHAN(IIO_ACCEL, mod, addr, si, info_sep, bits)
 
-#define ADIS_GYRO_CHAN(mod, addr, si, info, bits) \
-	ADIS_MOD_CHAN(IIO_ANGL_VEL, mod, addr, si, info, bits)
+#define ADIS_GYRO_CHAN(mod, addr, si, info_sep, bits) \
+	ADIS_MOD_CHAN(IIO_ANGL_VEL, mod, addr, si, info_sep, bits)
 
-#define ADIS_INCLI_CHAN(mod, addr, si, info, bits) \
-	ADIS_MOD_CHAN(IIO_INCLI, mod, addr, si, info, bits)
+#define ADIS_INCLI_CHAN(mod, addr, si, info_sep, bits) \
+	ADIS_MOD_CHAN(IIO_INCLI, mod, addr, si, info_sep, bits)
 
-#define ADIS_ROT_CHAN(mod, addr, si, info, bits) \
-	ADIS_MOD_CHAN(IIO_ROT, mod, addr, si, info, bits)
+#define ADIS_ROT_CHAN(mod, addr, si, info_sep, bits) \
+	ADIS_MOD_CHAN(IIO_ROT, mod, addr, si, info_sep, bits)
 
 #ifdef CONFIG_IIO_ADIS_LIB_BUFFER
 
-- 
1.8.1.4

