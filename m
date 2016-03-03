Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34042 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcCCMwE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2016 07:52:04 -0500
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] iio: adc: imx25-gcq: fix do_div
Date: Thu,  3 Mar 2016 18:21:53 +0530
Message-Id: <1457009513-7069-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We are getting build failure with tilepro allmodconfig with the error:

drivers/iio/adc/fsl-imx25-gcq.c:236:4: note: in expansion of macro 'do_div'
do_div(priv->channel_vref_mv[reg], 1000);
    ^

include/asm-generic/div64.h:198:17: note: expected 'uint64_t *
	{aka long long unsigned int *}' but argument is of type 'u32 *
	{aka unsigned int *}'

Create a temporary variable of type u64 and use that in do_div.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

tilepro allmodconfig build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/113325889

 drivers/iio/adc/fsl-imx25-gcq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 2fd1927..e0636d4 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -174,6 +174,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	unsigned int refp_used[4] = {};
 	int ret, i;
+	u64 temp;
 
 	/*
 	 * Setup all configurations registers with a default conversion
@@ -233,7 +234,9 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			priv->channel_vref_mv[reg] =
 				regulator_get_voltage(priv->vref[refp]);
 			/* Conversion from uV to mV */
-			do_div(priv->channel_vref_mv[reg], 1000);
+			temp = priv->channel_vref_mv[reg];
+			do_div(temp, 1000);
+			priv->channel_vref_mv[reg] = temp;
 			break;
 		case MX25_ADC_REFP_INT:
 			priv->channel_vref_mv[reg] = 2500;
-- 
1.9.1

