Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35725 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3CBQRe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:34 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/67] iio:adc:ad7266 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:25 +0000
Message-Id: <1362241044-3534-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7266.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index bbad9b9..c2744a7 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -201,9 +201,9 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 	.indexed = 1,					\
 	.channel = (_chan),				\
 	.address = (_chan),				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT	\
-		| IIO_CHAN_INFO_SCALE_SHARED_BIT	\
-		| IIO_CHAN_INFO_OFFSET_SHARED_BIT,	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
+		| BIT(IIO_CHAN_INFO_OFFSET),			\
 	.scan_index = (_chan),				\
 	.scan_type = {					\
 		.sign = (_sign),			\
@@ -249,9 +249,9 @@ static AD7266_DECLARE_SINGLE_ENDED_CHANNELS_FIXED(s, 's');
 	.channel = (_chan) * 2,				\
 	.channel2 = (_chan) * 2 + 1,			\
 	.address = (_chan),				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT	\
-		| IIO_CHAN_INFO_SCALE_SHARED_BIT	\
-		| IIO_CHAN_INFO_OFFSET_SHARED_BIT,	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
+		| BIT(IIO_CHAN_INFO_OFFSET),			\
 	.scan_index = (_chan),				\
 	.scan_type = {					\
 		.sign = _sign,			\
-- 
1.8.1.4

