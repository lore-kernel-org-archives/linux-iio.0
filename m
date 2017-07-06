Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr50054.outbound.protection.outlook.com ([40.107.5.54]:12491
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751796AbdGFJIj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jul 2017 05:08:39 -0400
From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: vf610_adc: Fix VALT selection value for REFSEL bits
Date: Thu,  6 Jul 2017 10:06:41 +0100
Message-Id: <1499332001-8486-1-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In order to select the alternate voltage reference pair (VALTH/VALTL), the
right value for the REFSEL field in the ADCx_CFG register is "01", leading
to 0x800 as register mask. See section 8.2.6.4 in the reference manual[1].

[1] http://www.nxp.com/docs/en/reference-manual/VFXXXRM.pdf

Fixes: a775427632fd ("iio:adc:imx: add Freescale Vybrid vf610 adc driver")
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/iio/adc/vf610_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 01fc76f7d660..c168e0db329a 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -77,7 +77,7 @@
 #define VF610_ADC_ADSTS_MASK		0x300
 #define VF610_ADC_ADLPC_EN		0x80
 #define VF610_ADC_ADHSC_EN		0x400
-#define VF610_ADC_REFSEL_VALT		0x100
+#define VF610_ADC_REFSEL_VALT		0x800
 #define VF610_ADC_REFSEL_VBG		0x1000
 #define VF610_ADC_ADTRG_HARD		0x2000
 #define VF610_ADC_AVGS_8		0x4000
-- 
1.9.1

