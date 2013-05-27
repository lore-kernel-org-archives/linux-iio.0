Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48332 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TMU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2013 15:12:20 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, "Patil, Rachna" <rachna@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/19] input: ti_am335x_tsc: Add variance filters
Date: Mon, 27 May 2013 21:11:52 +0200
Message-Id: <1369681926-22185-6-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Patil, Rachna" <rachna@ti.com>

Only fine tuning variance present in tslib utility
does not help in removing all the wanted ADC noise.

This logic of filtering is necessary to get this
touchscreen to work finely.

Signed-off-by: Patil, Rachna <rachna@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index be5cb67..b7d3c23 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -34,6 +34,8 @@
 #define ADCFSM_STEPID		0x10
 #define SEQ_SETTLE		275
 #define MAX_12BIT		((1 << 12) - 1)
+#define TSCADC_DELTA_X		15
+#define TSCADC_DELTA_Y		15
 
 /*
  * Refer to function regbit_map() to
@@ -53,6 +55,8 @@ struct titsc {
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
 	unsigned int		enable_bits;
+	unsigned int		bckup_x;
+	unsigned int		bckup_y;
 	bool			pen_down;
 	int			steps_to_configure;
 	int			config_inp[20];
@@ -310,11 +314,18 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int x = 0, y = 0;
 	unsigned int z1, z2, z;
 	unsigned int fsm;
+	unsigned int diffx = 0, diffy = 0;
+	int i;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
 		titsc_read_coordinates(ts_dev, &x, &y);
 
+		diffx = abs(x - (ts_dev->bckup_x));
+		diffy = abs(y - (ts_dev->bckup_y));
+		ts_dev->bckup_x = x;
+		ts_dev->bckup_y = y;
+
 		z1 = titsc_readl(ts_dev, REG_FIFO0) & 0xfff;
 		z2 = titsc_readl(ts_dev, REG_FIFO1) & 0xfff;
 
@@ -330,7 +341,8 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			z /= z1;
 			z = (z + 2047) >> 12;
 
-			if (z <= MAX_12BIT) {
+			if ((diffx < TSCADC_DELTA_X) &&
+			(diffy < TSCADC_DELTA_Y) && (z <= MAX_12BIT)) {
 				input_report_abs(input_dev, ABS_X, x);
 				input_report_abs(input_dev, ABS_Y, y);
 				input_report_abs(input_dev, ABS_PRESSURE, z);
@@ -353,6 +365,8 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		fsm = titsc_readl(ts_dev, REG_ADCFSM);
 		if (fsm == ADCFSM_STEPID) {
 			ts_dev->pen_down = false;
+			ts_dev->bckup_x = 0;
+			ts_dev->bckup_y = 0;
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
-- 
1.7.10.4

