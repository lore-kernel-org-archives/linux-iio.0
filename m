Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:56546
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755641AbdABMp6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 07:45:58 -0500
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Markus Pargmann <mpa@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Carikli <denis@eukrea.com>
Subject: [PATCH] iio: adc: imx25-gcq: Fix module autoload
Date: Mon,  2 Jan 2017 09:45:45 -0300
Message-Id: <1483361146-913-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/iio/adc/fsl-imx25-gcq.ko | grep alias
$

After this patch:

$ modinfo drivers/iio/adc/fsl-imx25-gcq.ko | grep alias
alias:          of:N*T*Cfsl,imx25-gcqC*
alias:          of:N*T*Cfsl,imx25-gcq

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/adc/fsl-imx25-gcq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 72b32c1ab257..ea264fa9e567 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -401,6 +401,7 @@ static const struct of_device_id mx25_gcq_ids[] = {
 	{ .compatible = "fsl,imx25-gcq", },
 	{ /* Sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, mx25_gcq_ids);
 
 static struct platform_driver mx25_gcq_driver = {
 	.driver		= {
-- 
2.7.4

