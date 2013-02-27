Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759556Ab3B0UkW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:22 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 49/67] staging:iio:ad7291 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:55 +0000
Message-Id: <1361997553-31058-50-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 6e58e36..14c57b49 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -536,8 +536,8 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 #define AD7291_VOLTAGE_CHAN(_chan)					\
 {									\
 	.type = IIO_VOLTAGE,						\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |			\
-	IIO_CHAN_INFO_SCALE_SHARED_BIT,					\
+	.info_mask_separate = IIO_CHAN_INFO_RAW,			\
+	.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,		\
 	.indexed = 1,							\
 	.channel = _chan,						\
 	.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)|\
@@ -555,9 +555,9 @@ static const struct iio_chan_spec ad7291_channels[] = {
 	AD7291_VOLTAGE_CHAN(7),
 	{
 		.type = IIO_TEMP,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+				IIO_CHAN_INFO_AVERAGE_RAW |
+				IIO_CHAN_INFO_SCALE,
 		.indexed = 1,
 		.channel = 0,
 		.event_mask =
-- 
1.8.1.1

