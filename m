Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44106 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967621AbdDZVEe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 17:04:34 -0400
Date: Thu, 27 Apr 2017 00:03:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: mxs-lradc: Checking IS_ERR() instead of NULL
Message-ID: <20170426210349.sjmf65ck5awfgz22@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_ioremap() returns NULL on error.  It doesn't return error pointers.

Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index b0c7d8ee5cb8..493e2a26415d 100644
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
