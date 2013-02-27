Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59260 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759604Ab3B0UkX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:23 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 53/67] staging:iio:cdc:ad7152 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:59 +0000
Message-Id: <1361997553-31058-54-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Michael Hennerich <michael.hennerich@analog.com>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/cdc/ad7152.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 3c92ba3..69ddaef 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -436,38 +436,38 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE |
+		IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 	}, {
 		.type = IIO_CAPACITANCE,
 		.differential = 1,
 		.indexed = 1,
 		.channel = 0,
 		.channel2 = 2,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE |
+		IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 	}, {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE |
+		IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 	}, {
 		.type = IIO_CAPACITANCE,
 		.differential = 1,
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 3,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE |
+		IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 	}
 };
 /*
-- 
1.8.1.1

