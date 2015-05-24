Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] iio: twl4030-madc: Pass the IRQF_ONESHOT flag
Date: Sun, 24 May 2015 17:39:04 -0300
Message-Id: <1432499944-10395-1-git-send-email-festevam@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 1c6c69525b40 ("genirq: Reject bogus threaded irq requests")
threaded IRQs without a primary handler need to be requested with
IRQF_ONESHOT, otherwise the request will fail.

So pass the IRQF_ONESHOT flag in this case.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/irqf_oneshot.cocci.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/adc/twl4030-madc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 94c5f05..4caecbe 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -835,7 +835,8 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				   twl4030_madc_threaded_irq_handler,
-				   IRQF_TRIGGER_RISING, "twl4030_madc", madc);
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				   "twl4030_madc", madc);
 	if (ret) {
 		dev_err(&pdev->dev, "could not request irq\n");
 		goto err_i2c;
-- 
1.9.1
