Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-124.synserver.de ([212.40.185.124]:1077 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab2JROmG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2012 10:42:06 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 2/4] staging:iio:lpc32xx_adc: Use resource_size instead of opencoding it
Date: Thu, 18 Oct 2012 16:43:17 +0200
Message-Id: <1350571399-17723-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1350571399-17723-1-git-send-email-lars@metafoo.de>
References: <1350571399-17723-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following error from coccicheck:
	drivers/staging/iio/adc/lpc32xx_adc.c:153:43-46: ERROR: Missing resource_size with res

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Roland Stigge <stigge@antcom.de>
---
 drivers/staging/iio/adc/lpc32xx_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 7e9bd00..10c5962 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -150,7 +150,7 @@ static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
 
 	info = iio_priv(iodev);
 
-	info->adc_base = ioremap(res->start, res->end - res->start + 1);
+	info->adc_base = ioremap(res->start, resource_size(res));
 	if (!info->adc_base) {
 		dev_err(&pdev->dev, "failed mapping memory\n");
 		retval = -EBUSY;
-- 
1.7.10.4

