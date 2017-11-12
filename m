Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from m12-13.163.com ([220.181.12.13]:43365 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdKLQCD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Nov 2017 11:02:03 -0500
From: Pan Bian <bianpan2016@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] iio: adc: cpcap: fix incorrect validation
Date: Mon, 13 Nov 2017 00:01:20 +0800
Message-Id: <1510502480-27117-1-git-send-email-bianpan2016@163.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Function platform_get_irq_byname() returns a negative error code on
failure, and a zero or positive number on success. However, in function
cpcap_adc_probe(), positive IRQ numbers are also taken as error cases.
Use "if (ddata->irq < 0)" instead of "if (!ddata->irq)" to validate the
return value of platform_get_irq_byname().

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iio/adc/cpcap-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 6e419d5..f153e026 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -1012,7 +1012,7 @@ static int cpcap_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	ddata->irq = platform_get_irq_byname(pdev, "adcdone");
-	if (!ddata->irq)
+	if (ddata->irq < 0)
 		return -ENODEV;
 
 	error = devm_request_threaded_irq(&pdev->dev, ddata->irq, NULL,
-- 
1.9.1


