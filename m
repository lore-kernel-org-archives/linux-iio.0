Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36654 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcHPMKn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 08:10:43 -0400
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH] iio: mxs-lradc: fix a possible NULL dereference
Date: Tue, 16 Aug 2016 14:10:38 +0200
Message-Id: <1471349438-16262-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

For fixing this problem, we use of_device_get_match_data(), this will
simplify the code a little by using a standard function for
getting the match data.

Reported-by: coverity (CID 1127209)
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/iio/adc/mxs-lradc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index b84d37c..378547c 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1570,10 +1570,7 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
 
 static int mxs_lradc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(mxs_lradc_dt_ids, &pdev->dev);
-	const struct mxs_lradc_of_config *of_cfg =
-		&mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
+	const struct mxs_lradc_of_config *of_cfg;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct mxs_lradc *lradc;
@@ -1591,7 +1588,8 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	}
 
 	lradc = iio_priv(iio);
-	lradc->soc = (enum mxs_lradc_id)of_id->data;
+	lradc->soc = (enum mxs_lradc_id)of_device_get_match_data(&pdev->dev);
+	of_cfg = &mxs_lradc_of_config[lradc->soc];
 
 	/* Grab the memory area */
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.7.3

