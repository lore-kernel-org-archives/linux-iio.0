Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32947 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980247AbdDYDgU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 23:36:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id 63so8181963pgh.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2017 20:36:20 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: adc: mxs-lradc: Fix return value check in mxs_lradc_adc_probe()
Date: Tue, 25 Apr 2017 03:36:12 +0000
Message-Id: <20170425033612.27251-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/mxs-lradc-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index b0c7d8e..493e2a2 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -719,8 +719,8 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
-	if (IS_ERR(adc->base))
-		return PTR_ERR(adc->base);
+	if (!adc->base)
+		return -ENOMEM;
 
 	init_completion(&adc->completion);
 	spin_lock_init(&adc->lock);

