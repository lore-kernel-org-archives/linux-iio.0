Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60087 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbaCOOyO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Mar 2014 10:54:14 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: sr@denx.de, knaack.h@gmx.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/4] staging:iio:adc:spear_adc drop initialization of unused scan_type
Date: Sat, 15 Mar 2014 14:55:06 +0000
Message-Id: <1394895308-19154-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1394895308-19154-1-git-send-email-jic23@kernel.org>
References: <1394895308-19154-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As the driver does not support the buffered interfaces of IIO this is
not used.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 9234e05..fa1e2b2 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -179,10 +179,6 @@ static int spear_read_raw(struct iio_dev *indio_dev,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.channel = idx,					\
-	.scan_type = {					\
-		.sign = 'u',				\
-		.storagebits = 16,			\
-	},						\
 }
 
 static const struct iio_chan_spec spear_adc_iio_channels[] = {
-- 
1.9.0

