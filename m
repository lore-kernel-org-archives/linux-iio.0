Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36372 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbdAVQgT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 11:36:19 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so11491683pgf.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Jan 2017 08:36:19 -0800 (PST)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: common: ssp_sensors: accel: use devm_iio_device_register()
Date: Sun, 22 Jan 2017 16:36:12 +0000
Message-Id: <20170122163612.27084-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Use devm_iio_device_register() for IIO subsystem device
registration and delete the remove function since there
is no need after this change.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/accel/ssp_accel_sensor.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
index 6b54008..dd6ece8 100644
--- a/drivers/iio/accel/ssp_accel_sensor.c
+++ b/drivers/iio/accel/ssp_accel_sensor.c
@@ -136,7 +136,7 @@ static int ssp_accel_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -146,21 +146,11 @@ static int ssp_accel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ssp_accel_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static struct platform_driver ssp_accel_driver = {
 	.driver = {
 		.name = SSP_ACCEL_NAME,
 	},
 	.probe = ssp_accel_probe,
-	.remove =  ssp_accel_remove,
 };
 
 module_platform_driver(ssp_accel_driver);

