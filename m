Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35299 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab3FEQ2k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:28:40 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 20/22] input/ti_am335x_tsc: return IRQ_NONE if there was no IRQ for us
Date: Wed,  5 Jun 2013 18:24:53 +0200
Message-Id: <1370449495-29981-21-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The previous patch ("input/ti_am335x_tsc: ACK the HW_PEN irq in ISR")
acked the interrupt so we don't freeze if we don't handle an enabled
interrupt source. The interrupt core has a mechanism for this and to get
it work one should only say that it handled an interrupt if it is
actually the case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 82d4a39..a06447f 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -314,10 +314,12 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
 	}
 
-	titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
-
-	am335x_tsc_se_update(ts_dev->mfd_tscadc);
-	return IRQ_HANDLED;
+	if (irqclr) {
+		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
+		am335x_tsc_se_update(ts_dev->mfd_tscadc);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
 }
 
 static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
-- 
1.7.10.4

