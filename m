Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:64697 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaJCB0v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Oct 2014 21:26:51 -0400
Received: by mail-qc0-f180.google.com with SMTP id x3so275804qcv.11
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2014 18:26:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: B38611@freescale.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 5/5] iio: adc: vf610: Remove CONFIG_PM_SLEEP ifdef's
Date: Thu,  2 Oct 2014 22:25:26 -0300
Message-Id: <1412299526-1331-5-git-send-email-festevam@gmail.com>
In-Reply-To: <1412299526-1331-1-git-send-email-festevam@gmail.com>
References: <1412299526-1331-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Mark the suspend/resume functions as '__maybe_unused' so that we can get rid
of the CONFIG_PM_SLEEP ifdef.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 6164558..bae9638 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -650,8 +650,7 @@ static int vf610_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int vf610_adc_suspend(struct device *dev)
+static int __maybe_unused vf610_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct vf610_adc *info = iio_priv(indio_dev);
@@ -668,7 +667,7 @@ static int vf610_adc_suspend(struct device *dev)
 	return 0;
 }
 
-static int vf610_adc_resume(struct device *dev)
+static int __maybe_unused vf610_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct vf610_adc *info = iio_priv(indio_dev);
@@ -690,7 +689,6 @@ disable_reg:
 	regulator_disable(info->vref);
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
 
-- 
1.9.1

