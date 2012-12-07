Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:37235 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2LGPZO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Dec 2012 10:25:14 -0500
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/4] iio: mxs: Remove unused struct mxs_lradc_chan
Date: Fri,  7 Dec 2012 16:24:50 +0100
Message-Id: <1354893893-26338-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This structure definition seems to be some kind of remnant from
previous development that accidentally made it mainline. Remove
it as it's unused.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/staging/iio/adc/mxs-lradc.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index ca7c1fa..67abf50 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -75,11 +75,6 @@ static const char * const mxs_lradc_irq_name[] = {
 	"mxs-lradc-button1",
 };
 
-struct mxs_lradc_chan {
-	uint8_t				slot;
-	uint8_t				flags;
-};
-
 struct mxs_lradc {
 	struct device		*dev;
 	void __iomem		*base;
-- 
1.7.10.4

