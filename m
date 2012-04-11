Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:59793 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759500Ab2DKRqm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 13:46:42 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V2] staging:iio:accel:adis16240 unwind use of IIO_CHAN macro.
Date: Wed, 11 Apr 2012 18:46:37 +0100
Message-Id: <1334166397-1813-1-git-send-email-jic23@kernel.org>
In-Reply-To: <4F856A25.9020101@metafoo.de>
References: <4F856A25.9020101@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---

Fixed as per Lars-Peter's review..


 drivers/staging/iio/accel/adis16240_core.c |  103 ++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 17f77fe..fb0b328 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -468,33 +468,82 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16240_channels[] = {
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 in_supply, ADIS16240_SCAN_SUPPLY,
-		 IIO_ST('u', 10, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 0,
-		 in_aux, ADIS16240_SCAN_AUX_ADC,
-		 IIO_ST('u', 10, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 accel_x, ADIS16240_SCAN_ACC_X,
-		 IIO_ST('s', 10, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 accel_y, ADIS16240_SCAN_ACC_Y,
-		 IIO_ST('s', 10, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 accel_z, ADIS16240_SCAN_ACC_Z,
-		 IIO_ST('s', 10, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 temp, ADIS16240_SCAN_TEMP,
-		 IIO_ST('u', 10, 16, 0), 0),
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "supply",
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = in_supply,
+		.scan_index = ADIS16240_SCAN_SUPPLY,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 10,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.address = in_aux,
+		.scan_index = ADIS16240_SCAN_AUX_ADC,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 10,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		.address = accel_x,
+		.scan_index = ADIS16240_SCAN_ACC_X,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 10,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		.address = accel_y,
+		.scan_index = ADIS16240_SCAN_ACC_Y,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 10,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		.address = accel_z,
+		.scan_index = ADIS16240_SCAN_ACC_Z,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 10,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = temp,
+		.scan_index = ADIS16240_SCAN_TEMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 10,
+			.storagebits = 16,
+		},
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(6)
 };
 
-- 
1.7.9.4

