Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 3/4] staging:iio:lpc32xx_adc: Ensure request_irq and free_irq dev_id parameter match
Date: Fri, 13 Jul 2012 14:04:08 +0200
Message-Id: <1342181050-22579-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1342181050-22579-1-git-send-email-lars@metafoo.de>
References: <1342181050-22579-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The data parameters for request_irq and free_irq have to match, otherwise the
IRQ wont be freed.

The issue has been discovered using the following coccinelle patch:

// <smpl>
@r1@
type T;
T data;
@@
(
request_irq(..., (void *)data)
|
request_irq(..., data)
|
request_threaded_irq(..., (void *)data)
|
request_threaded_irq(..., data)
)

@r2@
type r1.T;
T data;
position p;
@@
(
free_irq@p(..., (void *)data)
|
free_irq@p(..., data)
)

@depends on r1@
position p != r2.p;
@@
*free_irq@p(...)

// </smpl>

Cc: Roland Stigge <stigge@antcom.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/lpc32xx_adc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 9690306..348d051 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -196,7 +196,7 @@ static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
 	return 0;
 
 errout5:
-	free_irq(irq, iodev);
+	free_irq(irq, info);
 errout4:
 	clk_put(info->clk);
 errout3:
@@ -214,7 +214,7 @@ static int __devexit lpc32xx_adc_remove(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 
 	iio_device_unregister(iodev);
-	free_irq(irq, iodev);
+	free_irq(irq, info);
 	platform_set_drvdata(pdev, NULL);
 	clk_put(info->clk);
 	iounmap(info->adc_base);
-- 
1.7.10.4
