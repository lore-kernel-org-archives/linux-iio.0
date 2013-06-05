Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35237 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab3FEQ0G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:26:06 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 19/22] input/ti_am335x_tsc: ACK the HW_PEN irq in ISR
Date: Wed,  5 Jun 2013 18:24:52 +0200
Message-Id: <1370449495-29981-20-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The interrupt source IRQENB_HW_PEN is enabled in suspend and suposed to
be used as a wake up source. Once this interrupt source is unmaksed, the
devices ends up in ISR and never continues.
This change ACKs the interrupt and disables it so the system does not
freeze.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index fa9692c..82d4a39 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -308,6 +308,12 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		irqclr |= IRQENB_PENUP;
 	}
 
+	if (status & IRQENB_HW_PEN) {
+
+		titsc_writel(ts_dev, REG_IRQWAKEUP, 0x00);
+		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
+	}
+
 	titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
 
 	am335x_tsc_se_update(ts_dev->mfd_tscadc);
-- 
1.7.10.4

