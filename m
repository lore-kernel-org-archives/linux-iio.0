Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:34560 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbaFKG4v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jun 2014 02:56:51 -0400
Date: Wed, 11 Jun 2014 09:53:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Josh Wu <josh.wu@atmel.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Thomas Meyer <thomas@m3y3r.de>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: adc: at91: signedness bug in
 at91_adc_get_trigger_value_by_name()
Message-ID: <20140611065356.GB16443@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The function returns a u8 so the -ENOMEM is truncated to a positive
value.  The caller tests for zero returns and treats them as an error
so I have changed the -ENOMEM to 0.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 3b5bacd..5ebe33d 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -525,7 +525,7 @@ static u8 at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
 				idev->id,
 				triggers[i].name);
 		if (!name)
-			return -ENOMEM;
+			return 0;
 
 		if (strcmp(trigger_name, name) == 0) {
 			value = triggers[i].value;
