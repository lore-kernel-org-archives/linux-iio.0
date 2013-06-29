Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50604 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3F2VU0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 17:20:26 -0400
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: otavio@ossystems.com.br, Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] iio: mxs-lradc: Fix misuse of iio->trig
Date: Sat, 29 Jun 2013 23:20:13 +0200
Message-Id: <1372540813-12540-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The struct iio_dev .trig field is to be used only by the IIO core,
the driver shall not fill this field. This fixes ugly crash when
the driver is compiled as a module and the module is rmmod'd.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/staging/iio/adc/mxs-lradc.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 55a459b..28e029a 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -664,12 +664,13 @@ static int mxs_lradc_trigger_init(struct iio_dev *iio)
 {
 	int ret;
 	struct iio_trigger *trig;
+	struct mxs_lradc *lradc = iio_priv(iio);
 
 	trig = iio_trigger_alloc("%s-dev%i", iio->name, iio->id);
 	if (trig == NULL)
 		return -ENOMEM;
 
-	trig->dev.parent = iio->dev.parent;
+	trig->dev.parent = lradc->dev;
 	trig->private_data = iio;
 	trig->ops = &mxs_lradc_trigger_ops;
 
@@ -679,15 +680,17 @@ static int mxs_lradc_trigger_init(struct iio_dev *iio)
 		return ret;
 	}
 
-	iio->trig = trig;
+	lradc->trig = trig;
 
 	return 0;
 }
 
 static void mxs_lradc_trigger_remove(struct iio_dev *iio)
 {
-	iio_trigger_unregister(iio->trig);
-	iio_trigger_free(iio->trig);
+	struct mxs_lradc *lradc = iio_priv(iio);
+
+	iio_trigger_unregister(lradc->trig);
+	iio_trigger_free(lradc->trig);
 }
 
 static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
-- 
1.7.10.4

