Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41439 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759412Ab2DJUWE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:22:04 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/14] staging:iio:accel:ad7780 unwind use of IIO_CHAN macro.
Date: Tue, 10 Apr 2012 21:21:46 +0100
Message-Id: <1334089310-22576-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-1-git-send-email-jic23@kernel.org>
References: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7780.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index a13e58c..4f0a6c9 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -126,14 +126,32 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7780] = {
-		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				    IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				    0, 0, IIO_ST('s', 24, 32, 8), 0),
+		.channel = {
+			.type = IIO_VOLTAGE,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			.scan_type = {
+				.sign = 's',
+				.realbits = 24,
+				.storagebits = 32,
+				.shift = 8,
+			},
+		},
 	},
 	[ID_AD7781] = {
-		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				    IIO_CHAN_INFO_SCALE_SHARED_BIT,
-				    0, 0, IIO_ST('s', 20, 32, 12), 0),
+		.channel = {
+			.type = IIO_VOLTAGE,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			.scan_type = {
+				.sign = 's',
+				.realbits = 20,
+				.storagebits = 32,
+				.shift = 12,
+			},
+		},
 	},
 };
 
-- 
1.7.9.4

