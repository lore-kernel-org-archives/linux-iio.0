Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 7/9] iio: dac: max517: Remove redundant variable
Date: Thu, 24 Oct 2013 17:23:33 +0530
Message-Id: <1382615615-20153-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Remove an inconsequential print message and return directly
thereby eliminating an intermediate variable.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/max517.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index d26be14..6e19035 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -160,7 +160,6 @@ static int max517_probe(struct i2c_client *client,
 	struct max517_data *data;
 	struct iio_dev *indio_dev;
 	struct max517_platform_data *platform_data = client->dev.platform_data;
-	int err;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -192,13 +191,7 @@ static int max517_probe(struct i2c_client *client,
 		data->vref_mv[1] = platform_data->vref_mv[1];
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		return err;
-
-	dev_info(&client->dev, "DAC registered\n");
-
-	return 0;
+	return iio_device_register(indio_dev);
 }
 
 static int max517_remove(struct i2c_client *client)
-- 
1.7.9.5
