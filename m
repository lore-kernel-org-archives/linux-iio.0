Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33988 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdEAWrx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 18:47:53 -0400
From: Eduardo Molinas <edu.molinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eduardo Molinas <edu.molinas@gmail.com>
Subject: [PATCH 2/2] [PATCH 2/2] iio: adc: sun4i-gpadc-iio: Fix module autoload when OF devices are registered
Date: Mon,  1 May 2017 18:45:59 -0400
Message-Id: <20170501224559.21028-2-edu.molinas@gmail.com>
In-Reply-To: <20170501224559.21028-1-edu.molinas@gmail.com>
References: <20170501224559.21028-1-edu.molinas@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the driver is built as a module, it won't be autloaded if the devices
are registered via OF code because the OF device table
entries are not exported as aliases

Before the patch:
$ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
alias:          platform:sun6i-a31-gpadc-iio
alias:          platform:sun5i-a13-gpadc-iio
alias:          platform:sun4i-a10-gpadc-iio

After the patch:
$ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
alias:          of:N*T*Callwinner,sun8i-a33-thsC*
alias:          of:N*T*Callwinner,sun8i-a33-ths
alias:          platform:sun6i-a31-gpadc-iio
alias:          platform:sun5i-a13-gpadc-iio
alias:          platform:sun4i-a10-gpadc-iio

Signed-off-by: Eduardo Molinas <edu.molinas@gmail.com>
---
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index c3d7ba100a48..1c83b45043bf 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -712,6 +712,7 @@ static struct platform_driver sun4i_gpadc_driver = {
 	.probe = sun4i_gpadc_probe,
 	.remove = sun4i_gpadc_remove,
 };
+MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_id);
 
 module_platform_driver(sun4i_gpadc_driver);
 
-- 
2.11.0

