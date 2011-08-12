Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:58493 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1HLQ4e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:56:34 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:imu:adis16344 support
Date: Fri, 12 Aug 2011 18:04:37 +0100
Message-Id: <1313168677-18803-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313168677-18803-1-git-send-email-jic23@cam.ac.uk>
References: <1313168677-18803-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Simple device. Note the sparse scan mask used.

Done from datasheet as very similar to existing parts.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/imu/adis16400_core.c |   44 ++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 8b8e8a3..371eb01 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -35,6 +35,7 @@
 
 enum adis16400_chip_variant {
 	ADIS16300,
+	ADIS16344,
 	ADIS16350,
 	ADIS16360,
 	ADIS16362,
@@ -689,6 +690,38 @@ static struct iio_chan_spec adis16300_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14)
 };
 
+static const struct iio_chan_spec adis16344_channels[] = {
+	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Z,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 temp0, ADIS16350_SCAN_TEMP_X, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(12)
+};
+
 static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
@@ -713,6 +746,16 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		(1 << ADIS16300_SCAN_INCLI_X) | (1 << ADIS16300_SCAN_INCLI_Y) |
 		(1 << 14),
 	},
+	[ADIS16344] = {
+		.channels = adis16344_channels,
+		.num_channels = ARRAY_SIZE(adis16344_channels),
+		.gyro_scale_micro = 873,
+		.accel_scale_micro = 981,
+		.default_scan_mask = (1 << ADIS16400_SCAN_GYRO_X) |
+		(1 << ADIS16400_SCAN_GYRO_Y) | (1 << ADIS16400_SCAN_GYRO_Z) |
+		(1 << ADIS16400_SCAN_ACC_X) | (1 << ADIS16400_SCAN_ACC_Y) |
+		(1 << ADIS16400_SCAN_ACC_Z),
+	},
 	[ADIS16350] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
@@ -868,6 +911,7 @@ err_ret:
 
 static const struct spi_device_id adis16400_id[] = {
 	{"adis16300", ADIS16300},
+	{"adis16344", ADIS16344},
 	{"adis16350", ADIS16350},
 	{"adis16354", ADIS16350},
 	{"adis16355", ADIS16350},
-- 
1.7.3.4

