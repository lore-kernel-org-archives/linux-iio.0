Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-am1on0140.outbound.protection.outlook.com ([157.56.112.140]:52676
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932232AbcBBO3w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2016 09:29:52 -0500
From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
	"mranostay@gmail.com" <mranostay@gmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>
CC: "ciorneiioana@gmail.com" <ciorneiioana@gmail.com>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Babu, Viswanathan (V.)" <vbabu3@visteon.com>
Subject: [PATCHv3] staging: iio: replace clk_get() with devm_clk_get()
Date: Tue, 2 Feb 2016 12:56:32 +0000
Message-ID: <20160202125741.GA9279@IND12F0122>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces the clk_get() with devm_clk_get().Accordingly,modified
the error paths,rename error labels and removed clk_put() in probe() &
remove functions.

Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
---
	v3: Rename error path labels to suite modified code as reviewd
	    by Matt Ranostay.
	    Remove clk_put() from the driver remove method as pointed by
	    Jonathan Cameron.

	v2: From email address was missing as pointed by Dan Carpenter.
---
 drivers/staging/iio/adc/spear_adc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 712cae0..f2c0065 100644
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
@@ -297,28 +297,28 @@ static int spear_adc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(st->clk);
 	if (ret) {
 		dev_err(dev, "failed enabling clock\n");
-		goto errout2;
+		goto errout1;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(dev, "failed getting interrupt resource\n");
 		ret = -EINVAL;
-		goto errout3;
+		goto errout2;
 	}
 
 	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
 			       st);
 	if (ret < 0) {
 		dev_err(dev, "failed requesting interrupt\n");
-		goto errout3;
+		goto errout2;
 	}
 
 	if (of_property_read_u32(np, "sampling-frequency",
 				 &st->sampling_freq)) {
 		dev_err(dev, "sampling-frequency missing in DT\n");
 		ret = -EINVAL;
-		goto errout3;
+		goto errout2;
 	}
 
 	/*
@@ -348,16 +348,14 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto errout3;
+		goto errout2;
 
 	dev_info(dev, "SPEAR ADC driver loaded, IRQ %d\n", irq);
 
 	return 0;
 
-errout3:
-	clk_disable_unprepare(st->clk);
 errout2:
-	clk_put(st->clk);
+	clk_disable_unprepare(st->clk);
 errout1:
 	iounmap(st->adc_base_spear6xx);
 	return ret;
@@ -370,7 +368,6 @@ static int spear_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	clk_disable_unprepare(st->clk);
-	clk_put(st->clk);
 	iounmap(st->adc_base_spear6xx);
 
 	return 0;
-- 
1.9.1
