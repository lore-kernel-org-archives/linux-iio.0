Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48323 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab3E0TMT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2013 15:12:19 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, "Patil, Rachna" <rachna@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/19] input: touchscreen: am335x: remove unwanted fifo flush
Date: Mon, 27 May 2013 21:11:50 +0200
Message-Id: <1369681926-22185-4-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Patil, Rachna" <rachna@ti.com>

When touchscreen and ADC are used together, this
unwanted fifo flush leads to loss of ADC data.

Signed-off-by: Patil, Rachna <rachna@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 0c460f9..064d2b2 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -308,8 +308,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int x = 0, y = 0;
 	unsigned int z1, z2, z;
 	unsigned int fsm;
-	unsigned int fifo1count, fifo0count;
-	int i;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
@@ -318,14 +316,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		z1 = titsc_readl(ts_dev, REG_FIFO0) & 0xfff;
 		z2 = titsc_readl(ts_dev, REG_FIFO1) & 0xfff;
 
-		fifo1count = titsc_readl(ts_dev, REG_FIFO1CNT);
-		for (i = 0; i < fifo1count; i++)
-			titsc_readl(ts_dev, REG_FIFO1);
-
-		fifo0count = titsc_readl(ts_dev, REG_FIFO0CNT);
-		for (i = 0; i < fifo0count; i++)
-			titsc_readl(ts_dev, REG_FIFO0);
-
 		if (ts_dev->pen_down && z1 != 0 && z2 != 0) {
 			/*
 			 * Calculate pressure using formula
-- 
1.7.10.4

