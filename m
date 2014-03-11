Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: sr@denx.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] staging:iio:adc:spear_adc drop initialization of unused scan_type
Date: Tue, 11 Mar 2014 20:36:57 +0000
Message-Id: <1394570219-7672-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1394570219-7672-1-git-send-email-jic23@kernel.org>
References: <1394570219-7672-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

As the driver does not support the buffered interfaces of IIO this is
not used.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/spear_adc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 886d9db..fbe69a7 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -196,10 +196,6 @@ static int spear_read_raw(struct iio_dev *indio_dev,
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
