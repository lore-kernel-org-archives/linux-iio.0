Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59132 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636Ab3B0UkW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:22 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 48/67] staging:iio:adc:ad7280a move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:54 +0000
Message-Id: <1361997553-31058-49-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7280a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 1f190c1..41a791a 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -503,9 +503,10 @@ static int ad7280_channel_init(struct ad7280_state *st)
 				st->channels[cnt].channel = (dev * 6) + ch - 6;
 			}
 			st->channels[cnt].indexed = 1;
-			st->channels[cnt].info_mask =
-				IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_SCALE_SHARED_BIT;
+			st->channels[cnt].info_mask_separate =
+				IIO_CHAN_INFO_RAW;
+			st->channels[cnt].info_mask_shared_by_type =
+				IIO_CHAN_INFO_SCALE;
 			st->channels[cnt].address =
 				AD7280A_DEVADDR(dev) << 8 | ch;
 			st->channels[cnt].scan_index = cnt;
@@ -521,9 +522,8 @@ static int ad7280_channel_init(struct ad7280_state *st)
 	st->channels[cnt].channel2 = dev * 6;
 	st->channels[cnt].address = AD7280A_ALL_CELLS;
 	st->channels[cnt].indexed = 1;
-	st->channels[cnt].info_mask =
-		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT;
+	st->channels[cnt].info_mask_separate = IIO_CHAN_INFO_RAW;
+	st->channels[cnt].info_mask_shared_by_type = IIO_CHAN_INFO_SCALE;
 	st->channels[cnt].scan_index = cnt;
 	st->channels[cnt].scan_type.sign = 'u';
 	st->channels[cnt].scan_type.realbits = 32;
-- 
1.8.1.1

