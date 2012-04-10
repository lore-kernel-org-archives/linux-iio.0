Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41400 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759406Ab2DJUWA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:22:00 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/14] staging:iio:gyro:adis16260 unwind use of IIO_CHAN macro.
Date: Tue, 10 Apr 2012 21:21:47 +0100
Message-Id: <1334089310-22576-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-1-git-send-email-jic23@kernel.org>
References: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/gyro/adis16260_core.c |   89 +++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 8f6af47..92f024e 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -389,30 +389,71 @@ enum adis16260_channel {
 };
 #define ADIS16260_GYRO_CHANNEL_SET(axis, mod)				\
 	struct iio_chan_spec adis16260_channels_##axis[] = {		\
-		IIO_CHAN(IIO_ANGL_VEL, 1, 0, 0, NULL, 0, mod,		\
-			 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |	\
-			 IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |	\
-			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
-			 gyro, ADIS16260_SCAN_GYRO,			\
-			 IIO_ST('s', 14, 16, 0), 0),			\
-		IIO_CHAN(IIO_ANGL, 1, 0, 0, NULL, 0, mod,		\
-			 0,						\
-			 angle, ADIS16260_SCAN_ANGL,			\
-			 IIO_ST('u', 14, 16, 0), 0),			\
-		IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,			\
-			 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |		\
-			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
-			 temp, ADIS16260_SCAN_TEMP,			\
-			 IIO_ST('u', 12, 16, 0), 0),			\
-		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,		\
-			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
-			 in_supply, ADIS16260_SCAN_SUPPLY,		\
-			 IIO_ST('u', 12, 16, 0), 0),			\
-		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,		\
-			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
-			 in_aux, ADIS16260_SCAN_AUX_ADC,		\
-			 IIO_ST('u', 12, 16, 0), 0),			\
-		IIO_CHAN_SOFT_TIMESTAMP(5)				\
+		{							\
+			.type = IIO_ANGL_VEL,				\
+			.modified = 1,					\
+			.channel2 = mod,				\
+			.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT | \
+			IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |		\
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
+			.address = gyro,				\
+			.scan_index = ADIS16260_SCAN_GYRO,		\
+			.scan_type = {					\
+				.sign = 's',				\
+				.realbits = 14,				\
+				.storagebits = 16,			\
+			},						\
+		}, {							\
+			.type = IIO_ANGL,				\
+			.modified = 1,					\
+			.channel2 = mod,				\
+			.address = angle,				\
+			.scan_index = ADIS16260_SCAN_ANGL,		\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = 14,				\
+				.storagebits = 16,			\
+			},						\
+		}, {							\
+			.type = IIO_TEMP,				\
+			.indexed = 1,					\
+			.channel = 0,					\
+			.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
+			.address = temp,				\
+			.scan_index = ADIS16260_SCAN_TEMP,		\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = 12,				\
+				.storagebits = 16,			\
+			},						\
+		}, {							\
+			.type = IIO_VOLTAGE,				\
+			.indexed = 1,					\
+			.channel = 0,					\
+			.extend_name = "supply",			\
+			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
+			.address = in_supply,				\
+			.scan_index = ADIS16260_SCAN_SUPPLY,		\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = 12,				\
+				.storagebits = 16,			\
+			},						\
+		}, {							\
+			.type = IIO_VOLTAGE,				\
+			.indexed = 1,					\
+			.channel = 1,					\
+			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
+			.address = in_aux,				\
+			.scan_index = ADIS16260_SCAN_AUX_ADC,		\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = 12,				\
+				.storagebits = 16,			\
+			},						\
+		},							\
+		IIO_CHAN_SOFT_TIMESTAMP(5),				\
 	}
 
 static const ADIS16260_GYRO_CHANNEL_SET(x, IIO_MOD_X);
-- 
1.7.9.4

