Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60203 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934531Ab2DMJnH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:43:07 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/14] staging:iio:adc:ad7476 unwind use of IIO_CHAN macro.
Date: Fri, 13 Apr 2012 10:42:55 +0100
Message-Id: <1334310180-22170-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1334310180-22170-1-git-send-email-jic23@kernel.org>
References: <1334310180-22170-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

V2 has the cleanup Lars-Peter suggested.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7476_core.c |   45 +++++++++++++++-----------------
 1 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 0c064d1..694b508 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -66,53 +66,50 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+#define AD7476_CHAN(bits)					\
+	{							\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = bits,				\
+		.storagebits = 16,				\
+		.shift = 12 - bits,				\
+	},							\
+}
+
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7466] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[0] = AD7476_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7467] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 10, 16, 2), 0),
+		.channel[0] = AD7476_CHAN(10),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7468] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1 , 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 8, 16, 4), 0),
+		.channel[0] = AD7476_CHAN(8),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7475] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[0] = AD7476_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7476] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[0] = AD7476_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7477] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 10, 16, 2), 0),
+		.channel[0] = AD7476_CHAN(10),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7478] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 8, 16, 4), 0),
+		.channel[0] = AD7476_CHAN(8),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7495] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				       0, 0, IIO_ST('u', 12, 16, 0), 0),
+		.channel[0] = AD7476_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.int_vref_mv = 2500,
 	},
-- 
1.7.0.4

