Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org,
	Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/1] staging: iio: ade7854-spi: Fix return value
Date: Wed, 11 Sep 2013 15:02:58 +0530
Message-Id: <1378891978-3819-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

ade7854_probe can fail. Return the value obtained from it
instead of 0 (success).

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/meter/ade7854-spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index a802cf2..4c6d204 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -299,7 +299,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
 	if (ret)
 		iio_device_free(indio_dev);
 
-	return 0;
+	return ret;
 }
 
 static int ade7854_spi_remove(struct spi_device *spi)
-- 
1.7.9.5
