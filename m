Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:47704 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137Ab3AUUF2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2013 15:05:28 -0500
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] iio: mxs: Add MX23 support into the IIO driver
Date: Mon, 21 Jan 2013 21:05:21 +0100
Message-Id: <1358798722-25102-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for i.MX23 into the LRADC driver. The LRADC
block on MX23 is not much different from the one on MX28, thus this
is only a few changes fixing the parts that are specific to MX23.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/staging/iio/adc/Kconfig     |    4 +--
 drivers/staging/iio/adc/mxs-lradc.c |   56 +++++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index fb8c239..7b2a01d 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -119,12 +119,12 @@ config LPC32XX_ADC
 	  via sysfs.
 
 config MXS_LRADC
-	tristate "Freescale i.MX28 LRADC"
+	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for i.MX28 LRADC convertor
+	  Say yes here to build support for i.MX23/i.MX28 LRADC convertor
 	  built into these chips.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 829d043..bea8372 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -76,7 +76,24 @@
  */
 #define LRADC_TS_SAMPLE_AMOUNT		4
 
-static const char * const mxs_lradc_irq_name[] = {
+enum mxs_lradc_id {
+	IMX23_LRADC,
+	IMX28_LRADC,
+};
+
+static const char * const mx23_lradc_irq_names[] = {
+	"mxs-lradc-touchscreen",
+	"mxs-lradc-channel0",
+	"mxs-lradc-channel1",
+	"mxs-lradc-channel2",
+	"mxs-lradc-channel3",
+	"mxs-lradc-channel4",
+	"mxs-lradc-channel5",
+	"mxs-lradc-channel6",
+	"mxs-lradc-channel7",
+};
+
+static const char * const mx28_lradc_irq_names[] = {
 	"mxs-lradc-touchscreen",
 	"mxs-lradc-thresh0",
 	"mxs-lradc-thresh1",
@@ -92,6 +109,22 @@ static const char * const mxs_lradc_irq_name[] = {
 	"mxs-lradc-button1",
 };
 
+struct mxs_lradc_of_config {
+	const int		irq_count;
+	const char * const	*irq_name;
+};
+
+static const struct mxs_lradc_of_config const mxs_lradc_of_config[] = {
+	[IMX23_LRADC] = {
+		.irq_count	= ARRAY_SIZE(mx23_lradc_irq_names),
+		.irq_name	= mx23_lradc_irq_names,
+	},
+	[IMX28_LRADC] = {
+		.irq_count	= ARRAY_SIZE(mx28_lradc_irq_names),
+		.irq_name	= mx28_lradc_irq_names,
+	},
+};
+
 enum mxs_lradc_ts {
 	MXS_LRADC_TOUCHSCREEN_NONE = 0,
 	MXS_LRADC_TOUCHSCREEN_4WIRE,
@@ -857,8 +890,19 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
 		writel(0, lradc->base + LRADC_DELAY(i));
 }
 
+static const struct of_device_id mxs_lradc_dt_ids[] = {
+	{ .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
+	{ .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
+
 static int mxs_lradc_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id =
+		of_match_device(mxs_lradc_dt_ids, &pdev->dev);
+	const struct mxs_lradc_of_config *of_cfg =
+		&mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct mxs_lradc *lradc;
@@ -902,7 +946,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 				ts_wires);
 
 	/* Grab all IRQ sources */
-	for (i = 0; i < 13; i++) {
+	for (i = 0; i < of_cfg->irq_count; i++) {
 		lradc->irq[i] = platform_get_irq(pdev, i);
 		if (lradc->irq[i] < 0) {
 			ret = -EINVAL;
@@ -911,7 +955,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(dev, lradc->irq[i],
 					mxs_lradc_handle_irq, 0,
-					mxs_lradc_irq_name[i], iio);
+					of_cfg->irq_name[i], iio);
 		if (ret)
 			goto err_addr;
 	}
@@ -983,12 +1027,6 @@ static int mxs_lradc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mxs_lradc_dt_ids[] = {
-	{ .compatible = "fsl,imx28-lradc", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
-
 static struct platform_driver mxs_lradc_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
-- 
1.7.10.4

