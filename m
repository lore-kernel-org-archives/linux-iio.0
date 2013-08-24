Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:62173 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab3HXTYo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Aug 2013 15:24:44 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so1917383pbb.34
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2013 12:24:44 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 2/3] staging: iio: ad7152: Use devm_iio_device_alloc
Date: Sun, 25 Aug 2013 00:54:28 +0530
Message-Id: <1377372269-4978-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377372269-4978-1-git-send-email-sachin.kamat@linaro.org>
References: <1377372269-4978-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/cdc/ad7152.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 1d7c528..f2c309d 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -481,11 +481,9 @@ static int ad7152_probe(struct i2c_client *client,
 	struct ad7152_chip_info *chip;
 	struct iio_dev *indio_dev;
 
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
@@ -506,16 +504,11 @@ static int ad7152_probe(struct i2c_client *client,
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	dev_err(&client->dev, "%s capacitive sensor registered\n", id->name);
 
 	return 0;
-
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 
 static int ad7152_remove(struct i2c_client *client)
@@ -523,7 +516,6 @@ static int ad7152_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

