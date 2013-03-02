Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35722 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab3CBQRf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:35 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH 16/67] iio:adc:viperboard_adc move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:33 +0000
Message-Id: <1362241044-3534-17-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/iio/adc/viperboard_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index ad02615..56ac481 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -41,7 +41,7 @@ struct vprbrd_adc {
 	.type = IIO_VOLTAGE,				\
 	.indexed = 1,					\
 	.channel = _index,				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.scan_index = _index,				\
 	.scan_type = {					\
 		.sign = 'u',				\
-- 
1.8.1.4

