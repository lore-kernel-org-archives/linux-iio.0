Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41379 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396Ab2DJUV7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:21:59 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/14] staging:iio:accel:adis16201 unwind use of IIO_CHAN macro.
Date: Tue, 10 Apr 2012 21:21:37 +0100
Message-Id: <1334089310-22576-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-1-git-send-email-jic23@kernel.org>
References: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_core.c |  116 +++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index d439e45..88d3d96 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -406,39 +406,97 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16201_channels[] = {
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 in_supply, ADIS16201_SCAN_SUPPLY,
-		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
-		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
-		 temp, ADIS16201_SCAN_TEMP,
-		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "supply",
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = in_supply,
+		.scan_index = ADIS16201_SCAN_SUPPLY,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
+		.address = temp,
+		.scan_index = ADIS16201_SCAN_TEMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 accel_x, ADIS16201_SCAN_ACC_X,
-		 IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.address = accel_x,
+		.scan_index = ADIS16201_SCAN_ACC_X,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 accel_y, ADIS16201_SCAN_ACC_Y,
-		 IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 in_aux, ADIS16201_SCAN_AUX_ADC,
-		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.address = accel_y,
+		.scan_index = ADIS16201_SCAN_ACC_Y,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = in_aux,
+		.scan_index = ADIS16201_SCAN_AUX_ADC,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_INCLI,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 incli_x, ADIS16201_SCAN_INCLI_X,
-		 IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		.address = incli_x,
+		.scan_index = ADIS16201_SCAN_INCLI_X,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_INCLI,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
 		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 incli_y, ADIS16201_SCAN_INCLI_Y,
-		 IIO_ST('s', 14, 16, 0), 0),
+		.address = incli_y,
+		.scan_index = ADIS16201_SCAN_INCLI_Y,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-- 
1.7.9.4

