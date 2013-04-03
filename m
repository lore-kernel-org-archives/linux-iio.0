Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	ch.naveen@samsung.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 2/2] adc: exynos_adc: Fix incorrect variable type
Date: Wed,  3 Apr 2013 11:53:59 +0530
Message-Id: <1364970239-8242-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org>
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

wait_for_completion_interruptible_timeout() returns negative value on error
but is assigned to an unsigned variable. Though this might not matter much
as the return value is only tested for '0', for the sake of code correctness
modify the variable type suitably. Without this patch we get the following
smatch error:
drivers/iio/adc/exynos_adc.c:147 exynos_read_raw() error:
'wait_for_completion_interruptible_timeout()' returns negative and
'timeout' is unsigned

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/exynos_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 22d034a..3bf5132 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -118,7 +118,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				long mask)
 {
 	struct exynos_adc *info = iio_priv(indio_dev);
-	unsigned long timeout;
+	long timeout;
 	u32 con1, con2;
 
 	if (mask != IIO_CHAN_INFO_RAW)
-- 
1.7.9.5
