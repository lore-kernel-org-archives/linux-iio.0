Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db3on0103.outbound.protection.outlook.com ([157.55.234.103]:32688
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751224AbcAUJnt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2016 04:43:49 -0500
From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"ciorneiioana@gmail.com" <ciorneiioana@gmail.com>,
	"hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>
CC: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: iio: replace clk_get() with devm_clk_get()
Date: Thu, 21 Jan 2016 09:11:38 +0000
Message-ID: <20160121091238.GA9430@IND12F0122>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Hari Prasath Gujulan Elango

This patch replaces the clk_get() with devm_clk_get().
Accordingly,modified the error paths and removed clk_put() as well.

Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
---
 drivers/staging/iio/adc/spear_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 712cae0..4ac0f54 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -288,7 +288,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	st->adc_base_spear3xx =
 		(struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
 
-	st->clk = clk_get(dev, NULL);
+	st->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(st->clk)) {
 		dev_err(dev, "failed getting clock\n");
 		goto errout1;
@@ -297,7 +297,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(st->clk);
 	if (ret) {
 		dev_err(dev, "failed enabling clock\n");
-		goto errout2;
+		goto errout1;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -356,8 +356,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 errout3:
 	clk_disable_unprepare(st->clk);
-errout2:
-	clk_put(st->clk);
 errout1:
 	iounmap(st->adc_base_spear6xx);
 	return ret;
-- 
1.9.1
