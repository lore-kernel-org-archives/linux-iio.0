Return-Path: <SRS0=F2s4=52=nxp.com=fabio.estevam@kernel.org>
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <festevam@gmail.com>, <marex@denx.de>, Fabio
 Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/2] iio: adc: lpc32xx_adc: Use devm_ioremap_resource()
Date: Wed, 21 Jun 2017 10:45:12 -0300
Message-ID: <1498052712-7659-2-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1498052712-7659-1-git-send-email-fabio.estevam@nxp.com>
References: <1498052712-7659-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

By using devm_ioremap_resource() the code can be simplified, as we
no longer need to check whether platform_get_resource() succeeded
or not, as this check is already performed in devm_ioremap_resource().

Also move devm_ioremap_resource() right after platform_get_resource()
for better readability. 

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/iio/adc/lpc32xx_adc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index 0de709b..56fb704 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -139,9 +139,10 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	int irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
-		return -ENXIO;
+	st->adc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(st->adc_base)) {
+		dev_err(&pdev->dev, "failed mapping memory\n");
+		return PTR_ERR(st->adc_base);
 	}
 
 	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
@@ -150,12 +151,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	st = iio_priv(iodev);
 
-	st->adc_base = devm_ioremap(&pdev->dev, res->start,
-				    resource_size(res));
-	if (!st->adc_base) {
-		dev_err(&pdev->dev, "failed mapping memory\n");
-		return -EBUSY;
-	}
 
 	st->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(st->clk)) {
-- 
2.7.4
