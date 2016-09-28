Return-Path: <ico@pruts.nl>
From: Ico Doornekamp <ico@pruts.nl>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Ico Doornekamp <ico@pruts.nl>
Subject: [PATCH] io: adc: ad7606_core: fix signed/unsigned number comparison
Date: Wed, 28 Sep 2016 15:41:49 +0200
Message-Id: <20160928134149.2563-1-ico@pruts.nl>
List-ID: <linux-iio@vger.kernel.org>

reported by 'make W=2' in ad7606_oversampling_get_index()

Signed-off-by: Ico Doornekamp <ico@pruts.nl>
---
 drivers/staging/iio/adc/ad7606_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index f79ee61..681389a 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -158,7 +158,7 @@ static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
 static int ad7606_oversampling_get_index(unsigned int val)
 {
 	unsigned char supported[] = {0, 2, 4, 8, 16, 32, 64};
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(supported); i++)
 		if (val == supported[i])
-- 
2.9.3
