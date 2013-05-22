Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58904 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386Ab3EVVIk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:08:40 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Felipe Balbi <balbi@ti.com>, "Patil Rachna" <rachna@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 6/7] mfd/ti_am335x_tscadc: remove platform_data support
Date: Wed, 22 May 2013 23:08:16 +0200
Message-Id: <1369256897-25984-6-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
References: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes access to platform data mfd_tscadc_board because the
platform is DT only.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ti_am335x_tscadc.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index e28a31d..c27b147 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -26,8 +26,6 @@
 #include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
-#include <linux/input/ti_am335x_tsc.h>
-#include <linux/platform_data/ti_am335x_adc.h>
 
 static unsigned int tscadc_readl(struct ti_tscadc_dev *tsadc, unsigned int reg)
 {
@@ -66,31 +64,22 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct ti_tscadc_dev	*tscadc;
 	struct resource		*res;
 	struct clk		*clk;
-	struct mfd_tscadc_board	*pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	struct mfd_cell		*cell;
 	int			err, ctrl;
 	int			clk_value, clock_rate;
 	int			tsc_wires = 0, adc_channels = 0, total_channels;
 
-	if (!pdata && !pdev->dev.of_node) {
-		dev_err(&pdev->dev, "Could not find platform data\n");
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "Could not find valid DT data.\n");
 		return -EINVAL;
 	}
 
-	if (pdev->dev.platform_data) {
-		if (pdata->tsc_init)
-			tsc_wires = pdata->tsc_init->wires;
+	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
+	of_property_read_u32(node, "ti,wires", &tsc_wires);
 
-		if (pdata->adc_init)
-			adc_channels = pdata->adc_init->adc_channels;
-	} else {
-		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
-		of_property_read_u32(node, "ti,wires", &tsc_wires);
-
-		node = of_get_child_by_name(pdev->dev.of_node, "adc");
-		of_property_read_u32(node, "ti,adc-channels", &adc_channels);
-	}
+	node = of_get_child_by_name(pdev->dev.of_node, "adc");
+	of_property_read_u32(node, "ti,adc-channels", &adc_channels);
 
 	total_channels = tsc_wires + adc_channels;
 
-- 
1.7.10.4

