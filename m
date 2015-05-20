Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35995 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbETAx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2015 20:53:26 -0400
Received: by pabts4 with SMTP id ts4so45942958pab.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2015 17:53:25 -0700 (PDT)
Message-ID: <1432083200.7013.0.camel@ingics.com>
Subject: [PATCH] iio: adc: twl6030-gpadc: Fix modalias
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 20 May 2015 08:53:20 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove extra space between platform prefix and DRIVER_NAME in MODULE_ALIAS.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 89d8aa1..df12c57 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -1001,7 +1001,7 @@ static struct platform_driver twl6030_gpadc_driver = {
 
 module_platform_driver(twl6030_gpadc_driver);
 
-MODULE_ALIAS("platform: " DRIVER_NAME);
+MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Balaji T K <balajitk@ti.com>");
 MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
 MODULE_AUTHOR("Oleksandr Kozaruk <oleksandr.kozaruk@ti.com");
-- 
2.1.0



