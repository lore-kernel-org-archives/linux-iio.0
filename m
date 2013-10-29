Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:42598 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab3J2Lmi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:38 -0400
Received: by mail-pb0-f42.google.com with SMTP id jt11so7870293pbb.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:38 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 32/33] staging: iio: ad2s90: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:55 +0530
Message-Id: <1383046796-329-33-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/resolver/ad2s90.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index e24c589..a18ebe2 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -79,7 +79,7 @@ static int ad2s90_probe(struct spi_device *spi)
 	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -91,13 +91,6 @@ static int ad2s90_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad2s90_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
-}
-
 static const struct spi_device_id ad2s90_id[] = {
 	{ "ad2s90" },
 	{}
@@ -110,7 +103,6 @@ static struct spi_driver ad2s90_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad2s90_probe,
-	.remove = ad2s90_remove,
 	.id_table = ad2s90_id,
 };
 module_spi_driver(ad2s90_driver);
-- 
1.7.9.5

