Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35294 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab3FEQ2X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:28:23 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 16/22] mfd & input/ti_am335x_tsc: rename device from tsc to TI-am335x-tsc
Date: Wed,  5 Jun 2013 18:24:49 +0200
Message-Id: <1370449495-29981-17-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tsc is a very generic name. This patch adds a TI and HW prefix to it
less generic.
While here add an alias so the driver is loaded on demand.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    3 ++-
 drivers/mfd/ti_am335x_tscadc.c            |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index d247842..7a76b14 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -489,11 +489,12 @@ static struct platform_driver ti_tsc_driver = {
 	.probe	= titsc_probe,
 	.remove	= titsc_remove,
 	.driver	= {
-		.name   = "tsc",
+		.name   = "TI-am335x-tsc",
 		.owner	= THIS_MODULE,
 		.pm	= TITSC_PM_OPS,
 	},
 };
+MODULE_ALIAS("platform:TI-am335x-tsc");
 module_platform_driver(ti_tsc_driver);
 
 MODULE_DESCRIPTION("TI touchscreen controller driver");
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 857b6e8..ba9235a 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -194,7 +194,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (tsc_wires > 0) {
 		tscadc->tsc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "tsc";
+		cell->name = "TI-am335x-tsc";
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
 	}
-- 
1.7.10.4

