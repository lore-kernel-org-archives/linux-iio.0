Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 7/7] staging:iio:adc:max1363 correctly set channels as big endian.
Date: Mon,  5 Dec 2011 21:37:16 +0000
Message-Id: <1323121036-21094-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1323121036-21094-1-git-send-email-jic23@kernel.org>
References: <1323121036-21094-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
1.7.7.4
