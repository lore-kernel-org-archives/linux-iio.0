Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60268 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758173Ab3CDVQa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 16:16:30 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Stefan Roese <sr@denx.de>
Subject: [PATCH 1/3] staging:iio:adc:spear move to info_mask_(shared_by_type/separate)
Date: Mon,  4 Mar 2013 21:16:18 +0000
Message-Id: <1362431780-27682-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1362431780-27682-1-git-send-email-jic23@kernel.org>
References: <1362431780-27682-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 13052ce..f45da42 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -180,8 +180,8 @@ static int spear_read_raw(struct iio_dev *indio_dev,
 #define SPEAR_ADC_CHAN(idx) {				\
 	.type = IIO_VOLTAGE,				\
 	.indexed = 1,					\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
-	IIO_CHAN_INFO_SCALE_SHARED_BIT,			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.channel = idx,					\
 	.scan_type = {					\
 		.sign = 'u',				\
-- 
1.8.1.4

