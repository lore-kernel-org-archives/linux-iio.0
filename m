Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35731 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3CBQRf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:35 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 12/67] iio:adc:at91_adc move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:29 +0000
Message-Id: <1362241044-3534-13-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a526c0e..0516c5e 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -140,8 +140,8 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 		chan->scan_type.sign = 'u';
 		chan->scan_type.realbits = 10;
 		chan->scan_type.storagebits = 16;
-		chan->info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
-			IIO_CHAN_INFO_RAW_SEPARATE_BIT;
+		chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 		idx++;
 	}
 	timestamp = chan_array + idx;
-- 
1.8.1.4

