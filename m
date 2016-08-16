Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/17] iio: accel: kxsd9: Use devm_iio_device_register()
Date: Tue, 16 Aug 2016 15:33:30 +0200
Message-Id: <1471354423-19186-5-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This gives us less to keep track of when removing the driver
and simplifies the code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 094071306e42..d3e87eef2594 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -220,8 +220,7 @@ static const struct iio_info kxsd9_info = {
 
 static int kxsd9_common_probe(struct device *parent,
 			      struct kxsd9_transport *transport,
-			      const char *name,
-			      struct iio_dev **retdev)
+			      const char *name)
 {
 	struct iio_dev *indio_dev;
 	struct kxsd9_state *st;
@@ -244,11 +243,10 @@ static int kxsd9_common_probe(struct device *parent,
 
 	kxsd9_power_up(st);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(parent, indio_dev);
 	if (ret)
 		return ret;
 
-	*retdev = indio_dev;
 	return 0;
 }
 
@@ -295,7 +293,6 @@ int kxsd9_spi_readval(struct kxsd9_transport *tr, u8 address)
 static int kxsd9_spi_probe(struct spi_device *spi)
 {
 	struct kxsd9_transport *transport;
-	struct iio_dev *indio_dev;
 	int ret;
 
 	transport = devm_kzalloc(&spi->dev, sizeof(*transport), GFP_KERNEL);
@@ -311,19 +308,10 @@ static int kxsd9_spi_probe(struct spi_device *spi)
 
 	ret = kxsd9_common_probe(&spi->dev,
 				 transport,
-				 spi_get_device_id(spi)->name,
-				 &indio_dev);
+				 spi_get_device_id(spi)->name);
 	if (ret)
 		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
-	return 0;
-}
-
-static int kxsd9_spi_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
 	return 0;
 }
 
@@ -338,7 +326,6 @@ static struct spi_driver kxsd9_spi_driver = {
 		.name = "kxsd9",
 	},
 	.probe = kxsd9_spi_probe,
-	.remove = kxsd9_spi_remove,
 	.id_table = kxsd9_spi_id,
 };
 module_spi_driver(kxsd9_spi_driver);
-- 
2.7.4
