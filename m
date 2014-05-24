Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:55202 "EHLO
	gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaEXMSt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 May 2014 08:18:49 -0400
Message-ID: <1400933398.2079.16.camel@aldrin>
Subject: [PATCH] twl4030-madc: Request processed values in
 twl4030_get_madc_conversion
From: Paul Kocialkowski <contact@paulk.fr>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Date: Sat, 24 May 2014 14:09:58 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not setting the raw parameter in the request causes it to be randomly
initialized to a value that might be different from zero or zero. This leads to
values that are randomly either raw or processed, making it very difficult to
make reliable use of the values.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/iio/adc/twl4030-madc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 7de1c4c..eb86786 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -645,6 +645,7 @@ int twl4030_get_madc_conversion(int channel_no)
 	req.channels = (1 << channel_no);
 	req.method = TWL4030_MADC_SW2;
 	req.active = 0;
+	req.raw = 0;
 	req.func_cb = NULL;
 	ret = twl4030_madc_conversion(&req);
 	if (ret < 0)
-- 
1.7.9.5


