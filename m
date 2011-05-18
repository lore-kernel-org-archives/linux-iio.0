Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53977 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203Ab1ERNkF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:05 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 040/111] staging:iio:imu:adis16400 add support for adis16300
Date: Wed, 18 May 2011 14:41:30 +0100
Message-Id: <1305726161-5606-41-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Next patch will remove original driver.
Note this leaves holes in the scan indexing.

Untested - except via adis16350...

V3: rebase fixup.
V2: move to single IIO_CHAN macro.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/Kconfig          |    8 ++--
 drivers/staging/iio/imu/adis16400.h      |    2 +
 drivers/staging/iio/imu/adis16400_core.c |   50 ++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index d8f568f..082614d 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -18,7 +18,7 @@ config ADIS16400
 	select IIO_SW_RING if IIO_RING_BUFFER
 	select IIO_TRIGGER if IIO_RING_BUFFER
 	help
-	  Say yes here to build support for Analog Devices adis16350, adis16354,
-	  adis16355, adis16360, adis16362, adis16364, adis16365, adis16400 and
-	  adis16405 triaxial inertial sensors (adis16400 series also have
-	  magnetometers).
+	  Say yes here to build support for Analog Devices adis16300, adis16350,
+	  adis16354, adis16355, adis16360, adis16362, adis16364, adis16365,
+	  adis16400 and adis16405 triaxial inertial sensors (adis16400 series
+	  also have magnetometers).
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index ec3449b..9804c41 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -180,6 +180,8 @@ int adis16400_set_irq(struct iio_dev *indio_dev, bool enable);
 #define ADIS16400_SCAN_TEMP	10
 #define ADIS16350_SCAN_ADC_0	10
 #define ADIS16400_SCAN_ADC_0	11
+#define ADIS16300_SCAN_INCLI_X	12
+#define ADIS16300_SCAN_INCLI_Y	13
 
 void adis16400_remove_trigger(struct iio_dev *indio_dev);
 int adis16400_probe_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index fad7744..ddcae43 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -39,6 +39,7 @@
 #define DRIVER_NAME		"adis16400"
 
 enum adis16400_chip_variant {
+	ADIS16300,
 	ADIS16350,
 	ADIS16360,
 	ADIS16362,
@@ -663,6 +664,42 @@ static struct iio_chan_spec adis16350_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(11)
 };
 
+static struct iio_chan_spec adis16300_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 1, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 4, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16400_SCAN_TEMP, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, ADIS16300_SCAN_INCLI_X, IIO_ST('s', 13, 16, 0), 0),
+	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, ADIS16300_SCAN_INCLI_Y, IIO_ST('s', 13, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(14)
+};
+
 static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
@@ -676,6 +713,18 @@ static const struct attribute_group adis16400_attribute_group = {
 };
 
 static struct adis16400_chip_info adis16400_chips[] = {
+	[ADIS16300] = {
+		.channels = adis16300_channels,
+		.num_channels = ARRAY_SIZE(adis16300_channels),
+		.gyro_scale_micro = 873,
+		.accel_scale_micro = 5884,
+		.default_scan_mask = (1 << ADIS16400_SCAN_SUPPLY) |
+		(1 << ADIS16400_SCAN_GYRO_X) | (1 << ADIS16400_SCAN_ACC_X) |
+		(1 << ADIS16400_SCAN_ACC_Y) | (1 << ADIS16400_SCAN_ACC_Z) |
+		(1 << ADIS16400_SCAN_TEMP) | (1 << ADIS16400_SCAN_ADC_0) |
+		(1 << ADIS16300_SCAN_INCLI_X) | (1 << ADIS16300_SCAN_INCLI_Y) |
+		(1 << 14),
+	},
 	[ADIS16350] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
@@ -852,6 +901,7 @@ err_ret:
 }
 
 static const struct spi_device_id adis16400_id[] = {
+	{"adis16300", ADIS16300},
 	{"adis16350", ADIS16350},
 	{"adis16354", ADIS16350},
 	{"adis16355", ADIS16350},
-- 
1.7.3.4

