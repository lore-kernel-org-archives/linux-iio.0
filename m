Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jic23@cam.ac.uk,
	ch.naveen@samsung.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 1/2] iio: exynos_adc: Remove redundant of_match_ptr macro
Date: Tue, 26 Mar 2013 15:12:10 +0530
Message-Id: <1364290931-25772-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

exynos_adc is a DT only driver and exynos_adc_match table is always
compiled in. Hence remove the macro.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/exynos_adc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 4a8a9a3..9f3a8ef 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -440,7 +440,7 @@ static struct platform_driver exynos_adc_driver = {
 	.driver		= {
 		.name	= "exynos-adc",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(exynos_adc_match),
+		.of_match_table = exynos_adc_match,
 		.pm	= &exynos_adc_pm_ops,
 	},
 };
-- 
1.7.4.1
