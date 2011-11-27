Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59490 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab1K0NKI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 08:10:08 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/7] staging:iio:adc:max1363 correctly set channels as big endian.
Date: Sun, 27 Nov 2011 13:10:12 +0000
Message-Id: <1322399412-21622-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399412-21622-1-git-send-email-jic23@kernel.org>
References: <1322399412-21622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Also, the differential channels should always have been signed.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 7e078fc..9febd1b 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -298,7 +298,12 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel = num,						\
 		.address = addr,					\
 		.info_mask = MAX1363_INFO_MASK,				\
-		.scan_type = IIO_ST('u', bits, (bits > 8) ? 16 : 8, 0), \
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = bits,				\
+			.storagebits = (bits > 8) ? 16 : 8,		\
+			.endianness = IIO_BE,				\
+		},							\
 		.scan_index = si,					\
 		.event_mask = evmask,					\
 	}
@@ -313,7 +318,12 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel2 = num2,					\
 		.address = addr,					\
 		.info_mask = MAX1363_INFO_MASK,				\
-		.scan_type = IIO_ST('u', bits, (bits > 8) ? 16 : 8, 0), \
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = bits,				\
+			.storagebits = (bits > 8) ? 16 : 8,		\
+			.endianness = IIO_BE,				\
+		},							\
 		.scan_index = si,					\
 		.event_mask = evmask,					\
 	}
-- 
1.7.7.3

