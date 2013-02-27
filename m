Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758651Ab3B0UkO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:14 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 20/67] iio:dac:ad5380 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:26 +0000
Message-Id: <1361997553-31058-21-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5380.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 483fc37..91d2acf 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -257,10 +257,10 @@ static struct iio_chan_spec_ext_info ad5380_ext_info[] = {
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.output = 1,						\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |		\
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |		\
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,		\
+	.info_mask_separate = IIO_CHAN_INFO_RAW |		\
+		IIO_CHAN_INFO_CALIBSCALE |			\
+		IIO_CHAN_INFO_CALIBBIAS,			\
+	.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,	\
 	.scan_type = IIO_ST('u', (_bits), 16, 14 - (_bits)),	\
 	.ext_info = ad5380_ext_info,				\
 }
-- 
1.8.1.1

