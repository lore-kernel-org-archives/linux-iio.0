Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59132 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758678Ab3B0UkM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:12 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	"Milo(Woogyom) Kim" <milo.kim@ti.com>
Subject: [PATCH 13/67] iio:adc:lp8778_adc move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:19 +0000
Message-Id: <1361997553-31058-14-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/adc/lp8788_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 763f575..c0f0a7e 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -132,8 +132,8 @@ static const struct iio_info lp8788_adc_info = {
 		.type = _type,					\
 		.indexed = 1,					\
 		.channel = LPADC_##_id,				\
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
+		.info_mask_separate = IIO_CHAN_INFO_RAW |	\
+			IIO_CHAN_INFO_SCALE,	\
 		.datasheet_name = #_id,				\
 }
 
-- 
1.8.1.1

