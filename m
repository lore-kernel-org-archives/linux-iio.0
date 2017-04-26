Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40509 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967611AbdDZVE0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 17:04:26 -0400
Date: Thu, 27 Apr 2017 00:04:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/2] input: touchscreen: mxs-lradc: Checking for ERR_PTR
 instead of NULL in probe
Message-ID: <20170426210410.k2pe5ov2nkxtuf54@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_ioremap() returns NULL on error.  It never returns error pointers.

Fixes: d81ca730e3e4 ("input: touchscreen: mxs-lradc: Add support for touchscreen")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 4b4aebfe3e7f..ff9cda29d9a0 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -631,8 +631,8 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
-	if (IS_ERR(ts->base))
-		return PTR_ERR(ts->base);
+	if (!ts->base)
+		return -ENOMEM;
 
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
 				   &ts_wires);
