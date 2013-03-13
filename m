Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30186 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab3CMEvQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2013 00:51:16 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, dan.carpenter@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de
Subject: [PATCH v3] iio: adc: exynos5_adc: fix compilation warnings
Date: Wed, 13 Mar 2013 10:18:58 +0530
Message-id: <1363150138-20819-1-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1362625743-10401-1-git-send-email-ch.naveen@samsung.com>
References: <1362625743-10401-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the compilation warnings and potential NULL pointer
dereferencing pointed out by "Dan Carpenter".

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Series-To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
---
Changes since v2:
1. Timeout should be long not int
2. Remove unnecessary variable version, use ret instead.

Apologize me for top posting.

Doug, There was a comment from Lars regarding the match not
being NULL, if driver depends on CONFIG_OF. So, i've removed
the NULL check in v2 of this patch.
	https://patchwork.kernel.org/patch/2222841/

I'm checking the return value of get_version() for -ve values before
assigning to info->version. So, i left the (unsigned int) unchanged.

If required, I will resubmit with both these comments addressed.

 drivers/iio/adc/Kconfig      |    1 +
 drivers/iio/adc/exynos_adc.c |   18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 04311f8..da67626 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -93,6 +93,7 @@ config AT91_ADC
 
 config EXYNOS_ADC
 	bool "Exynos ADC driver support"
+	depends on OF
 	help
 	  Core support for the ADC block found in the Samsung EXYNOS series
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index ed6fdd7..2d41bb5 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -92,7 +92,7 @@ struct exynos_adc {
 	struct completion	completion;
 
 	u32			value;
-	unsigned int            version;
+	unsigned int		version;
 };
 
 static const struct of_device_id exynos_adc_match[] = {
@@ -102,12 +102,12 @@ static const struct of_device_id exynos_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, exynos_adc_match);
 
-static inline unsigned int exynos_adc_get_version(struct platform_device *pdev)
+static inline int exynos_adc_get_version(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 
 	match = of_match_node(exynos_adc_match, pdev->dev.of_node);
-	return (unsigned int)match->data;
+	return (int)match->data;
 }
 
 static int exynos_read_raw(struct iio_dev *indio_dev,
@@ -117,7 +117,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				long mask)
 {
 	struct exynos_adc *info = iio_priv(indio_dev);
-	unsigned long timeout;
+	long timeout;
 	u32 con1, con2;
 
 	if (mask != IIO_CHAN_INFO_RAW)
@@ -268,6 +268,14 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	info = iio_priv(indio_dev);
 
+	ret = exynos_adc_get_version(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no matching of_node, err = %d\n", ret);
+		goto err_iio;
+	}
+
+	info->version = ret;
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	info->regs = devm_request_and_ioremap(&pdev->dev, mem);
@@ -311,8 +319,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	info->version = exynos_adc_get_version(pdev);
-
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.7.9.5

