Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47309 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941546AbdDTK04 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2017 06:26:56 -0400
Date: Thu, 20 Apr 2017 13:26:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: Max9611: checking for ERR_PTR instead of NULL in
 probe
Message-ID: <20170420102618.z6xqguj5rnob67if@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_alloc() doesn't return ERR_PTRs, it returns NULLs.

Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index ec82106480e1..dc3869bf3248 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -536,8 +536,8 @@ static int max9611_probe(struct i2c_client *client,
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max9611));
-	if (IS_ERR(indio_dev))
-		return PTR_ERR(indio_dev);
+	if (!indio_dev)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, indio_dev);
 
