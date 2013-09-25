Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 03/32] iio: adc: mcp3422: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:39 +0530
Message-Id: <1380106208-6948-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/mcp3422.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index bc93f53..f172c29 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -361,7 +361,7 @@ static int mcp3422_probe(struct i2c_client *client,
 		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
 	mcp3422_update_config(adc, config);
 
-	err = iio_device_register(indio_dev);
+	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err < 0)
 		return err;
 
@@ -370,12 +370,6 @@ static int mcp3422_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int mcp3422_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-	return 0;
-}
-
 static const struct i2c_device_id mcp3422_id[] = {
 	{ "mcp3422", 2 },
 	{ "mcp3423", 3 },
@@ -399,7 +393,6 @@ static struct i2c_driver mcp3422_driver = {
 		.of_match_table = of_match_ptr(mcp3422_of_match),
 	},
 	.probe = mcp3422_probe,
-	.remove = mcp3422_remove,
 	.id_table = mcp3422_id,
 };
 module_i2c_driver(mcp3422_driver);
-- 
1.7.9.5
