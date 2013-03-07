Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:10466 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab3CGDLS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Mar 2013 22:11:18 -0500
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de
Subject: [PATCH v2] iio: adc: exynos5_adc: fix compilation warnings
Date: Thu, 07 Mar 2013 08:39:03 +0530
Message-id: <1362625743-10401-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the compilation warnings and potential NULL pointer
dereferencing pointed out by "Dan Carpenter".

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Series-to: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
Changes since v1:
	Made the exynos_adc driver depends on CONFIG_OF.

 drivers/iio/adc/Kconfig      |    1 +
 drivers/iio/adc/exynos_adc.c |   21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a40d3c2..9c45c0f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -105,6 +105,7 @@ config AT91_ADC
 
 config EXYNOS_ADC
 	bool "Exynos ADC driver support"
+	depends on OF
 	help
 	  Core support for the ADC block found in the Samsung EXYNOS series
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index ed6fdd7..4fd5e3a 100644
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
+	int timeout;
 	u32 con1, con2;
 
 	if (mask != IIO_CHAN_INFO_RAW)
@@ -255,7 +255,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev = NULL;
 	struct resource	*mem;
 	int ret = -ENODEV;
-	int irq;
+	int irq, version;
 
 	if (!np)
 		return ret;
@@ -268,6 +268,15 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	info = iio_priv(indio_dev);
 
+	version = exynos_adc_get_version(pdev);
+	if (version < 0) {
+		dev_err(&pdev->dev, "no matching of_node, err = %d\n", version);
+		ret = version;
+		goto err_iio;
+	}
+
+	info->version = version;
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	info->regs = devm_request_and_ioremap(&pdev->dev, mem);
@@ -311,8 +320,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	info->version = exynos_adc_get_version(pdev);
-
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.7.9.5

