Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH 2/3] staging:iio:adc:mxs move to info_mask_(shared_by_type/separate)
Date: Mon,  4 Mar 2013 21:16:19 +0000
Message-Id: <1362431780-27682-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1362431780-27682-1-git-send-email-jic23@kernel.org>
References: <1362431780-27682-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index f5fb0df..4ef3070 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -821,7 +821,7 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
 	.type = (chan_type),					\
 	.indexed = 1,						\
 	.scan_index = (idx),					\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.channel = (idx),					\
 	.scan_type = {						\
 		.sign = 'u',					\
-- 
1.8.1.4
