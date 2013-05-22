Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58884 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279Ab3EVVIh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:08:37 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Felipe Balbi <balbi@ti.com>, "Patil Rachna" <rachna@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/7] input/i_am335x_tsc: removed unused variable in titsc_irq()
Date: Wed, 22 May 2013 23:08:13 +0200
Message-Id: <1369256897-25984-3-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
References: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index e778ffd..a85818b 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -319,7 +319,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int z1, z2, z;
 	unsigned int fsm;
 	unsigned int diffx = 0, diffy = 0;
-	int i;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
-- 
1.7.10.4

