Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35015 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbbINQIy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2015 12:08:54 -0400
Date: Mon, 14 Sep 2015 21:38:49 +0530
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gyro: ssp_gyro_sensor: Use devm_iio_device_register
Message-ID: <20150914160849.GA21748@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use resourced managed function devm_iio_device_register to
make error path simpler. To be compatible with the change,
the remove function is removed as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/iio/gyro/ssp_gyro_sensor.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
index 0a8afdd..ac88de7 100644
--- a/drivers/iio/gyro/ssp_gyro_sensor.c
+++ b/drivers/iio/gyro/ssp_gyro_sensor.c
@@ -134,7 +134,7 @@ static int ssp_gyro_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -144,21 +144,11 @@ static int ssp_gyro_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ssp_gyro_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static struct platform_driver ssp_gyro_driver = {
 	.driver = {
 		.name = SSP_GYROSCOPE_NAME,
 	},
 	.probe = ssp_gyro_probe,
-	.remove = ssp_gyro_remove,
 };
 
 module_platform_driver(ssp_gyro_driver);
-- 
1.9.1

