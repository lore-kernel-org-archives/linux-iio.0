Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33150 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdFVR5p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Jun 2017 13:57:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id x23so6457003wrb.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Jun 2017 10:57:44 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH] iio: pressure: st_pressure_spi: add OF capability to st_pressure_spi
Date: Thu, 22 Jun 2017 19:57:42 +0200
Message-Id: <20170622175742.25696-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree support for LPS22HB pressure sensor

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/pressure/st_pressure_spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 550508025af1..6dde7cc3e999 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -18,6 +18,19 @@
 #include <linux/iio/common/st_sensors_spi.h>
 #include "st_pressure.h"
 
+#ifdef CONFIG_OF
+static const struct of_device_id st_press_of_match[] = {
+	{
+		.compatible = "st,lps22hb-press",
+		.data = LPS22HB_PRESS_DEV_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_press_of_match);
+#else
+#define st_press_of_match	NULL
+#endif
+
 static int st_press_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -30,6 +43,8 @@ static int st_press_spi_probe(struct spi_device *spi)
 
 	press_data = iio_priv(indio_dev);
 
+	st_sensors_of_name_probe(&spi->dev, st_press_of_match,
+				 spi->modalias, sizeof(spi->modalias));
 	st_sensors_spi_configure(indio_dev, spi, press_data);
 
 	err = st_press_common_probe(indio_dev);
@@ -58,6 +73,7 @@ MODULE_DEVICE_TABLE(spi, st_press_id_table);
 static struct spi_driver st_press_driver = {
 	.driver = {
 		.name = "st-press-spi",
+		.of_match_table = of_match_ptr(st_press_of_match),
 	},
 	.probe = st_press_spi_probe,
 	.remove = st_press_spi_remove,
-- 
2.13.1

