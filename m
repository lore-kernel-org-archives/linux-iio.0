Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48316 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab3E0TMS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2013 15:12:18 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, "Patil, Rachna" <rachna@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/19] input: touchscreen: am335x: Step enable bits made configurable
Date: Mon, 27 May 2013 21:11:48 +0200
Message-Id: <1369681926-22185-2-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Patil, Rachna" <rachna@ti.com>

Current code has hard coded value written to
step enable bits. Now the bits are updated based
on how many steps are needed to be configured got
from platform data.

The user needs to take care not to exceed
the count more than 16. While using ADC and TSC
one should take care to set this parameter correctly.

Signed-off-by: Patil, Rachna <rachna@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   10 ++++++++--
 include/linux/mfd/ti_am335x_tscadc.h      |    1 -
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 51e7b87..da652e0 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -39,6 +39,7 @@ struct titsc {
 	unsigned int		irq;
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
+	unsigned int		enable_bits;
 	bool			pen_down;
 	int			steps_to_configure;
 };
@@ -57,6 +58,7 @@ static void titsc_writel(struct titsc *tsc, unsigned int reg,
 static void titsc_step_config(struct titsc *ts_dev)
 {
 	unsigned int	config;
+	unsigned int	stepenable = 0;
 	int i, total_steps;
 
 	/* Configure the Step registers */
@@ -128,7 +130,11 @@ static void titsc_step_config(struct titsc *ts_dev)
 	titsc_writel(ts_dev, REG_STEPDELAY(total_steps + 2),
 			STEPCONFIG_OPENDLY);
 
-	titsc_writel(ts_dev, REG_SE, STPENB_STEPENB_TC);
+	for (i = 0; i <= (total_steps + 2); i++)
+		stepenable |= 1 << i;
+	ts_dev->enable_bits = stepenable;
+
+	titsc_writel(ts_dev, REG_SE, ts_dev->enable_bits);
 }
 
 static void titsc_read_coordinates(struct titsc *ts_dev,
@@ -250,7 +256,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 
 	titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
 
-	titsc_writel(ts_dev, REG_SE, STPENB_STEPENB_TC);
+	titsc_writel(ts_dev, REG_SE, ts_dev->enable_bits);
 	return IRQ_HANDLED;
 }
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index c79ad5d..23e4f33 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -47,7 +47,6 @@
 #define STEPENB_MASK		(0x1FFFF << 0)
 #define STEPENB(val)		((val) << 0)
 #define STPENB_STEPENB		STEPENB(0x1FFFF)
-#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
 
 /* IRQ enable */
 #define IRQENB_HW_PEN		BIT(0)
-- 
1.7.10.4

