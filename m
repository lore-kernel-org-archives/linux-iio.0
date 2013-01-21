Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59484 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab3AUKJs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2013 05:09:48 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: [PATCH 11/33] iio: Convert to devm_ioremap_resource()
Date: Mon, 21 Jan 2013 11:09:04 +0100
Message-Id: <1358762966-20791-12-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/adc/at91_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a526c0e..83c836b 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -557,9 +557,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	st->reg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!st->reg_base) {
-		ret = -ENOMEM;
+	st->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(st->reg_base)) {
+		ret = PTR_ERR(st->reg_base);
 		goto error_free_device;
 	}
 
-- 
1.8.1.1

