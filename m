Return-Path: <SRS0=axia=LA=gmail.com=dpfrey@kernel.org>
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	himanshujha199640@gmail.com,
	David Frey <dpfrey@gmail.com>
Subject: [PATCH v3 1/7] iio: chemical: bme680: use clamp macro
Date: Fri, 17 Aug 2018 12:03:13 -0700
Message-Id: <20180817190319.13119-2-dpfrey@gmail.com>
In-Reply-To: <20180817190319.13119-1-dpfrey@gmail.com>
References: <20180817190319.13119-1-dpfrey@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 36b83c851515..35cbcb16c9f9 100644
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
