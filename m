Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 1/1] iio: adc: twl6030-gpadc: Remove redundant of_match_ptr
Date: Mon, 21 Oct 2013 13:55:56 +0530
Message-Id: <1382343956-18483-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

of_twl6030_match_tbl is always compiled in. Hence of_match_ptr is
not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/twl6030-gpadc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 0ea96c0..2edfc7b 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -887,7 +887,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	match = of_match_device(of_match_ptr(of_twl6030_match_tbl), dev);
+	match = of_match_device(of_twl6030_match_tbl, dev);
 	if (!match)
 		return -EINVAL;
 
-- 
1.7.9.5
