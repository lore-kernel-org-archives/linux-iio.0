Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 2/4] iio: accel: kxsd9: Use devm_iio_device_alloc
Date: Tue, 23 Jul 2013 12:17:08 +0530
Message-Id: <1374562030-28621-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374562030-28621-1-git-send-email-sachin.kamat@linaro.org>
References: <1374562030-28621-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/accel/kxsd9.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 7229645..709c132 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -224,11 +224,10 @@ static int kxsd9_probe(struct spi_device *spi)
 	struct kxsd9_state *st;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
@@ -247,20 +246,14 @@ static int kxsd9_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	return 0;
-
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 
 static int kxsd9_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.9.5
