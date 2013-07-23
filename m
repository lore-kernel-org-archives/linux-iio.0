Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 06/11] iio: adc: ad7923: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:12 +0530
Message-Id: <1374569897-3858-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/iio/adc/ad7923.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 97fa0d3..4108dbb 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -275,10 +275,11 @@ static const struct iio_info ad7923_info = {
 static int ad7923_probe(struct spi_device *spi)
 {
 	struct ad7923_state *st;
-	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
+	struct iio_dev *indio_dev;
 	const struct ad7923_chip_info *info;
 	int ret;
 
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -311,14 +312,13 @@ static int ad7923_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->scan_single_xfer[0], &st->scan_single_msg);
 	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
 
-	st->reg = regulator_get(&spi->dev, "refin");
-	if (IS_ERR(st->reg)) {
-		ret = PTR_ERR(st->reg);
-		goto error_free;
-	}
+	st->reg = devm_regulator_get(&spi->dev, "refin");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
 	ret = regulator_enable(st->reg);
 	if (ret)
-		goto error_put_reg;
+		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 			&ad7923_trigger_handler, NULL);
@@ -335,10 +335,6 @@ error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
 	regulator_disable(st->reg);
-error_put_reg:
-	regulator_put(st->reg);
-error_free:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -351,8 +347,6 @@ static int ad7923_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(st->reg);
-	regulator_put(st->reg);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
