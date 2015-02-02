Return-Path: <hofrat@osadl.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Fabio Estevam <fabio.estevam@freescale.com>,
        Fugang Duan <B38611@freescale.com>,
        Sanjeev Sharma <sanjeev_sharma@mentor.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/3] iio: vf610_adc: cleanup wait_for_completion return handling
Date: Mon,  2 Feb 2015 03:35:20 -0500
Message-Id: <1422866120-10442-1-git-send-email-hofrat@osadl.org>
List-ID: <linux-iio@vger.kernel.org>

return type of wait_for_completion_timeout is unsigned long not int, this
patch only fixes up the return handling.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
 drivers/iio/adc/vf610_adc.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Rather than changing timeout to unsigned long it can be moved into the
if condition and dropped.

Patch was compile tested only for imx_v6_v7_defconfig + CONFIG_IIO=m,
CONFIG_VF610_ADC=m

Patch is against 3.19.0-rc6 -next-20150130

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 8ec353c..5b72d17 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -259,7 +259,6 @@ static void vf610_adc_cfg_post_set(struct vf610_adc *info)
 static void vf610_adc_calibration(struct vf610_adc *info)
 {
 	int adc_gc, hc_cfg;
-	int timeout;
 
 	if (!info->adc_feature.calibration)
 		return;
@@ -271,9 +270,7 @@ static void vf610_adc_calibration(struct vf610_adc *info)
 	adc_gc = readl(info->regs + VF610_REG_ADC_GC);
 	writel(adc_gc | VF610_ADC_CAL, info->regs + VF610_REG_ADC_GC);
 
-	timeout = wait_for_completion_timeout
-			(&info->completion, VF610_ADC_TIMEOUT);
-	if (timeout == 0)
+	if (!wait_for_completion_timeout(&info->completion, VF610_ADC_TIMEOUT))
 		dev_err(info->dev, "Timeout for adc calibration\n");
 
 	adc_gc = readl(info->regs + VF610_REG_ADC_GS);
-- 
1.7.10.4
