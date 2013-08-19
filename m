Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 04/14] iio: dac: ad5421: Use devm_* APIs
Date: Mon, 19 Aug 2013 17:08:15 +0530
Message-Id: <1376912305-6423-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5421.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 98f2440..1f78b14 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -451,7 +451,7 @@ static int ad5421_probe(struct spi_device *spi)
 	struct ad5421_state *st;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(&spi->dev, "Failed to allocate iio device\n");
 		return  -ENOMEM;
@@ -484,31 +484,23 @@ static int ad5421_probe(struct spi_device *spi)
 	ad5421_update_ctrl(indio_dev, 0, 0);
 
 	if (spi->irq) {
-		ret = request_threaded_irq(spi->irq,
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
 					   NULL,
 					   ad5421_fault_handler,
 					   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					   "ad5421 fault",
 					   indio_dev);
 		if (ret)
-			goto error_free;
+			return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
-		goto error_free_irq;
+		return ret;
 	}
 
 	return 0;
-
-error_free_irq:
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
-error_free:
-	iio_device_free(indio_dev);
-
-	return ret;
 }
 
 static int ad5421_remove(struct spi_device *spi)
@@ -516,9 +508,6 @@ static int ad5421_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
