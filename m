Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 09/32] iio: dac: mcp4725: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:45 +0530
Message-Id: <1380106208-6948-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/mcp4725.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 6711a33..4759e25a 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -322,7 +322,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	data->powerdown_mode = pd ? pd-1 : 2; /* 500kohm_to_gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
-	err = iio_device_register(indio_dev);
+	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err)
 		return err;
 
@@ -331,12 +331,6 @@ static int mcp4725_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int mcp4725_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-	return 0;
-}
-
 static const struct i2c_device_id mcp4725_id[] = {
 	{ "mcp4725", 0 },
 	{ }
@@ -349,7 +343,6 @@ static struct i2c_driver mcp4725_driver = {
 		.pm	= MCP4725_PM_OPS,
 	},
 	.probe		= mcp4725_probe,
-	.remove		= mcp4725_remove,
 	.id_table	= mcp4725_id,
 };
 module_i2c_driver(mcp4725_driver);
-- 
1.7.9.5
