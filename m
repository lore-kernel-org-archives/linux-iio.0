Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Stefan Roese <sr@denx.de>
Subject: [PATCH v2 1/3] staging:iio:spear_adc: Fix sparse warning
Date: Sat, 12 Oct 2013 15:55:57 +0200
Message-Id: <1381586159-31120-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The driver is casting from one __iomem pointer to another. Make sure to include
__iomem in the cast, otherwise sparse will complain with the following warning:

	drivers/staging/iio/adc/spear_adc.c:321:18: warning: cast removes address space of expression
	drivers/staging/iio/adc/spear_adc.c:320:33: warning: incorrect type in assignment (different address spaces)
	drivers/staging/iio/adc/spear_adc.c:320:33:    expected struct adc_regs_spear3xx [noderef] <asn:2>*adc_base_spear3xx
	drivers/staging/iio/adc/spear_adc.c:320:33:    got struct adc_regs_spear3xx *<noident>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stefan Roese <sr@denx.de>
---
New in v2
---
 drivers/staging/iio/adc/spear_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index fc99598..e6555b6 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -318,7 +318,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	info->adc_base_spear3xx =
-		(struct adc_regs_spear3xx *)info->adc_base_spear6xx;
+		(struct adc_regs_spear3xx __iomem *)info->adc_base_spear6xx;
 
 	info->clk = clk_get(dev, NULL);
 	if (IS_ERR(info->clk)) {
-- 
1.8.0
