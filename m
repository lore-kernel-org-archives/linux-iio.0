Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 13/32] staging: iio: adis16220: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:49 +0530
Message-Id: <1380106208-6948-14-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/accel/adis16220_core.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 5c28961..0e30629 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -443,13 +443,13 @@ static int adis16220_probe(struct spi_device *spi)
 	indio_dev->channels = adis16220_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16220_channels);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
 
 	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	if (ret)
-		goto error_unregister_dev;
+		return ret;
 
 	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	if (ret)
@@ -474,8 +474,6 @@ error_rm_adc1_bin:
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 error_rm_accel_bin:
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
-error_unregister_dev:
-	iio_device_unregister(indio_dev);
 	return ret;
 }
 
@@ -486,7 +484,6 @@ static int adis16220_remove(struct spi_device *spi)
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
-	iio_device_unregister(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
