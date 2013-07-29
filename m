Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:50797 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab3G2WSf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 29 Jul 2013 18:18:35 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/3] iio:mcp4725: Use devm_iio_device_alloc
Date: Tue, 30 Jul 2013 00:18:31 +0200
Message-Id: <1375136311-8523-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375136311-8523-1-git-send-email-pmeerw@pmeerw.net>
References: <1375136311-8523-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/dac/mcp4725.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 18a78cd..1f4a48e 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -292,15 +292,12 @@ static int mcp4725_probe(struct i2c_client *client,
 
 	if (!platform_data || !platform_data->vref_mv) {
 		dev_err(&client->dev, "invalid platform data");
-		err = -EINVAL;
-		goto exit;
+		return -EINVAL;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*data));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (indio_dev == NULL)
+		return -ENOMEM;
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
@@ -317,7 +314,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	err = i2c_master_recv(client, inbuf, 3);
 	if (err < 0) {
 		dev_err(&client->dev, "failed to read DAC value");
-		goto exit_free_device;
+		return err;
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
 	data->powerdown = pd > 0 ? true : false;
@@ -326,25 +323,16 @@ static int mcp4725_probe(struct i2c_client *client,
 
 	err = iio_device_register(indio_dev);
 	if (err)
-		goto exit_free_device;
+		return err;
 
 	dev_info(&client->dev, "MCP4725 DAC registered\n");
 
 	return 0;
-
-exit_free_device:
-	iio_device_free(indio_dev);
-exit:
-	return err;
 }
 
 static int mcp4725_remove(struct i2c_client *client)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_device_free(indio_dev);
-
+	iio_device_unregister(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.8.3.4

