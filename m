Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752895AbeAQLXn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Jan 2018 06:23:43 -0500
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-iio@vger.kernel.org>
Subject: [PATCH -next] iio: ep93xx: remove redundant return value check of platform_get_resource()
Date: Wed, 17 Jan 2018 11:30:00 +0000
Message-ID: <1516188600-170557-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/ep93xx_adc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index 81c9015..5036c392 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -167,10 +167,6 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
 	priv = iio_priv(iiodev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Cannot obtain memory resource\n");
-		return -ENXIO;
-	}
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base)) {
 		dev_err(&pdev->dev, "Cannot map memory resource\n");

