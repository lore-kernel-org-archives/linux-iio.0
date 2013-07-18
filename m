Return-Path: <zubair.lutfullah@gmail.com>
From: Zubair Lutfullah <zubair.lutfullah@gmail.com>
To: jic23@cam.ac.uk
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	koen@dominion.thruhere.net
Subject: [PATCH 08/15] iio: ti_am335x_adc: Handle overrun before threshold event
Date: Thu, 18 Jul 2013 23:21:19 +0100
Message-Id: <1374186086-5015-9-git-send-email-zubair.lutfullah@gmail.com>
In-Reply-To: <1374186086-5015-1-git-send-email-zubair.lutfullah@gmail.com>
References: <1374186086-5015-1-git-send-email-zubair.lutfullah@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Russ Dill <Russ.Dill@ti.com>

If an overrun occurs, the threshold event is meaningless, handle
the overrun event first.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
---
 drivers/iio/adc/ti_am335x_adc.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 1c47818..7ac28a9 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -167,7 +167,16 @@ static irqreturn_t tiadc_irq(int irq, void *private)
 	unsigned int status, config;
 
 	status = tiadc_readl(adc_dev, REG_IRQSTATUS);
-	if (status & IRQENB_FIFO1THRES) {
+	if (status & IRQENB_FIFO1OVRRUN) {
+		config = tiadc_readl(adc_dev, REG_CTRL);
+		config &= ~(CNTRLREG_TSCSSENB);
+		tiadc_writel(adc_dev, REG_CTRL, config);
+		tiadc_writel(adc_dev, REG_IRQSTATUS,
+				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW);
+		tiadc_writel(adc_dev, REG_CTRL,
+				(config | CNTRLREG_TSCSSENB));
+		return IRQ_HANDLED;
+	} else if (status & IRQENB_FIFO1THRES) {
 		tiadc_writel(adc_dev, REG_IRQCLR,
 				IRQENB_FIFO1THRES);
 
@@ -180,19 +189,6 @@ static irqreturn_t tiadc_irq(int irq, void *private)
 		tiadc_writel(adc_dev, REG_IRQSTATUS,
 					IRQENB_FIFO1THRES);
 		return IRQ_HANDLED;
-	} else if ((status &  IRQENB_FIFO1OVRRUN) ||
-			(status &  IRQENB_FIFO1UNDRFLW)) {
-		config = tiadc_readl(adc_dev,  REG_CTRL);
-		config &= ~(CNTRLREG_TSCSSENB);
-		tiadc_writel(adc_dev,  REG_CTRL, config);
-
-		tiadc_writel(adc_dev, REG_IRQSTATUS,
-				IRQENB_FIFO1OVRRUN |
-				IRQENB_FIFO1UNDRFLW);
-
-		tiadc_writel(adc_dev,  REG_CTRL,
-			(config |  CNTRLREG_TSCSSENB));
-		return IRQ_HANDLED;
 	} else {
 		return IRQ_NONE;
 	}
-- 
1.7.9.5
