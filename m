Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-011.synserver.de ([212.40.185.11]:1097 "EHLO
	smtp-out-226.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760137Ab3CZSlO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2013 14:41:14 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] staging:iio:ad799x: Set IIO_CHAN_INFO_SCALE mask
Date: Tue, 26 Mar 2013 19:43:03 +0100
Message-Id: <1364323384-30863-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1364323384-30863-1-git-send-email-lars@metafoo.de>
References: <1364323384-30863-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver has support for reporting a channels scale, but none of the channels
set the IIO_CHAN_INFO_SCALE mask. Add the IIO_CHAN_INFO_SCALE to all channels to
indicate that the drivers supports reporting the scale.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 49972e1..b751055 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -465,6 +465,7 @@ static const struct iio_info ad7993_4_7_8_info = {
 	.indexed = 1, \
 	.channel = (_index), \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = (_index), \
 	.scan_type = IIO_ST('u', _realbits, 16, 12 - (_realbits)), \
 	.event_mask = (_evmask), \
-- 
1.8.0

