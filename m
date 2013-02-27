Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758662Ab3B0UkM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:12 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 12/67] iio:adc:at91_adc move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:18 +0000
Message-Id: <1361997553-31058-13-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a526c0e..65095a0 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -140,8 +140,8 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 		chan->scan_type.sign = 'u';
 		chan->scan_type.realbits = 10;
 		chan->scan_type.storagebits = 16;
-		chan->info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
-			IIO_CHAN_INFO_RAW_SEPARATE_BIT;
+		chan->info_mask_shared_by_type = IIO_CHAN_INFO_SCALE;
+		chan->info_mask_separate = IIO_CHAN_INFO_RAW;
 		idx++;
 	}
 	timestamp = chan_array + idx;
-- 
1.8.1.1

