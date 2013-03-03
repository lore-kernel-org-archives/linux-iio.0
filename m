Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH 1/2] iio:adc:exynos move to info_mask_(shared_by_type/separate)
Date: Sun,  3 Mar 2013 20:03:52 +0000
Message-Id: <1362341033-9506-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1362341033-9506-1-git-send-email-jic23@kernel.org>
References: <1362341033-9506-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/iio/adc/exynos_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index ed6fdd7..6e968ae 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -198,7 +198,7 @@ static const struct iio_info exynos_adc_iio_info = {
 	.indexed = 1,					\
 	.channel = _index,				\
 	.address = _index,				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.datasheet_name = _id,				\
 }
 
-- 
1.8.1.4
