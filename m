Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 8/9] iio: dac: mcp4725: Remove redundant code
Date: Thu, 24 Oct 2013 17:23:34 +0530
Message-Id: <1382615615-20153-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Remove an inconsequential print message and return directly
thereby cleaning up some code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/mcp4725.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index d982752..9f57ae8 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -320,13 +320,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	data->powerdown_mode = pd ? pd-1 : 2; /* 500kohm_to_gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		return err;
-
-	dev_info(&client->dev, "MCP4725 DAC registered\n");
-
-	return 0;
+	return iio_device_register(indio_dev);
 }
 
 static int mcp4725_remove(struct i2c_client *client)
-- 
1.7.9.5
