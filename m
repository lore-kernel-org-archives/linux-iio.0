Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38380 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab3J2LlX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:23 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so6863729pad.41
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:22 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 03/33] iio: accel: kxsd9: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:26 +0530
Message-Id: <1383046796-329-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/accel/kxsd9.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index d72118d..877ae67 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -243,14 +243,7 @@ static int kxsd9_probe(struct spi_device *spi)
 	spi_setup(spi);
 	kxsd9_power_up(st);
 
-	return iio_device_register(indio_dev);
-}
-
-static int kxsd9_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id kxsd9_id[] = {
@@ -265,7 +258,6 @@ static struct spi_driver kxsd9_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = kxsd9_probe,
-	.remove = kxsd9_remove,
 	.id_table = kxsd9_id,
 };
 module_spi_driver(kxsd9_driver);
-- 
1.7.9.5

