Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41675 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbaDEQoP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Apr 2014 12:44:15 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, sr@denx.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/6] staging:iio:adc:spear rename iodev -> indio_dev to fit with current convention
Date: Sat,  5 Apr 2014 17:45:14 +0100
Message-Id: <1396716315-2465-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-1-git-send-email-jic23@kernel.org>
References: <1396716315-2465-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

How we ended up with indio_dev is a mystery, but we have so in the interests
of consistency, move this driver over to that convention.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/spear_adc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 3003e89..52c26a6 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -262,17 +262,17 @@ static int spear_adc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct spear_adc_state *st;
-	struct iio_dev *iodev = NULL;
+	struct iio_dev *indio_dev = NULL;
 	int ret = -ENODEV;
 	int irq;
 
-	iodev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
-	if (!iodev) {
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
+	if (!indio_dev) {
 		dev_err(dev, "failed allocating iio device\n");
 		return -ENOMEM;
 	}
 
-	st = iio_priv(iodev);
+	st = iio_priv(indio_dev);
 	st->np = np;
 
 	/*
@@ -335,18 +335,18 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	spear_adc_configure(st);
 
-	platform_set_drvdata(pdev, iodev);
+	platform_set_drvdata(pdev, indio_dev);
 
 	init_completion(&st->completion);
 
-	iodev->name = SPEAR_ADC_MOD_NAME;
-	iodev->dev.parent = dev;
-	iodev->info = &spear_adc_info;
-	iodev->modes = INDIO_DIRECT_MODE;
-	iodev->channels = spear_adc_iio_channels;
-	iodev->num_channels = ARRAY_SIZE(spear_adc_iio_channels);
+	indio_dev->name = SPEAR_ADC_MOD_NAME;
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &spear_adc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = spear_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(spear_adc_iio_channels);
 
-	ret = iio_device_register(iodev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto errout3;
 
@@ -365,10 +365,10 @@ errout1:
 
 static int spear_adc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *iodev = platform_get_drvdata(pdev);
-	struct spear_adc_state *st = iio_priv(iodev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct spear_adc_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(iodev);
+	iio_device_unregister(indio_dev);
 	clk_disable_unprepare(st->clk);
 	clk_put(st->clk);
 	iounmap(st->adc_base_spear6xx);
-- 
1.9.0

