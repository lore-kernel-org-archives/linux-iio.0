Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 5/6] iio: light: lm3533-als: Use devm_iio_device_alloc
Date: Tue, 30 Jul 2013 14:14:27 +0530
Message-Id: <1375173868-13235-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Johan Hovold <jhovold@gmail.com>
---
 drivers/iio/light/lm3533-als.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 5fa31a4..c1aadc6 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -847,7 +847,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*als));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*als));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -870,7 +870,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	if (als->irq) {
 		ret = lm3533_als_setup_irq(als, indio_dev);
 		if (ret)
-			goto err_free_dev;
+			return ret;
 	}
 
 	ret = lm3533_als_setup(als, pdata);
@@ -894,8 +894,6 @@ err_disable:
 err_free_irq:
 	if (als->irq)
 		free_irq(als->irq, indio_dev);
-err_free_dev:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -910,7 +908,6 @@ static int lm3533_als_remove(struct platform_device *pdev)
 	lm3533_als_disable(als);
 	if (als->irq)
 		free_irq(als->irq, indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
