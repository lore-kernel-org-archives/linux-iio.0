Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36396 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdFTTwV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jun 2017 15:52:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so20111956wrb.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Jun 2017 12:52:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 5/5] iio: gyro: st_gyro_spi: add OF capability to st_gyro_spi
Date: Tue, 20 Jun 2017 21:52:12 +0200
Message-Id: <20170620195212.23213-6-lorenzo.bianconi@st.com>
In-Reply-To: <20170620195212.23213-1-lorenzo.bianconi@st.com>
References: <20170620195212.23213-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree support for L3GD20H gyroscope sensor

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/gyro/st_gyro_spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index fa14d8f2170d..e49dd2c923ab 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -18,6 +18,19 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_gyro.h"
 
+#ifdef CONFIG_OF
+static const struct of_device_id st_gyro_of_match[] = {
+	{
+		.compatible = "st,l3gd20h-gyro",
+		.data = L3GD20H_GYRO_DEV_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_gyro_of_match);
+#else
+#define st_gyro_of_match	NULL
+#endif
+
 static int st_gyro_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -30,6 +43,8 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 
 	gdata = iio_priv(indio_dev);
 
+	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
+				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
 	err = st_gyro_common_probe(indio_dev);
@@ -63,6 +78,7 @@ MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
 static struct spi_driver st_gyro_driver = {
 	.driver = {
 		.name = "st-gyro-spi",
+		.of_match_table = of_match_ptr(st_gyro_of_match),
 	},
 	.probe = st_gyro_spi_probe,
 	.remove = st_gyro_spi_remove,
-- 
2.13.1

