Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:16415 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdEJFvq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2017 01:51:46 -0400
Date: Wed, 10 May 2017 08:51:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vignesh R <vigneshr@ti.com>,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Engl <michael.engl@wjw-solutions.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: ti_am335x_adc: allocating too much in probe
Message-ID: <20170510055109.i2aql4xg4rovcqmw@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We should be allocating enough information for a tiadc_device struct
which is about 400 bytes but instead we allocate enough for a second
iio_dev struct which is over 2000 bytes.

Fixes: fea89e2dfcea ("iio: adc: ti_am335x_adc: use variable names for sizeof() operator")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 4282ceca3d8f..6cbed7eb118a 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -614,7 +614,7 @@ static int tiadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*indio_dev));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
 	if (indio_dev == NULL) {
 		dev_err(&pdev->dev, "failed to allocate iio device\n");
 		return -ENOMEM;
