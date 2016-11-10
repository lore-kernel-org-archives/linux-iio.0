Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19569 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934314AbcKJTbA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2016 14:31:00 -0500
Date: Thu, 10 Nov 2016 22:30:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio:adc: ad7766: testing the wrong variable in probe
Message-ID: <20161110193018.GB32533@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We should be testing "ret" here.

Fixes: aa16c6bd0e09 ("iio:adc: Add support for AD7766/AD7767")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index d906686..75cca42 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -239,8 +239,8 @@ static int ad7766_probe(struct spi_device *spi)
 
 	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(ad7766->reg),
 		ad7766->reg);
-	if (IS_ERR(ad7766->reg))
-		return PTR_ERR(ad7766->reg);
+	if (ret)
+		return ret;
 
 	ad7766->pd_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
 		GPIOD_OUT_HIGH);
