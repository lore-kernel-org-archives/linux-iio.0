Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47165 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3IXLtO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 07:49:14 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so4492343pdj.11
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2013 04:49:14 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 1/1] iio: amplifiers: ad8366: Remove regulator_put
Date: Tue, 24 Sep 2013 17:19:10 +0530
Message-Id: <1380023350-25116-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since devm_regulator_get is used, regulator_put should not be
used. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/amplifiers/ad8366.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d0a79a4..ba6f6a9 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -185,10 +185,8 @@ static int ad8366_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 
-	if (!IS_ERR(reg)) {
+	if (!IS_ERR(reg))
 		regulator_disable(reg);
-		regulator_put(reg);
-	}
 
 	return 0;
 }
-- 
1.7.9.5

