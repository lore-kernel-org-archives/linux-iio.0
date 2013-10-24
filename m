Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 4/9] iio: adc: twl6030-gpadc: Remove redundant code
Date: Thu, 24 Oct 2013 17:23:30 +0530
Message-Id: <1382615615-20153-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The if check is redundant as the value obtained from
iio_device_register() is already in the required format.
Hence return the function directly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/twl6030-gpadc.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 0ea96c0..5d13f8b 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -948,9 +948,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	indio_dev->channels = pdata->iio_channels;
 	indio_dev->num_channels = pdata->nchannels;
 
-	ret = iio_device_register(indio_dev);
-
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static int twl6030_gpadc_remove(struct platform_device *pdev)
-- 
1.7.9.5
