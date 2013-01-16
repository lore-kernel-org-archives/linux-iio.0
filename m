Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1160 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446Ab3APMsT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:19 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/15] staging:iio:adis16400: Remove samplerate_available attribute
Date: Wed, 16 Jan 2013 13:48:45 +0100
Message-Id: <1358340531-31350-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

While the samplerate supported by the devices which are supported by this driver
is not continuous it supports a wide range, much more than currently listed in
the samplerate_available attribute. Also it accepts all values written to the
samplerate attribute and will round-up them to the nearest supported sample
rate. So remove the samplerate_available attribute.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 9429072..c08490b 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -247,8 +247,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 			      adis16400_read_frequency,
 			      adis16400_write_frequency);
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
-
 static const u8 adis16400_addresses[] = {
 	[ADIS16400_SCAN_GYRO_X] = ADIS16400_XGYRO_OFF,
 	[ADIS16400_SCAN_GYRO_Y] = ADIS16400_YGYRO_OFF,
@@ -574,7 +572,6 @@ static const struct iio_chan_spec adis16334_channels[] = {
 
 static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };
 
-- 
1.8.0

