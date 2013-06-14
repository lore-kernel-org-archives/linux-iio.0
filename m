Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1075 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751294Ab3FNP6Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2013 11:58:25 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] staging:iio:ad7291: Remove unnecessary dev_info() from probe()
Date: Fri, 14 Jun 2013 17:58:24 +0200
Message-Id: <1371225508-32190-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-1-git-send-email-lars@metafoo.de>
References: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

No need spam the log during probe if nothing went wrong.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 782e100..5bb1963 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -628,9 +628,6 @@ static int ad7291_probe(struct i2c_client *client,
 	if (ret)
 		goto error_unreg_irq;
 
-	dev_info(&client->dev, "%s ADC registered.\n",
-			 id->name);
-
 	return 0;
 
 error_unreg_irq:
-- 
1.8.0

