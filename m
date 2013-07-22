Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org,
	Marek Vasut <marex@denx.de>
Subject: [PATCH 5/8] staging: iio: mxs-lradc: Use devm_iio_device_alloc
Date: Mon, 22 Jul 2013 16:32:58 +0530
Message-Id: <1374490981-24373-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 327914e..6f8d3a0 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -913,7 +913,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	int i;
 
 	/* Allocate the IIO device. */
-	iio = iio_device_alloc(sizeof(*lradc));
+	iio = devm_iio_device_alloc(dev, sizeof(*lradc));
 	if (!iio) {
 		dev_err(dev, "Failed to allocate IIO device\n");
 		return -ENOMEM;
@@ -925,10 +925,8 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	lradc->dev = &pdev->dev;
 	lradc->base = devm_ioremap_resource(dev, iores);
-	if (IS_ERR(lradc->base)) {
-		ret = PTR_ERR(lradc->base);
-		goto err_addr;
-	}
+	if (IS_ERR(lradc->base))
+		return PTR_ERR(lradc->base);
 
 	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
 
@@ -948,16 +946,14 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	/* Grab all IRQ sources */
 	for (i = 0; i < of_cfg->irq_count; i++) {
 		lradc->irq[i] = platform_get_irq(pdev, i);
-		if (lradc->irq[i] < 0) {
-			ret = -EINVAL;
-			goto err_addr;
-		}
+		if (lradc->irq[i] < 0)
+			return -EINVAL;
 
 		ret = devm_request_irq(dev, lradc->irq[i],
 					mxs_lradc_handle_irq, 0,
 					of_cfg->irq_name[i], iio);
 		if (ret)
-			goto err_addr;
+			return ret;
 	}
 
 	platform_set_drvdata(pdev, iio);
@@ -977,7 +973,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 				&mxs_lradc_trigger_handler,
 				&mxs_lradc_buffer_ops);
 	if (ret)
-		goto err_addr;
+		return ret;
 
 	ret = mxs_lradc_trigger_init(iio);
 	if (ret)
@@ -1008,8 +1004,6 @@ err_dev:
 	mxs_lradc_trigger_remove(iio);
 err_trig:
 	iio_triggered_buffer_cleanup(iio);
-err_addr:
-	iio_device_free(iio);
 	return ret;
 }
 
@@ -1025,7 +1019,6 @@ static int mxs_lradc_remove(struct platform_device *pdev)
 	iio_device_unregister(iio);
 	iio_triggered_buffer_cleanup(iio);
 	mxs_lradc_trigger_remove(iio);
-	iio_device_free(iio);
 
 	return 0;
 }
-- 
1.7.9.5
