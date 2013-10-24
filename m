Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 9/9] iio: light: vcnl4000: Remove redundant code
Date: Thu, 24 Oct 2013 17:23:35 +0530
Message-Id: <1382615615-20153-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The if check is redundant as the value obtained from
iio_device_register() is already in the required format.
Hence return the function directly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/light/vcnl4000.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 2bb3042..ecb3341 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -179,11 +179,7 @@ static int vcnl4000_probe(struct i2c_client *client,
 	indio_dev->name = VCNL4000_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return iio_device_register(indio_dev);
 }
 
 static int vcnl4000_remove(struct i2c_client *client)
-- 
1.7.9.5
