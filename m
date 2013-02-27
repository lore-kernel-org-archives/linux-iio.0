Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59132 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758905Ab3B0UkO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:14 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 21/67] iio:dac:ad5421 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:27 +0000
Message-Id: <1361997553-31058-22-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5421.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 6b86a63..903c18d 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -86,11 +86,11 @@ static const struct iio_chan_spec ad5421_channels[] = {
 		.indexed = 1,
 		.output = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT |
-			IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-			IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-			IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+			IIO_CHAN_INFO_CALIBSCALE |
+			IIO_CHAN_INFO_CALIBBIAS,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE |
+			IIO_CHAN_INFO_OFFSET,
 		.scan_type = IIO_ST('u', 16, 16, 0),
 		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
 			IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-- 
1.8.1.1

