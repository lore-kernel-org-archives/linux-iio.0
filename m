Return-Path: <SRS0=F2s4=52=nxp.com=fabio.estevam@kernel.org>
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <festevam@gmail.com>, <marex@denx.de>, Fabio
 Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/2] iio: adc: mxs-lradc: Use devm_ioremap_resource()
Date: Wed, 21 Jun 2017 10:45:11 -0300
Message-ID: <1498052712-7659-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

By using devm_ioremap_resource() the code can be simplified, as we
no longer need to check whether platform_get_resource() succeeded
or not, as this check is already performed in devm_ioremap_resource().

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/iio/adc/mxs-lradc-adc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 6888167..2faf65f 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -718,12 +718,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	adc->dev = dev;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -EINVAL;
-
-	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
-	if (!adc->base)
-		return -ENOMEM;
+	adc->base = devm_ioremap_resource(dev, iores);
+	if (IS_ERR(adc->base))
+		return PTR_ERR(adc->base);
 
 	init_completion(&adc->completion);
 	spin_lock_init(&adc->lock);
-- 
2.7.4
