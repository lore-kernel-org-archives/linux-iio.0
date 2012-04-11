Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35968 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708Ab2DKRlg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 13:41:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V2] staging:iio:adc:ad7476 unwind use of IIO_CHAN macro.
Date: Wed, 11 Apr 2012 18:41:29 +0100
Message-Id: <1334166089-29534-1-git-send-email-jic23@kernel.org>
In-Reply-To: <4F85534B.6000809@metafoo.de>
References: <4F85534B.6000809@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

V2 has the cleanup Lars-Peter suggested.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>

---
Basically this now makes use of the fact that the shift + bits = 12 in
all cases. 

 drivers/staging/iio/adc/ad7476_core.c |   45 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

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
1.7.9.4

