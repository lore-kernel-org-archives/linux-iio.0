Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35243 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab3FEQ0L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:26:11 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/22] mfd & iio/ti_am335x_adc: rename device from tiadc to TI-am335x-adc
Date: Wed,  5 Jun 2013 18:24:50 +0200
Message-Id: <1370449495-29981-18-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

TI-adc reads a little better compared to tiadc. And if we add am335x to
it then we have the same naming scheme as the tsc side.
While here add an alias so the driver is loaded on demand.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |    4 ++--
 drivers/mfd/ti_am335x_tscadc.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index c6695a8..38f2415 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -318,14 +318,14 @@ static const struct dev_pm_ops tiadc_pm_ops = {
 
 static struct platform_driver tiadc_driver = {
 	.driver = {
-		.name   = "tiadc",
+		.name   = "TI-am335x-adc",
 		.owner	= THIS_MODULE,
 		.pm	= TIADC_PM_OPS,
 	},
 	.probe	= tiadc_probe,
 	.remove	= tiadc_remove,
 };
-
+MODULE_ALIAS("platform:TI-am335x-adc");
 module_platform_driver(tiadc_driver);
 
 MODULE_DESCRIPTION("TI ADC controller driver");
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index ba9235a..8bdab8d 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -203,7 +203,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (adc_channels > 0) {
 		tscadc->adc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "tiadc";
+		cell->name = "TI-am335x-adc";
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
 	}
-- 
1.7.10.4

