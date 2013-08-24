Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37040 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab3HXTYr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Aug 2013 15:24:47 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so1939408pdj.1
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2013 12:24:47 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 3/3] staging: iio: ad7746: Use devm_iio_device_alloc
Date: Sun, 25 Aug 2013 00:54:29 +0530
Message-Id: <1377372269-4978-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377372269-4978-1-git-send-email-sachin.kamat@linaro.org>
References: <1377372269-4978-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/cdc/ad7746.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 94f9ca7..75a533b 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -699,11 +699,9 @@ static int ad7746_probe(struct i2c_client *client,
 	int ret = 0;
 	unsigned char regval = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
@@ -748,20 +746,15 @@ static int ad7746_probe(struct i2c_client *client,
 	ret = i2c_smbus_write_byte_data(chip->client,
 					AD7746_REG_EXC_SETUP, regval);
 	if (ret < 0)
-		goto error_free_dev;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	dev_info(&client->dev, "%s capacitive sensor registered\n", id->name);
 
 	return 0;
-
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 
 static int ad7746_remove(struct i2c_client *client)
@@ -769,7 +762,6 @@ static int ad7746_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

