Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH 11/11] iio: adc: viperboard_adc: Use devm_iio_device_alloc
Date: Tue, 23 Jul 2013 14:28:17 +0530
Message-Id: <1374569897-3858-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/iio/adc/viperboard_adc.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 56ac481..09727a7 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -124,7 +124,7 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	/* registering iio */
-	indio_dev = iio_device_alloc(sizeof(*adc));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
 	if (!indio_dev) {
 		dev_err(&pdev->dev, "failed allocating iio device\n");
 		return -ENOMEM;
@@ -142,16 +142,12 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register iio (adc)");
-		goto error;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	return 0;
-
-error:
-	iio_device_free(indio_dev);
-	return ret;
 }
 
 static int vprbrd_adc_remove(struct platform_device *pdev)
@@ -159,7 +155,6 @@ static int vprbrd_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
 	iio_device_unregister(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
