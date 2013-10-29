Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56078 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab3J2LlZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:25 -0400
Received: by mail-pd0-f182.google.com with SMTP id q10so8478895pdj.27
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:25 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 04/33] iio: adc: mcp3422: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:27 +0530
Message-Id: <1383046796-329-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/mcp3422.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 1294832..dbdbd77 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -362,7 +362,7 @@ static int mcp3422_probe(struct i2c_client *client,
 		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
 	mcp3422_update_config(adc, config);
 
-	err = iio_device_register(indio_dev);
+	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err < 0)
 		return err;
 
@@ -371,12 +371,6 @@ static int mcp3422_probe(struct i2c_client *client,
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
@@ -400,7 +394,6 @@ static struct i2c_driver mcp3422_driver = {
 		.of_match_table = of_match_ptr(mcp3422_of_match),
 	},
 	.probe = mcp3422_probe,
-	.remove = mcp3422_remove,
 	.id_table = mcp3422_id,
 };
 module_i2c_driver(mcp3422_driver);
-- 
1.7.9.5

