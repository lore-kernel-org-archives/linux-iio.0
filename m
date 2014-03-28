Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35222 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaC1IdS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Mar 2014 04:33:18 -0400
Date: Fri, 28 Mar 2014 11:33:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: adc: checking for NULL instead of IS_ERR() in probe
Message-ID: <20140328083126.GO25192@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

mcb_request_mem() returns an ERR_PTR(), it doesn't return NULL.

Fixes: 74aeac4da66f ('iio: adc: Add MEN 16z188 ADC driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index 6989c16..b58d630 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -121,8 +121,8 @@ static int men_z188_probe(struct mcb_device *dev,
 	indio_dev->num_channels = ARRAY_SIZE(z188_adc_iio_channels);
 
 	mem = mcb_request_mem(dev, "z188-adc");
-	if (!mem)
-		return -ENOMEM;
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
 
 	adc->base = ioremap(mem->start, resource_size(mem));
 	if (adc->base == NULL)
