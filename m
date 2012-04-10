Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:36136 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422Ab2DJU1v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:27:51 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	michael.hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/10] staging:iio:accelerometer Add IIO_CHAN_INFO_VALUE entries to all drivers.
Date: Tue, 10 Apr 2012 21:27:35 +0100
Message-Id: <1334089663-22900-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089663-22900-1-git-send-email-jic23@kernel.org>
References: <1334089663-22900-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_core.c |   23 +++++++++++++++--------
 drivers/staging/iio/accel/adis16203_core.c |   15 ++++++++++-----
 drivers/staging/iio/accel/adis16204_core.c |   15 ++++++++++-----
 drivers/staging/iio/accel/adis16209_core.c |   22 +++++++++++++++-------
 drivers/staging/iio/accel/adis16220_core.c |   13 +++++++++----
 drivers/staging/iio/accel/adis16240_core.c |   16 +++++++++++-----
 drivers/staging/iio/accel/kxsd9.c          |    4 +++-
 drivers/staging/iio/accel/lis3l02dq_core.c |    3 ++-
 drivers/staging/iio/accel/sca3000_core.c   |    2 +-
 9 files changed, 76 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 88d3d96..d757986 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -411,7 +411,8 @@ static struct iio_chan_spec adis16201_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16201_SCAN_SUPPLY,
 		.scan_type = {
@@ -423,8 +424,9 @@ static struct iio_chan_spec adis16201_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		.address = temp,
 		.scan_index = ADIS16201_SCAN_TEMP,
 		.scan_type = {
@@ -436,7 +438,8 @@ static struct iio_chan_spec adis16201_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16201_SCAN_ACC_X,
@@ -449,7 +452,8 @@ static struct iio_chan_spec adis16201_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16201_SCAN_ACC_Y,
@@ -462,7 +466,8 @@ static struct iio_chan_spec adis16201_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_aux,
 		.scan_index = ADIS16201_SCAN_AUX_ADC,
 		.scan_type = {
@@ -474,7 +479,8 @@ static struct iio_chan_spec adis16201_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = incli_x,
 		.scan_index = ADIS16201_SCAN_INCLI_X,
@@ -487,7 +493,8 @@ static struct iio_chan_spec adis16201_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = incli_y,
 		.scan_index = ADIS16201_SCAN_INCLI_Y,
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index b50f04d..c3e469c 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -377,7 +377,8 @@ static struct iio_chan_spec adis16203_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16203_SCAN_SUPPLY,
 		.scan_type = {
@@ -389,7 +390,8 @@ static struct iio_chan_spec adis16203_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_aux,
 		.scan_index = ADIS16203_SCAN_AUX_ADC,
 		.scan_type = {
@@ -401,7 +403,8 @@ static struct iio_chan_spec adis16203_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = incli_x,
 		.scan_index = ADIS16203_SCAN_INCLI_X,
@@ -414,7 +417,8 @@ static struct iio_chan_spec adis16203_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = incli_y,
 		.scan_index = ADIS16203_SCAN_INCLI_Y,
 		.scan_type = {
@@ -426,7 +430,8 @@ static struct iio_chan_spec adis16203_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		.address = temp,
 		.scan_index = ADIS16203_SCAN_TEMP,
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index fdf31f1..b47c4dd 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -449,7 +449,8 @@ static struct iio_chan_spec adis16204_channels[] = {
 		.indexed = 1, /* Note was not previously indexed */
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16204_SCAN_SUPPLY,
 		.scan_type = {
@@ -461,7 +462,8 @@ static struct iio_chan_spec adis16204_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_aux,
 		.scan_index = ADIS16204_SCAN_AUX_ADC,
 		.scan_type = {
@@ -473,7 +475,8 @@ static struct iio_chan_spec adis16204_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		.address = temp,
 		.scan_index = ADIS16204_SCAN_TEMP,
@@ -486,7 +489,8 @@ static struct iio_chan_spec adis16204_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		.address = accel_x,
@@ -500,7 +504,8 @@ static struct iio_chan_spec adis16204_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
 		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		.address = accel_y,
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 02c003f..ca93770 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -413,7 +413,8 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16209_SCAN_SUPPLY,
 		.scan_type = {
@@ -425,7 +426,8 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 0,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		.info_mask =  IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		.address = temp,
 		.scan_index = ADIS16209_SCAN_TEMP,
@@ -438,7 +440,8 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16209_SCAN_ACC_X,
@@ -451,7 +454,8 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16209_SCAN_ACC_Y,
@@ -464,7 +468,8 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_aux,
 		.scan_index = ADIS16209_SCAN_AUX_ADC,
 		.scan_type = {
@@ -476,7 +481,8 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = incli_x,
 		.scan_index = ADIS16209_SCAN_INCLI_X,
 		.scan_type = {
@@ -488,7 +494,8 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = incli_y,
 		.scan_index = ADIS16209_SCAN_INCLI_Y,
 		.scan_type = {
@@ -500,6 +507,7 @@ static struct iio_chan_spec adis16209_channels[] = {
 		.type = IIO_ROT,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT,
 		.address = rot,
 		.scan_index = ADIS16209_SCAN_ROT,
 		.scan_type = {
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 51a852d..831d445 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -575,11 +575,13 @@ static const struct iio_chan_spec adis16220_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 	}, {
 		.type = IIO_ACCEL,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+			     IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
 			     IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		.address = accel,
@@ -587,20 +589,23 @@ static const struct iio_chan_spec adis16220_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+			     IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+			     IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_1,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 2,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT,
 		.address = in_2,
 	}
 };
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 43da947..6711b8e 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -473,7 +473,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16240_SCAN_SUPPLY,
 		.scan_type = {
@@ -485,6 +486,7 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT,
 		.address = in_aux,
 		.scan_index = ADIS16240_SCAN_AUX_ADC,
 		.scan_type = {
@@ -496,7 +498,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16240_SCAN_ACC_X,
@@ -509,7 +512,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16240_SCAN_ACC_Y,
@@ -522,7 +526,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16240_SCAN_ACC_Z,
@@ -535,7 +540,8 @@ static struct iio_chan_spec adis16240_channels[] = {
 		.type = IIO_ACCEL,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp,
 		.scan_index = ADIS16240_SCAN_TEMP,
 		.scan_type = {
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index d13d721..69be90b 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -181,7 +181,8 @@ error_ret:
 		.type = IIO_ACCEL,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT |		\
+			IIO_CHAN_INFO_SCALE_SHARED_BIT,			\
 		.address = KXSD9_REG_##axis,				\
 	}
 
@@ -189,6 +190,7 @@ static struct iio_chan_spec kxsd9_channels[] = {
 	KXSD9_ACCEL_CHAN(X), KXSD9_ACCEL_CHAN(Y), KXSD9_ACCEL_CHAN(Z),
 	{
 		.type = IIO_VOLTAGE,
+		.info_mask = IIO_CHAN_INFO_VALUE_SEPARATE_BIT,
 		.indexed = 1,
 		.address = KXSD9_REG_AUX,
 	}
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 0bb7c70..496a72a 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -513,7 +513,8 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 }
 
 #define LIS3L02DQ_INFO_MASK				\
-	(IIO_CHAN_INFO_SCALE_SHARED_BIT |		\
+	(IIO_CHAN_INFO_VALUE_SEPARATE_BIT |		\
+	 IIO_CHAN_INFO_SCALE_SHARED_BIT |		\
 	 IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |	\
 	 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT)
 
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index b4a2747..98ca96a 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -429,7 +429,7 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 
 #define SCA3000_INFO_MASK			\
-	IIO_CHAN_INFO_SCALE_SHARED_BIT
+	IIO_CHAN_INFO_VALUE_SEPARATE_BIT | IIO_CHAN_INFO_SCALE_SHARED_BIT
 #define SCA3000_EVENT_MASK					\
 	(IIO_EV_BIT(IIO_EV_TYPE_MAG, IIO_EV_DIR_RISING))
 
-- 
1.7.9.4

