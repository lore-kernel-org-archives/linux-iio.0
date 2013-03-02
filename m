Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35723 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab3CBQRf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:35 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	"Patil, Rachna" <rachna@ti.com>
Subject: [PATCH 15/67] iio:adc:ti_am335x_adc move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:32 +0000
Message-Id: <1362241044-3534-16-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Patil, Rachna <rachna@ti.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index cd030e1..5f9a7e7 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -89,7 +89,7 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
 		chan->channel = i;
-		chan->info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT;
+		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	}
 
 	indio_dev->channels = chan_array;
-- 
1.8.1.4

