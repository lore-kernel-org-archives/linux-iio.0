Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60163 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934357Ab2DMJnG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:43:06 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/14] staging:iio:accel:adis16203 unwind use of IIO_CHAN macro.
Date: Fri, 13 Apr 2012 10:42:48 +0100
Message-Id: <1334310180-22170-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1334310180-22170-1-git-send-email-jic23@kernel.org>
References: <1334310180-22170-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16203_core.c |   87 ++++++++++++++++++++-------
 1 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 1a5140f..b50f04d 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -372,29 +372,70 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16203_channels[] = {
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 in_supply, ADIS16203_SCAN_SUPPLY,
-		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 in_aux, ADIS16203_SCAN_AUX_ADC,
-		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
-		 incli_x, ADIS16203_SCAN_INCLI_X,
-		 IIO_ST('s', 14, 16, 0), 0),
-	/* Fixme: Not what it appears to be - see data sheet */
-	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
-		 incli_y, ADIS16203_SCAN_INCLI_Y,
-		 IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
-		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
-		 temp, ADIS16203_SCAN_TEMP,
-		 IIO_ST('u', 12, 16, 0), 0),
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "supply",
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = in_supply,
+		.scan_index = ADIS16203_SCAN_SUPPLY,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = in_aux,
+		.scan_index = ADIS16203_SCAN_AUX_ADC,
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
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		.address = incli_x,
+		.scan_index = ADIS16203_SCAN_INCLI_X,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	}, { /* Fixme: Not what it appears to be - see data sheet */
+		.type = IIO_INCLI,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.address = incli_y,
+		.scan_index = ADIS16203_SCAN_INCLI_Y,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
+		.address = temp,
+		.scan_index = ADIS16203_SCAN_TEMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
 
-- 
1.7.0.4

