Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35728 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab3CBQRe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:34 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/67] iio:adc:ad7476 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:27 +0000
Message-Id: <1362241044-3534-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7476.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 1491fa6..2e98bef4 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -140,12 +140,12 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-#define _AD7476_CHAN(bits, _shift, _info_mask)			\
+#define _AD7476_CHAN(bits, _shift, _info_mask_sep)		\
 	{							\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
-	.info_mask = _info_mask |				\
-	IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
+	.info_mask_separate = _info_mask_sep,			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.scan_type = {						\
 		.sign = 'u',					\
 		.realbits = (bits),				\
@@ -156,9 +156,9 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 }
 
 #define AD7476_CHAN(bits) _AD7476_CHAN((bits), 13 - (bits), \
-		IIO_CHAN_INFO_RAW_SEPARATE_BIT)
+		BIT(IIO_CHAN_INFO_RAW))
 #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
-		IIO_CHAN_INFO_RAW_SEPARATE_BIT)
+		BIT(IIO_CHAN_INFO_RAW))
 #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
-- 
1.8.1.4

