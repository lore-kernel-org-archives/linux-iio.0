Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40425 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3J2Lll (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id rd3so8370440pab.19
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:41 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 10/33] iio: dac: mcp4725: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:33 +0530
Message-Id: <1383046796-329-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/mcp4725.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 9f57ae8..0aa921b 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -320,13 +320,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	data->powerdown_mode = pd ? pd-1 : 2; /* 500kohm_to_gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
-	return iio_device_register(indio_dev);
-}
-
-static int mcp4725_remove(struct i2c_client *client)
-{
-	iio_device_unregister(i2c_get_clientdata(client));
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id mcp4725_id[] = {
@@ -341,7 +335,6 @@ static struct i2c_driver mcp4725_driver = {
 		.pm	= MCP4725_PM_OPS,
 	},
 	.probe		= mcp4725_probe,
-	.remove		= mcp4725_remove,
 	.id_table	= mcp4725_id,
 };
 module_i2c_driver(mcp4725_driver);
-- 
1.7.9.5

