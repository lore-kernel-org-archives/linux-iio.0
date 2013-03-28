Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36702 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab3C1KNv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Mar 2013 06:13:51 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, jimwall@q.com,
	brian@crystalfontz.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH] iio: mxs-lradc: Do hardware initialization earlier
Date: Thu, 28 Mar 2013 11:13:03 +0100
Message-Id: <1364465583-19835-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We need to initialize hardware before registering the touchscreen. Else,
we end up setting registers in mxs_lradc_ts_open(), getting called just
after registering the touchscreen with input_register_device() and by
the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
correct configuration.

Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 55a459b..e927e3f 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -933,6 +933,9 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
 
+	/* Configure the hardware. */
+	mxs_lradc_hw_init(lradc);
+
 	/* Check if touchscreen is enabled in DT. */
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
 				&ts_wires);
@@ -995,9 +998,6 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 		goto err_ts;
 	}
 
-	/* Configure the hardware. */
-	mxs_lradc_hw_init(lradc);
-
 	return 0;
 
 err_ts:
-- 
1.7.10.4

