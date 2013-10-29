Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33832 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab3J2Lmd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:33 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so8466181pdi.32
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:32 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 30/33] staging: iio: ade7854: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:53 +0530
Message-Id: <1383046796-329-31-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/meter/ade7854-i2c.c |    6 ------
 drivers/staging/iio/meter/ade7854-spi.c |    7 -------
 drivers/staging/iio/meter/ade7854.c     |   14 +-------------
 drivers/staging/iio/meter/ade7854.h     |    1 -
 4 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 5b33c7f..7d913cb 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -229,11 +229,6 @@ static int ade7854_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int ade7854_i2c_remove(struct i2c_client *client)
-{
-	return ade7854_remove(i2c_get_clientdata(client));
-}
-
 static const struct i2c_device_id ade7854_id[] = {
 	{ "ade7854", 0 },
 	{ "ade7858", 0 },
@@ -248,7 +243,6 @@ static struct i2c_driver ade7854_i2c_driver = {
 		.name = "ade7854",
 	},
 	.probe    = ade7854_i2c_probe,
-	.remove   = ade7854_i2c_remove,
 	.id_table = ade7854_id,
 };
 module_i2c_driver(ade7854_i2c_driver);
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 94f73bb..d6a155c 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -300,12 +300,6 @@ static int ade7854_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int ade7854_spi_remove(struct spi_device *spi)
-{
-	ade7854_remove(spi_get_drvdata(spi));
-
-	return 0;
-}
 static const struct spi_device_id ade7854_id[] = {
 	{ "ade7854", 0 },
 	{ "ade7858", 0 },
@@ -321,7 +315,6 @@ static struct spi_driver ade7854_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ade7854_spi_probe,
-	.remove = ade7854_spi_remove,
 	.id_table = ade7854_id,
 };
 module_spi_driver(ade7854_driver);
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index d620bbd..11a88ae 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -555,24 +555,12 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 	/* Get the device into a sane initial state */
 	ret = ade7854_initial_setup(indio_dev);
 	if (ret)
-		goto error_unreg_dev;
+		return ret;
 
 	return 0;
-
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
-	return ret;
 }
 EXPORT_SYMBOL(ade7854_probe);
 
-int ade7854_remove(struct iio_dev *indio_dev)
-{
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-EXPORT_SYMBOL(ade7854_remove);
-
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Energy Meter");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 0653457..fac6497 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -169,6 +169,5 @@ struct ade7854_state {
 };
 
 extern int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
-extern int ade7854_remove(struct iio_dev *indio_dev);
 
 #endif
-- 
1.7.9.5

