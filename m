Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35724 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3CBQRe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:34 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/67] iio:adc:ad_sigma_delta move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:24 +0000
Message-Id: <1362241044-3534-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/adc/ad_sigma_delta.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 2e4eab9..e7fdec4 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -133,9 +133,9 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 		.channel2 = (_channel2), \
 		.address = (_address), \
 		.extend_name = (_extend_name), \
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-			IIO_CHAN_INFO_SCALE_SHARED_BIT | \
-			IIO_CHAN_INFO_OFFSET_SEPARATE_BIT, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_OFFSET), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 		.scan_index = (_si), \
 		.scan_type = { \
 			.sign = 'u', \
-- 
1.8.1.4

