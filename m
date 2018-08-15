Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34682 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOX3P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 19:29:15 -0400
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@vger.kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 1/7] iio: chemical: bme680: use clamp macro
Date: Wed, 15 Aug 2018 13:38:29 -0700
Message-Id: <20180815203835.21079-2-dpfrey@gmail.com>
In-Reply-To: <20180815203835.21079-1-dpfrey@gmail.com>
References: <20180815203835.21079-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7d9bb62baa3f..b4c012bc0a82 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -408,10 +408,7 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 	var6 = (var4 * var5) >> 1;
 	calc_hum = (((var3 + var6) >> 10) * 1000) >> 12;
 
-	if (calc_hum > 100000) /* Cap at 100%rH */
-		calc_hum = 100000;
-	else if (calc_hum < 0)
-		calc_hum = 0;
+	calc_hum = clamp(calc_hum, 0, 100000); /* clamp between 0-100 %rH */
 
 	return calc_hum;
 }
-- 
2.11.0
