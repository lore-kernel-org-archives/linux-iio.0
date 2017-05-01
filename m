Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36533 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdEAWrh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 18:47:37 -0400
From: Eduardo Molinas <edu.molinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eduardo Molinas <edu.molinas@gmail.com>
Subject: [PATCH 1/2] [PATCH 1/2] iio: adc: sun4i-gpadc-iio: Fix module autoload when PLATFORM devices are registered
Date: Mon,  1 May 2017 18:45:58 -0400
Message-Id: <20170501224559.21028-1-edu.molinas@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the driver is built as a module, it won't be autloaded if the devices
are registered via PLATFORM code because the PLATFORM device table
entries are not exported as aliases

Before the patch:
$ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
$

After th patch:
$ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
alias:          platform:sun6i-a31-gpadc-iio
alias:          platform:sun5i-a13-gpadc-iio
alias:          platform:sun4i-a10-gpadc-iio

Signed-off-by: Eduardo Molinas <edu.molinas@gmail.com>
---
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index b23527309088..c3d7ba100a48 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -700,6 +700,7 @@ static const struct platform_device_id sun4i_gpadc_id[] = {
 	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(platform, sun4i_gpadc_id);
 
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
-- 
2.11.0

